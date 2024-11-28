// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geofence_service/models/geofence_status.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xbridge/chat_page/presentation/screen/chat_page.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/service/database_service.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/geofence_helper.dart';
import 'package:xbridge/common/utils/helper_function.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/common/widgets/loader.dart';
import 'package:xbridge/location_update/controller/location_permission_bloc.dart';
import 'package:xbridge/task_details/controller/taskdetails_block.dart';
import 'package:xbridge/task_details/controller/taskdetails_event.dart';
import 'package:xbridge/task_details/controller/taskdetails_state.dart';
import 'package:xbridge/unassigned_visits/data/model/unassigned_task_entity.dart';

import '../../../common/constants/api_constant.dart';
import '../../../common/constants/globals.dart';
import '../../../common/constants/route_constants.dart';
import '../../../common/network/api_provider.dart';
import '../../../common/utils/shared_pref_helper.dart';
import '../../../main.dart';
import '../../data/models/case_detail_entity.dart';
import '../../data/models/task_field_engineer_entity.dart';
import '../screen/task_details.dart';

class TaskDetailsState extends State<TaskDetails> {
  // The selected field engineer for the task
  TaskFieldEngineerResultFieldEngineers? selectedEngineer;

  // Controller for handling refresh operations
  final RefreshController _refreshController = RefreshController();

  // Formatted date string representing the current date and time
  String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

  // Boolean flag to indicate if there's an error to be shown
  bool showError = false;

  // Boolean flag to indicate if location services are enabled
  bool isLocationEnabled = false;

  // Current position of the user and the field manager
  Position? currentPosition, fmCurrentLocation;

  // PolylinePoints instance for drawing polylines on the map
  PolylinePoints polylinePoints = PolylinePoints();

  // Result of the polyline generation
  PolylineResult? polyLineResult;

  // BitmapDescriptor for customizing the user's location marker on the map
  BitmapDescriptor userLocationMarker = BitmapDescriptor.defaultMarker;

  // Controller for the Google Map widget
  late GoogleMapController mapController;

  // Boolean flag to indicate if the task details are loading
  bool _isLoading = false;
  // Boolean flag to indicate if the task details are loading
  final bool _hideScheduleButton = false;

  // Stream for handling groups (could be used for real-time updates)
  Stream? groups;

  // Timer for scheduled tasks or updates
  Timer? _timer;

  // StreamSubscription for managing stream updates
  late StreamSubscription streamSubscription;

  // Snapshot of the current asynchronous operation
  late AsyncSnapshot snapshot;

  // AlertDialog for displaying a loading indicator
  late AlertDialog alertLoader;

  // Keys for wrapping widgets to avoid unnecessary rebuilds
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<SmartRefresherState> _refreshIndicatorKey = GlobalKey();

  @override
  void initState() {
    // Initialize location services
    initLocation();
    // Get field engineer map markers
    getFEMapMarker();
    // Get current locations of field engineer and field manager
    getFeAndFMCurrentLocation();
    super.initState();
  }

  void setupPolyLineForMap() async {
    // Adding a post-frame callback to ensure that the method runs after the current frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Getting the current state from the TaskDetailsBloc
      final state = context.read<TaskDetailsBloc>().state;

      // Checking if the state is TaskDetailsLoadedState
      if (state is TaskDetailslLoadedState) {
        // Extracting the task result from the state
        final result = state.response.result;

        // Logging the task details (assuming getJson is a method to log or process JSON data)
        getJson(result!.task!.toJson());

        // Parsing latitude and longitude for the task location
        double lat = double.tryParse(
              result.task?.caseRecord?.location?.latitude ?? "",
            ) ??
            0.0;
        double long = double.tryParse(
              result.task?.caseRecord?.location?.longitude ?? "",
            ) ??
            0.0;

        // Parsing latitude and longitude for the field engineer's last known location
        double feLat = double.tryParse(result.task?.uFeLastLatitude ?? "") ?? 0.0;
        double feLong = double.tryParse(result.task?.uFeLastLongitude ?? "") ?? 0.0;

        // Logging the task location
        logger.i("Task Location: ${PointLatLng(lat, long)}");

        // Checking if the user type is field manager (fm)
        if (userType == UserType.fm) {
          // If the field engineer's last known location is available
          if ((feLat != 0 && feLong != 0)) {
            // Logging the field engineer's location
            logger.i("FE Location: ${PointLatLng(feLat, feLong)}");

            // Getting the points between the task location and the field engineer's location
            polyLineResult = await getPointsBetweenCoordinates(
              origin: PointLatLng(lat, long),
              dest: PointLatLng(feLat, feLong),
            );
          }
        } else {
          // Logging the current position of the user
          logger.i(
            "Current Location: ${PointLatLng(currentPosition?.latitude ?? 0.0, currentPosition?.longitude ?? 0.0)}",
          );

          // Getting the points between the task location and the current user location
          polyLineResult = await getPointsBetweenCoordinates(
            origin: PointLatLng(lat, long),
            dest: PointLatLng(
              currentPosition?.latitude ?? 0.0,
              currentPosition?.longitude ?? 0.0,
            ),
          );
        }
        // Triggering a rebuild to reflect the changes
        setState(() {});
      }
    });
  }

  void getFeAndFMCurrentLocation() {
    // Adding a post-frame callback to ensure that the method runs after the current frame is drawn
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Checking if the user type is field engineer (fe)
      if (userType == UserType.fe) {
        // Getting the current position of the field engineer
        final location = await Geolocator.getCurrentPosition();
        // Updating the current position state
        setState(() {
          currentPosition = location;
        });
        debugPrint('currentPosition ==> $currentPosition');

        // Waiting for any pending operations to complete
        await Future.delayed(Duration.zero);

        // Setting up the polyline on the map
        setupPolyLineForMap();

        // Setting up a timer to update the current position periodically (every 10 minutes)
        _timer = Timer.periodic(const Duration(minutes: 10), (timer) async {
          final position = await Geolocator.getCurrentPosition();
          setState(() {
            currentPosition = position;
          });
          debugPrint('currentPosition ==> $currentPosition');
          await Future.delayed(Duration.zero);
          setupPolyLineForMap();
        });

        // Future Usage (commented out for now)
        /* 
      Geolocator.getCurrentPosition().then((value) {
        debugPrint('currentPosition ==> $currentPosition');
        if (mounted) {
          setState(() {
            currentPosition = value;
          });
        }
      });
      */
      } else {
        // For field manager (fm), getting the current position
        fmCurrentLocation = await Geolocator.getCurrentPosition();
        logger.i('FM Current Location ==> $fmCurrentLocation');

        // Updating the state if the widget is still mounted
        if (mounted) {
          setState(() {});
        }

        // Waiting for any pending operations to complete
        await Future.delayed(Duration.zero);

        // Setting up the polyline on the map
        setupPolyLineForMap();

        // Setting up a timer to update data periodically (every 5 minutes)
        _timer = Timer.periodic(const Duration(minutes: 5), (timer) async {
          // Deleting table data from the database and fetching new task details
          deleteTableFromDatabase(Constants.tblFECaseDetails).then((value) {
            if (mounted) {
              context.read<TaskDetailsBloc>().add(
                    TaskDetailsFetchDataEvent(id: widget.id),
                  );
            }
          });
        });

        // Ensuring the state is updated if the widget is still mounted
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

// Method to get the custom marker for the field engineer on the map
  Future<void> getFEMapMarker() async {
    try {
      // Creating a custom bitmap descriptor from the asset image
      userLocationMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(24, 24)),
        AppImage.icMarker,
      );
    } catch (e) {
      // Logging the error in case of failure
      debugPrint('Error creating marker: $e');
    }
  }

  // Method to initialize location settings and permissions
  Future<void> initLocation() async {
    // Check if location is enabled from shared preferences
    isLocationEnabled = await GetIt.I
        .get<SharedPrefHelper>()
        .get(SharedPrefHelper.enableLocation, defaultValue: true);

    // Check for location permissions
    final res = await checkLocationPermission();

    // If permissions are granted and location is enabled
    if (res && isLocationEnabled) {
      if (mounted) {
        // Dispatch an event to start location updates
        context.read<LocationPermissionBloc>().add(StartLocationEvent());
      }
    } else {
      // Retry initializing location if permissions are not granted
      initLocation();
    }

    // Update the state if the widget is still mounted
    if (mounted) {
      setState(() {});
    }
  }

// Method to check and request location permissions
  Future<bool> checkLocationPermission() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Return false if location services are not enabled
      return false;
    }

    // Check the current location permission status
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if it's denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Return false if permission is denied again
        return false;
      }
    }

    // Return false if permission is denied forever
    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    // Return true if permission is granted
    return true;
  }

// Method to clear data and reset state
  void clearData() {
    // Update the formatted date to the current date and time
    formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

    // Reset selected engineer to null
    selectedEngineer = null;

    // Reset the showError flag to false
    showError = false;

    // Trigger a state update to reflect the changes
    setState(() {});
  }

// Method to retrieve points between two coordinates and draw a polyline
  Future<PolylineResult> getPointsBetweenCoordinates({
    required PointLatLng origin,
    required PointLatLng dest,
  }) async {
    // Retrieve the route between the origin and destination coordinates
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Constants.googleMapKey,
      origin,
      dest,
      optimizeWaypoints: true,
    );

    // Log that the method was called
    logger.i("getPointsBetweenCoordinates Called");

    // Return the polyline result
    return result;
  }

// Dispose method to cancel the timer and perform cleanup
  @override
  void dispose() {
    // Check if the timer is not null and cancel it
    if (_timer != null) {
      _timer?.cancel();
    }
    // Call the superclass dispose method
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GeofenceStatus>(
      valueListenable: geofenceStatusValueNotifier,
      builder: (__, value, _) {
        if (value == GeofenceStatus.ENTER) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
            await deleteTableFromDatabase(Constants.tblFECaseDetails).then(
              (value) {
                if (context.mounted) {
                  context.read<TaskDetailsBloc>().add(
                        TaskDetailsFetchDataEvent(
                          id: widget.id,
                        ),
                      );
                }
              },
            );
            geofenceStatusValueNotifier.value = GeofenceStatus.DWELL;
          });
        }
        return BlocConsumer<TaskDetailsBloc, TaskDetailState>(
          listener: (context, state) {
            if (state is TaskEngineerBackState) {}
          },
          builder: (context, state) {
            if (state is TaskDetailsErrorState) {
              return Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .1,
                  left: 35,
                  right: 35,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.red,
                      size: 38,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      state.message,
                      style: Styles.textStyledarkBlack13dpRegular,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else if (state is TaskDetailsLoadingState) {
              return const Loader();
            } else if (state is TaskDetailslLoadedState) {
              double lat = double.tryParse(
                    state.response.result?.task?.caseRecord?.location?.latitude ?? "",
                  ) ??
                  0.0;
              double long = double.tryParse(
                    state.response.result?.task?.caseRecord?.location?.longitude ?? "",
                  ) ??
                  0.0;

              double feLat = double.tryParse(
                    state.response.result?.task?.uFeLastLatitude ?? "",
                  ) ??
                  0.0;
              double feLong = double.tryParse(
                    state.response.result?.task?.uFeLastLongitude ?? "",
                  ) ??
                  0.0;

              return _isLoading
                  ? const Loader()
                  : Scaffold(
                      key: _scaffoldKey,
                      extendBody: true,
                      extendBodyBehindAppBar: true,
                      floatingActionButtonLocation: !widget.showScheduleBtn
                          ? FloatingActionButtonLocation.endFloat
                          : FloatingActionButtonLocation.centerFloat,
                      floatingActionButton: !widget.showScheduleBtn
                          ? FloatingActionButton(
                              onPressed: () {
                                showActionMenus(
                                  lat: lat,
                                  long: long,
                                  contractID: state.response.result?.task?.caseRecord?.contractId,
                                  result: state.response,
                                );
                              },
                              isExtended: false,
                              backgroundColor: AppColors.red,
                              foregroundColor: Colors.white,
                              child: const Icon(Icons.menu),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.red,
                                ),
                                onPressed: () async {
                                  final res = await dialogScheduleTask(
                                    taskId: state.response.result?.task?.sysId ?? '',
                                    id: "${state.response.result?.task?.caseRecord?.number ?? "-"} - ${state.response.result?.task?.number ?? "-"}",
                                    context: context,
                                    engList: state.engList,
                                    taskNumber: state.response.result?.task?.number,
                                  );
                                  if (res != null) {
                                    if (res) {
                                      context.read<TaskDetailsBloc>().add(
                                            TaskDetailsUpdateDataEvent(
                                              id: widget.id,
                                              isBack: true,
                                              selectedDate: DateFormat(
                                                'yyyy-MM-dd HH:mm:ss',
                                              ).parse(formattedDate).toString(),
                                              callUpdateTimeAPi: true,
                                              taskNumber: taskNumber,
                                              data: {
                                                'assigned_to': selectedEngineer?.userName ?? '',
                                              },
                                              currentTabStatus: getStatusIDFromSelectedTab(),
                                            ),
                                          );
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.06.h,
                                  child: const Center(
                                    child: Text(
                                      "Schedule Task",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      body: SmartRefresher(
                        key: _refreshIndicatorKey,
                        controller: _refreshController,
                        onRefresh: () async {
                          final result = await Connectivity().checkConnectivity();
                          if (result == ConnectivityResult.none) {
                            _refreshController.refreshCompleted();
                            Fluttertoast.showToast(
                              msg: 'Please connect to internet',
                            );
                            return;
                          }
                          if (mounted) {
                            await deleteTableFromDatabase(
                              Constants.tblFECaseDetails,
                            );
                            _refreshController.refreshCompleted();

                            if (mounted) {
                              context.read<TaskDetailsBloc>().add(
                                    TaskDetailsFetchDataEvent(
                                      id: widget.id,
                                    ),
                                  );
                            }
                          }
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              // 190.verticalSpace,
                              SizedBox(
                                height: (ScreenUtil().screenHeight / 2).h,
                                width: double.maxFinite.w,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(lat, long),
                                    zoom: 15,
                                  ),
                                  onMapCreated: (ct) {
                                    mapController = ct;
                                  },
                                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                                    Factory<OneSequenceGestureRecognizer>(
                                      () => EagerGestureRecognizer(),
                                    ),
                                  },
                                  zoomControlsEnabled: true,
                                  myLocationButtonEnabled: false,
                                  myLocationEnabled: userType == UserType.fe,
                                  markers: {
                                    Marker(
                                      markerId: const MarkerId('taskLocation'),
                                      position: LatLng(lat, long),
                                      infoWindow: const InfoWindow(
                                        title: 'Task Location',
                                      ),
                                    ),
                                    if (userType == UserType.fm) ...[
                                      if (fmCurrentLocation != null) ...[
                                        Marker(
                                          icon: BitmapDescriptor.defaultMarkerWithHue(
                                            BitmapDescriptor.hueBlue,
                                          ),
                                          markerId: const MarkerId('fmlocation'),
                                          position: LatLng(
                                            fmCurrentLocation!.latitude,
                                            fmCurrentLocation!.longitude,
                                          ),
                                          infoWindow: const InfoWindow(
                                            title: 'FM Location',
                                          ),
                                        ),
                                        Marker(
                                          markerId: const MarkerId('felocation'),
                                          position: LatLng(feLat, feLong),
                                          infoWindow: const InfoWindow(
                                            title: 'FE Location',
                                          ),
                                          icon: userLocationMarker,
                                        ),
                                      ],
                                    ],
                                    if (currentPosition != null)
                                      Marker(
                                        markerId: const MarkerId(
                                          'currentLocation',
                                        ),
                                        position: LatLng(
                                          currentPosition?.latitude ?? 0,
                                          currentPosition?.longitude ?? 0,
                                        ),
                                        icon: userLocationMarker,
                                      ),
                                  },
                                  polylines: {
                                    if (polyLineResult != null &&
                                        polyLineResult!.points.isNotEmpty) ...{
                                      if (userType == UserType.fe && isLocationEnabled) ...{
                                        Polyline(
                                          polylineId: const PolylineId('line'),
                                          visible: true,
                                          points: polyLineResult!.points
                                              .map(
                                                (e) => LatLng(
                                                  e.latitude,
                                                  e.longitude,
                                                ),
                                              )
                                              .toList(),
                                          color: AppColors.red,
                                          width: 4,
                                          geodesic: true,
                                        ),
                                      } else if (userType == UserType.fm) ...{
                                        Polyline(
                                          polylineId: const PolylineId('line'),
                                          visible: true,
                                          points: polyLineResult!.points
                                              .map(
                                                (e) => LatLng(
                                                  e.latitude,
                                                  e.longitude,
                                                ),
                                              )
                                              .toList(),
                                          color: AppColors.red,
                                          width: 4,
                                          geodesic: true,
                                        ),
                                      },
                                    },
                                  },
                                  circles: {
                                    Circle(
                                      circleId: const CircleId('radius'),
                                      center: LatLng(lat, long),
                                      fillColor: AppColors.red.withOpacity(0.3),
                                      radius: Constants.taskRadius,
                                      strokeColor: AppColors.red,
                                      strokeWidth: 1,
                                    ),
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15.w),
                                height: MediaQuery.of(context).size.height * 0.05.h,
                                width: double.maxFinite.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: AppColors.greyBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.grey,
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${state.response.result?.task?.caseRecord?.number ?? "-"} - ${state.response.result?.task?.number ?? "-"}",
                                        style: Styles.textStyledarkBlack11dpBold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30.0.w,
                                  vertical: 20.0.h,
                                ),
                                child: Column(
                                  children: [
                                    if (polyLineResult != null &&
                                        polyLineResult!.points.isNotEmpty) ...{
                                      buildSingleRow(
                                        'ETA:',
                                        '${polyLineResult!.duration ?? ""} (${polyLineResult!.distance ?? ""})',
                                      ),
                                      15.verticalSpace,
                                    },
                                    buildSingleRow(
                                      "Description:",
                                      state.response.result?.task?.caseRecord?.description ?? "",
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      "Status:",
                                      state.response.result?.task?.state,
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      "Priority:",
                                      state.response.result?.task?.caseRecord?.priority ?? "",
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      "Scheduled Date:",
                                      state.response.result?.task?.uPreferredScheduleByCustomer ??
                                          "",
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      "End User Name:",
                                      state.response.result?.task?.caseRecord?.uEndUserName ?? "",
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      onTap: () async {
                                        logger.i(
                                          state.response.result?.task?.caseRecord
                                              ?.uEndUserContactNumber,
                                        );
                                        if (state.response.result?.task?.caseRecord
                                                    ?.uEndUserContactNumber !=
                                                null &&
                                            state.response.result?.task?.caseRecord
                                                    ?.uEndUserContactNumber !=
                                                "") {
                                          await launchUrl(
                                            Uri.parse(
                                              'tel:${state.response.result?.task?.caseRecord?.uEndUserContactNumber}',
                                            ),
                                          );
                                        } else {
                                          logger.i(
                                            'Could not launch phone dialer',
                                          );
                                        }
                                      },
                                      "End User Contact Number:",
                                      state.response.result?.task?.caseRecord
                                              ?.uEndUserContactNumber ??
                                          "",
                                      underlineContent: true,
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      "End User Email ID:",
                                      state.response.result?.task?.caseRecord?.uEndUserEmailId,
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      "SPOC 1 Name",
                                      state.response.result?.task?.caseRecord?.uSpoc1Name,
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      onTap: () async {
                                        final item = state
                                            .response.result?.task?.caseRecord?.uSpoc1ContactNumber;

                                        if (item != null && item.isNotEmpty) {
                                          launchUrl(
                                            Uri(
                                              scheme: "tel",
                                              path: item,
                                            ),
                                          );
                                        } else {
                                          logger.e("Failed");
                                        }
                                      },
                                      "SPOC 1 Contact Number",
                                      state.response.result?.task?.caseRecord?.uSpoc1ContactNumber,
                                      underlineContent: true,
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      "SPOC 1 EMail ID",
                                      state.response.result?.task?.caseRecord?.uSpoc1EmailId ?? "",
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      "SPOC 2 Name",
                                      state.response.result?.task?.caseRecord?.uSpoc2Name,
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      onTap: () async {
                                        final item = state
                                            .response.result?.task?.caseRecord?.uSpoc2ContactNumber;

                                        if (item != null && item.isNotEmpty) {
                                          launchUrl(
                                            Uri(
                                              scheme: "tel",
                                              path: item,
                                            ),
                                          );
                                        } else {
                                          logger.e("Failed");
                                        }
                                      },
                                      "SPOC 2 Contact Number",
                                      state.response.result?.task?.caseRecord?.uSpoc2ContactNumber,
                                      underlineContent: true,
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      "SPOC 2 EMail ID",
                                      state.response.result?.task?.caseRecord?.uSpoc2EmailId,
                                    ),
                                    15.verticalSpace,
                                    buildSingleRow(
                                      "Address:",
                                      state.response.result?.task?.caseRecord?.location?.address,
                                    ),
                                    100.verticalSpace,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            }
            return const Center(
              child: Text('Error!!'),
            );
          },
        );
      },
    );
  }

// Method to show a dialog for scheduling a task
  Future<bool?> dialogScheduleTask({
    required String id,
    required String taskId,
    required BuildContext context,
    required engList,
    required taskNumber,
  }) async {
    clearData();
    return await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (_, StateSetter setState) {
            return AlertDialog(
              shape: const ContinuousRectangleBorder(),
              title: Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                color: AppColors.greyBackground,
                child: Center(
                  child: Text(
                    "SCHEDULE TASK",
                    style: Styles.textStyledarkBlack14dpBold,
                  ),
                ),
              ),
              titlePadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: AppColors.grey),
                    ),
                    width: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.all(5.0.h),
                      child: Text(id),
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: AppColors.grey),
                    ),
                    // height: 30,
                    width: double.maxFinite,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(border: InputBorder.none),
                      style: Styles.textStyledarkBlack14dpRegular,
                      hint: Text(
                        "-Select FE-",
                        style: Styles.textStyledarkBlack14dpBold,
                      ),
                      isExpanded: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 0,
                      ),
                      value: selectedEngineer,
                      onChanged: (TaskFieldEngineerResultFieldEngineers? newValue) {
                        setState(() {
                          if (newValue != null) {
                            showError = false;
                            selectedEngineer = newValue;
                          }
                        });
                      },
                      items: engList.map<DropdownMenuItem<TaskFieldEngineerResultFieldEngineers>>(
                          (TaskFieldEngineerResultFieldEngineers value) {
                        logger.f(value);
                        return DropdownMenuItem<TaskFieldEngineerResultFieldEngineers>(
                          value: value,
                          child: SingleChildScrollView(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    value.name ?? '',
                                  ),
                                ),
                                Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: getColorFromTaskCount(
                                      count: value.taskCount,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      value.taskCount ?? "",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  5.verticalSpace,
                  if (showError)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Please select field engineer.',
                        style: Styles.textStyledarkBlack14dpRegular.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  5.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: AppColors.grey),
                    ),
                    width: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.all(5.0.h),
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ETA:  $formattedDate",
                            ),
                            Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.grey,
                            ),
                          ],
                        ),
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            confirmText: "CONFIRM",
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (newDate == null) {
                            return;
                          }
                          if (context.mounted) {
                            TimeOfDay? selectedTime24Hour = await showTimePicker(
                              context: context,
                              initialTime: const TimeOfDay(hour: 10, minute: 47),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data:
                                      MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );

                            if (selectedTime24Hour == null) {
                              return;
                            }

                            DateTime combinedDate = DateTime(
                              newDate.year,
                              newDate.month,
                              newDate.day,
                              selectedTime24Hour.hour,
                              selectedTime24Hour.minute,
                            );

                            setState(() {
                              formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(
                                combinedDate,
                              ); // Use HH for 24-hour format
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.grey),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            side: BorderSide(color: AppColors.grey),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop(false); // Close the dialog
                      },
                      child: Text(
                        'CANCEL',
                        style: TextStyle(color: AppColors.black),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppColors.primaryButtonBackgroundColor,
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            side: BorderSide(
                              color: AppColors.primaryButtonBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (selectedEngineer == null) {
                          setState(() {
                            showError = true;
                          });
                          return;
                        }
                        Navigator.of(ctx).pop(true);
                        // Navigator.of(context)
                        //     .pushReplacement(newRoute(RouteConstants.home)
                      },
                      child: Text(
                        'SCHEDULE',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

// Method to build a single row widget with a title and result
  Widget buildSingleRow(
    String title,
    String? result, {
    VoidCallback? onTap,
    bool underlineContent = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: Styles.textStyledarkBlack13dpRegular,
        ),
        // Space between title and result
        const SizedBox(width: 15),
        // Expanded widget for the result
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              result ?? '', // Display the result or empty string if null
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                // Apply underline decoration if specified
                decoration: underlineContent ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Method to determine color based on task count
  Color getColorFromTaskCount({String? count}) {
    // Check if count is '0'
    if (count == '0') {
      // Return green color
      return const Color(0xFF03CC0B); // Green color
    }
    // Check if count is '1' or '2'
    else if (count == '1' || count == '2') {
      // Return yellow color
      return const Color(0xFFFFC727); // Yellow color
    }
    // For any other count
    else {
      // Return red color
      return const Color(0xFFDD2827); // Red color
    }
  }

  // void checkFirebaseUserIDStatus() {
  //   final authProvider = Provider.of<AuthProvider>(context);
  //   switch (authProvider.status) {
  //     case Status.authenticateError:
  //       Fluttertoast.showToast(msg: "Sign in fail");
  //       break;
  //     case Status.authenticateCanceled:
  //       Fluttertoast.showToast(msg: "Sign in canceled");
  //       break;
  //     case Status.authenticated:
  //       Fluttertoast.showToast(msg: "Sign in success");
  //       break;
  //     default:
  //       break;
  //   }
  //   authProvider.handleSignIn().then((isSuccess) {
  //     Fluttertoast.showToast(msg: "Firebase User Created");
  //   }).catchError((error, stackTrace) {
  //     Fluttertoast.showToast(msg: error.toString());
  //     authProvider.handleException();
  //   });
  // }
  // string manipulation

// Method to get the ID from a string
  String getId(String res) {
    // Extract substring from the start to the first occurrence of '_'
    return res.substring(0, res.indexOf("_"));
  }

// Method to get the name from a string
  String getName(String res) {
    // Extract substring from after the first occurrence of '_' to the end
    return res.substring(res.indexOf("_") + 1);
  }

// Method to get the value of a key from a document snapshot safely
  getSnapshot(DocumentSnapshot snapshot, String key) {
    try {
      // Try to get the value of the key from the snapshot
      return snapshot.get(key);
    } catch (error) {
      // Return null if there's an error (e.g., key not found)
      return null;
    }
  }

  // Method to listen to a stream of group data
  Future<void> groupList(List<String> tokens) async {
    // Listen to the stream of group data
    streamSubscription = groups!.listen((data) {
      if (mounted) {
        // If the widget is still mounted, update the state
        setState(() {
          // Create an AsyncSnapshot with the received data and active connection state
          snapshot = AsyncSnapshot.withData(ConnectionState.active, data);

          // Check if the snapshot has data and if the task group exists
          if (!snapshot.hasData || !checkTaskGroupExists()) {
            // If no data or task group exists, perform necessary actions
            noTaskGroupExists(tokens);
            return;
          }

          // Extract the data from the snapshot
          var output = snapshot.data!.data();

          // Iterate over the groups in the data
          output['groups'].forEach((group) {
            // Check if the group name contains the task number
            if (getName(group).contains(taskNumber)) {
              // Handle the group tile for the matching group
              handleGroupTile(group, tokens);
            }
          });
        });
      }
    });
  }

// Method to check if the task group exists in the snapshot data
  bool checkTaskGroupExists() {
    // Get the 'groups' data from the snapshot
    var group = getSnapshot(snapshot.data, "groups");

    // If 'groups' data is null, return false indicating that the task group doesn't exist
    if (group == null) return false;

    // Extract data from the snapshot
    var output = snapshot.data!.data();

    // Check if any group name contains the task number
    var isFound =
        output['groups'].any((addedTaskName) => getName(addedTaskName).contains(taskNumber));

    // Return true if a group containing the task number is found, otherwise return false
    return isFound;
  }

// Method to handle the group tile interaction
  void handleGroupTile(group, List<String> tokens) {
    // Get the receiver message ID from the group
    receiverMsgId = getId(group);

    // Navigate to the ChatPage with relevant parameters
    nextScreen(
      context,
      ChatPage(
        groupId: getId(group), // Pass the group ID
        groupName: getName(group), // Pass the group name
        userName: snapshot.data['fullName'], // Pass the user's full name
        deviceToken: tokens, // Pass the device tokens
      ),
    );
  }

// Method to handle the scenario where no task group exists
  void noTaskGroupExists(List<String> tokens) {
    var groupId = "";

    // Search for the task by name in the database
    DatabaseService().searchByName(taskNumber).then((snapshot) {
      setState(() {
        // Check if the search returned any documents
        if (snapshot!.docs.length != 0) {
          // If documents are found, get the group ID
          groupId = snapshot!.docs[0]['groupId'];

          // If a group ID is obtained, add the user to the task group
          if (groupId != "") {
            addToTaskGroup(snapshot, tokens);
          }
          // If no group ID is found, create a group for the task
          else {
            createGroupForTask(taskNumber, tokens);
          }
        }
        // If no documents are found, create a group for the task
        else {
          createGroupForTask(taskNumber, tokens);
        }
      });
    });
  }

// Method to create a group for the task
  void createGroupForTask(String taskNum, List<String> tokens) {
    // Create a group for the task in the database
    DatabaseService(
      uid: FirebaseAuth.instance.currentUser!.uid,
    )
        .createGroup(
      userName, // Pass the user's name
      FirebaseAuth.instance.currentUser!.uid, // Pass the user's ID
      taskNum, // Pass the task number
    )
        .whenComplete(() {
      // After the group is created, refresh the group list
      groupList(tokens);
    });
  }

// Method to add user to an existing task group
  void addToTaskGroup(dynamic snapshot, List<String> tokens) {
    var groupId = snapshot!.docs[0]['groupId'];

    // Check if a group ID is obtained
    if (groupId != "") {
      // Toggle group join for the user in the database
      DatabaseService(
        uid: FirebaseAuth.instance.currentUser!.uid,
      ).toggleGroupJoin(groupId, userName, taskNumber).whenComplete(() {
        // Update group information for the user
        DatabaseService().updateGroupForUser(taskNumber, groupId, userName).then((value) {
          // Retrieve updated user groups from the database
          DatabaseService(
            uid: FirebaseAuth.instance.currentUser!.uid,
          ).getUserGroups().then((snapshot) {
            setState(() {
              // Update the 'groups' state variable with the updated user groups
              groups = snapshot;
            });
          });
          // Refresh the group list
          groupList(tokens);
        });
      });
    }
  }

  void showActionMenus({
    required double lat,
    required double long,
    String? contractID,
    String? street,
    String? city,
    String? country,
    required CaseDetailEntity result,
  }) async {
    ActionsMenu? menu = await showDialog(
      context: context,
      builder: (BuildContext context) {
        List<dynamic> feActionList = fieldEngineerAlertWidget;
        if (currentTaskStatus == 1) {
          feActionList = fieldEngineerAlertWidget
              .where(
                (element) => element['title'] == "Text Chat" || element['title'] == "Video Chat",
              )
              .toList();
        }
        // This alert dialog is for field er screen and commented code was
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3,
                  sigmaY: 3,
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.3),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 255, 253, 253),
                surfaceTintColor: Colors.white,
                shadowColor: AppColors.black,

                //
                contentPadding: EdgeInsets.zero,
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        userType == UserType.fe ? feActionList.length : managerAlertWidget.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 20.0.h,
                                right: 30.w,
                                left: 30.w,
                                bottom: 10.h,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    userType == UserType.fe
                                        ? feActionList[index]["title"]
                                        : managerAlertWidget[index]["title"],
                                  ),
                                  SvgPicture.asset(
                                    userType == UserType.fe
                                        ? feActionList[index]["image"]
                                        : managerAlertWidget[index]["image"],
                                    // width: 25,
                                    fit: BoxFit.cover,
                                    // scale: 5,
                                    height: 25.h,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(
                                userType == UserType.fe
                                    ? feActionList[index]["type"]
                                    : managerAlertWidget[index]["type"],
                              );
                            },
                          ),
                          if (userType == UserType.fe && index < feActionList.length - 1)
                            Divider(
                              height: 1,
                              color: AppColors.grey,
                            ),
                          if (userType == UserType.fm && index < managerAlertWidget.length - 1)
                            Divider(
                              height: 1,
                              color: AppColors.grey,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (menu == null) return;
    switch (menu) {
      case ActionsMenu.startTravel:
        if (context.mounted) {
          showStartTravelDialog(
            context,
            () {
              showLoading(value: true);
              String taskNumber = widget.model?.taskEffectiveNumber ?? '';

              // Update local task database
              updateLocalTaskDB(
                inCompleteTaskStatus,
                widget.model?.number ?? "",
              );

              // Update the task state
              setState(() {
                widget.model?.state = "In Progress";
              });

              // Dispatch event to update task details
              context.read<TaskDetailsBloc>().add(
                    TaskDetailsUpdateDataEventNew(
                      taskId: widget.id,
                      id: widget.model?.number ?? taskNumber,
                      data: {
                        'u_travel_start_time': DateTime.now().toString(),
                      },
                      currentTabStatus: getStatusIDFromSelectedTab(),
                      toastMessage: "Navigating to destination in the Xbridge Live app",
                    ),
                  );

              // Start geofencing
              GetIt.I.get<GeoFenceHelper>().startGeofence(
                    lat: lat,
                    long: long,
                    sysId: widget.model?.number ?? taskNumber,
                  );

              // Check location permissions
              if (context.mounted) {
                context.read<LocationPermissionBloc>().add(LocationPermissionCheckEvent());
              }
            },
          );
        }
        break;
      case ActionsMenu.endTravel:
        if (context.mounted) {
          logger.i(GetIt.I.get<GeoFenceHelper>().geofenceStatus);
          if (GetIt.I.get<GeoFenceHelper>().geofenceStatus != null &&
              GetIt.I.get<GeoFenceHelper>().geofenceStatus == GeofenceStatus.ENTER) {
            showLoading(value: true);
            context.read<TaskDetailsBloc>().add(
                  TaskDetailsUpdateDataEventNew(
                    taskId: widget.id,
                    id: widget.model?.number ?? '',
                    data: {
                      'u_arrival_time':
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString(),
                    },
                    currentTabStatus: getStatusIDFromSelectedTab(),
                    toastMessage: "You are at your destination",
                  ),
                );
          } else {
            showTaskEndDialog(ctx: context);
          }
        }
        break;
      case ActionsMenu.startWork:
        if (context.mounted) {
          showStartWorkDialog(
            context,
            () {
              showLoading(value: true);
              context.read<TaskDetailsBloc>().add(
                    TaskDetailsUpdateDataEventNew(
                      taskId: widget.id,
                      id: widget.model?.number ?? '',
                      data: {
                        'u_work_started': DateTime.now().toString(),
                      },
                      currentTabStatus: getStatusIDFromSelectedTab(),
                      toastMessage: "Commencing Work",
                    ),
                  );
            },
          );
        }
        break;
      case ActionsMenu.endWork:
        if (context.mounted) {
          showEndWorkDialog(
            context,
            () {
              showLoading(value: true);
              context.read<TaskDetailsBloc>().add(
                    TaskDetailsUpdateDataEventNew(
                      taskId: widget.id,
                      id: widget.model?.number ?? '',
                      data: {
                        'u_work_completed': DateTime.now().toString(),
                      },
                      currentTabStatus: getStatusIDFromSelectedTab(),
                      toastMessage: "Finalizing Work.. Fill out the SCR Form",
                    ),
                  );
            },
          );
        }
        break;
      case ActionsMenu.csrForm:
        if (context.mounted) {
          final String sysid = widget.model?.sysId ?? "";

          // Show loading indicator
          showLoading(value: true);

          GetIt.I
              .get<APIProvider>()
              .getMethod(APIConstant.API_Task_Details + sysid)
              .then((response) {
            if (response != null) {
              // Parse the response to get the updated model
              final UnassignedTaskResult updatedModel =
                  UnassignedTaskResult.fromJson(response['result']);
              // logger.f('Response: ${getJson(response)}');
              logger.f('Updated Model: ${getJson(updatedModel)}');

              // Hide loading indicator
              showLoading(value: false);

              GoRouter.of(context).pushNamed(
                RouteConstants.serviceCallReport,
                queryParameters: {
                  'id': contractID,
                  'street': result.result?.task?.caseRecord?.location?.street,
                  'city': result.result?.task?.caseRecord?.location?.city,
                  'country': result.result?.task?.caseRecord?.location?.country,
                  'scheduledDate': result.result?.task?.uPreferredScheduleByCustomer ?? "",
                  'departureTime': result.result?.task?.uDepartureTime ?? "",
                },
                extra: updatedModel,
              );
            } else {
              // Hide loading indicator if response is null
              showLoading(value: false);
              logger.e('Response is null');
            }
          }).catchError((error) {
            // Hide loading indicator in case of error
            showLoading(value: false);
          });
        }
        break;
      case ActionsMenu.workNote:
        if (context.mounted) {
          GoRouter.of(context).pushNamed(
            RouteConstants.fieldEngineerWorkNote,
            extra: widget.model,
          );
        }
        break;
      case ActionsMenu.textChat:
        if (context.mounted) {
          setState(() {
            _isLoading = true;
          });

          // taskNumber = widget.model?.number ?? "";
          List<VendorManagers> vendorManager =
              result.result?.task?.caseRecord?.vendorManagers ?? [];
          var feDeviceToken = result.result?.task?.fieldengineerDevicetoken ?? "";

          List<String> deviceTokens =
              vendorManager.map((model) => model.uXblDeviceToken ?? "").toList();
          deviceTokens.add(feDeviceToken);
          // deviceTokens.removeWhere((element) => element == userDeviceToken);

          await HelperFunctions.getUserEmailFromSF().then((value) {
            setState(() {
              email = value ?? "";
            });
          });
          await HelperFunctions.getUserNameFromSF().then((val) {
            setState(() {
              userName = val ?? "";
            });
          });
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .getUserGroups()
              .then((snapshot) {
            setState(() {
              groups = snapshot;
            });
          });
          groupList(deviceTokens).whenComplete(
            () => setState(() {
              _isLoading = false;
            }),
          );
        }
        break;
      case ActionsMenu.videoChat:
        if (context.mounted) {
          GoRouter.of(context).pushNamed(
            RouteConstants.videoCall,
            queryParameters: {
              'id': widget.model?.sysId ?? '',
              'name': widget.model?.sysCreatedBy ?? '',
            },
          );
        }
        break;
    }
  }

  void showStartTravelDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirm Start Travel",
            style: Styles.textStyledarkBlack18dpBold,
          ),
          content: Text(
            "Are you sure you want to start travel?",
            style: Styles.textStyledarkBlack13dpRegular,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Start"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  void showStartWorkDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirm Start Work",
            style: Styles.textStyledarkBlack18dpBold,
          ),
          content: Text(
            "Are you sure you want to start work?",
            style: Styles.textStyledarkBlack13dpRegular,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Start"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  void showEndWorkDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirm End Work",
            style: Styles.textStyledarkBlack18dpBold,
          ),
          content: Text(
            "Are you sure you want to end work?",
            style: Styles.textStyledarkBlack13dpRegular,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("End"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  showAlertDialog(BuildContext context) {
    alertLoader = AlertDialog(
      content: Row(
        children: [
          const Loader(),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: const Text("Loading"),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alertLoader;
      },
    );
  }

  void showTaskEndDialog({required BuildContext ctx}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            // Navigator.pop(context);
          },
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3,
                  sigmaY: 3,
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.3),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 255, 253, 253),
                surfaceTintColor: Colors.white,
                shadowColor: AppColors.black,
                title: const Text('Alert!'),
                content: Text(
                  'You are ending your travel away from the task location. Are you sure you want to end travel?',
                  style: Styles.textStyledarkBlack12dpRegular,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showLoading(value: true);
                      logger.i({
                        'u_arrival_time': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                      });
                      ctx.read<TaskDetailsBloc>().add(
                            TaskDetailsUpdateDataEventNew(
                              id: widget.model?.number ?? '',
                              data: {
                                'u_arrival_time':
                                    DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                              },
                              currentTabStatus: getStatusIDFromSelectedTab(),
                              toastMessage: "You are at your destination",
                            ),
                          );
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  int getStatusIDFromSelectedTab() {
    switch (widget.selectedButtonIndex) {
      case 1:
        return openNewTaskStatus;
      case 2:
        return inProgressAcceptedTaskStatus;
      case 3:
        return completeTaskStatus;
      case 4:
        return cancelledTaskStatus;
    }
    return openNewTaskStatus;
  }
}

List fieldEngineerAlertWidget = [
  {
    'image': AppImage.startTravel,
    'title': 'Start Travel',
    'type': ActionsMenu.startTravel,
  },
  {
    'image': AppImage.endTravel,
    'title': 'End Travel',
    'type': ActionsMenu.endTravel,
  },
  {
    'image': AppImage.startWork,
    'title': 'Start Work',
    'type': ActionsMenu.startWork,
  },
  {
    'image': AppImage.endWork,
    'title': 'End Work',
    'type': ActionsMenu.endWork,
  },
  {
    'image': AppImage.csrForm,
    'title': 'Service Call Report',
    "path": RouteConstants.serviceCallReport,
    'type': ActionsMenu.csrForm,
  },
  {
    'image': AppImage.workNote,
    'title': 'Work Note',
    "path": RouteConstants.fieldEngineerWorkNote,
    'type': ActionsMenu.workNote,
  },
  {
    'image': AppImage.textChat,
    'title': 'Text Chat',
    // "path": RouteConstants.chatPage,
    'type': ActionsMenu.textChat,
  },
  {
    'image': AppImage.videoChat,
    'title': 'Video Chat',
    'type': ActionsMenu.videoChat,
  },
];

List managerAlertWidget = [
  {
    'image': AppImage.textChat,
    'title': 'Text Chat',
    // "path": RouteConstants.chatPage,
    'type': ActionsMenu.textChat,
  },
  {
    'image': AppImage.videoChat,
    'title': 'Video Chat',
    'type': ActionsMenu.videoChat,
  },
];

enum ActionsMenu {
  startTravel,
  endTravel,
  startWork,
  endWork,
  csrForm,
  workNote,
  textChat,
  videoChat,
}
