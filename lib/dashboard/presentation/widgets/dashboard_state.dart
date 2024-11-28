// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/NotificationServices.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/common/widgets/loader.dart';
import 'package:xbridge/dashboard/controller/dashboard_block.dart';
import 'package:xbridge/dashboard/controller/dashboard_event.dart';
import 'package:xbridge/dashboard/controller/dashboard_state.dart';
import 'package:xbridge/dashboard/data/model/dashboard.model.dart';
import 'package:xbridge/dashboard/presentation/screen/dashboard.dart';
import 'package:xbridge/location_update/controller/location_permission_bloc.dart';

import '../../../common/constants/app_colors.dart';
import '../../../main.dart';

class DashboardScreenState extends State<Dashboard> {
  late RefreshController _refreshController;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  bool isLoading = false;
  late DashboardBlock _dashboardBlock;
  int dispatchResolvedCount = 0;
  int dispatchClosedCount = 0;
  int dispatchPendingSCRCount = 0;
  int dispatchUpcomingCount = 0;
  int dispatchOpenCount = 0;
  int dispatchTotalCount = 0;

  int scheduledResolvedCount = 0;
  int scheduledPendingSCRCount = 0;
  int scheduledClosedCount = 0;
  int scheduledUpcomingCount = 0;
  int scheduledOpenCount = 0;
  int scheduledTotalCount = 0;

  bool isDateInCurrentMonth(DateTime dateToCheck) {
    // Find the last day of the month.
    final now = DateTime.now();
    var lastDayDateTime = (dateToCheck.month < 12)
        ? DateTime(dateToCheck.year, dateToCheck.month + 1, 0)
        : DateTime(dateToCheck.year + 1, 1, 0);
    // print("lastDay: $lastDayDateTime");
    // logger.i(
    //   "$dateToCheck: ${dateToCheck.month == now.month && dateToCheck.day <= lastDayDateTime.day && dateToCheck.day >= now.day}",
    // );
    return dateToCheck.month == now.month &&
        dateToCheck.day >= now.day &&
        dateToCheck.day <= lastDayDateTime.day;
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (mounted) {
      setState(() {
        _connectionStatus = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    NotificationService.init();
    initLocation();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _refreshController = RefreshController();

    _dashboardBlock = BlocProvider.of<DashboardBlock>(context);
    _dashboardBlock.add(const DashboardFetchDataEvent());
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status : $e');
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> initLocation() async {
    final status = await Permission.location.isGranted;
    // logger.i("status: $status");
    if (status) {
      if (mounted) {
        context.read<LocationPermissionBloc>().add(
              LocationPermissionUpdateEvent(
                status: true,
              ),
            );
      }
    } else {
      if (mounted) {
        context.read<LocationPermissionBloc>().add(
              LocationPermissionUpdateEvent(
                status: false,
              ),
            );
      }
    }
    // // Check the current status of the location permission.
    // PermissionStatus status = await Permission.location.status;

    // if (status.isDenied) {
    //   // If the location permission is denied, show a permission handler dialog.
    //   PermissionStatus newStatus = await Permission.location.request();
    //   if (newStatus.isDenied) {
    //     // Handle the case where the user still denies the permission
    //     // Show a dialog or other UI to inform the user
    //     showPermissionDeniedDialog();
    //   }
    // } else {
    //   // If the permission is already granted, continue with the initialization.
    //   if (mounted) {
    //     context.read<LocationPermissionBloc>().add(
    //           LocationPermissionInitEvent(),
    //         );
    //   }
    // }
  }

  void showPermissionDeniedDialog() {
    // Implement the dialog or UI that informs the user about the need for location permission
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Location permission is required for this feature. Please grant the permission.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  _onLoading(BuildContext context) {
    if (kDebugMode) {
      print("onLoading");
    }
  }

  onRefresh() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: 'Please connect to internet');
      return;
    }
    if (kDebugMode) {
      print("onRefresh");
    }
    _refreshController.refreshCompleted();

    if (mounted) {
      await deleteTableFromDatabase(Constants.tblMyDashboard);
      context.read<DashboardBlock>().add(const DashboardFetchDataEvent(skipLoading: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    // logger.f("=>>>>>>>>>>$vendorName");
    return BlocBuilder<DashboardBlock, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoadingState) {
          return const Loader();
        } else if (state is DashboardLoadedState) {
          /// Fetching the list of results from the state response
          List<Result?>? tasks = state.response.result;

          /// Filtering tasks related to Dispatch Model that are scheduled for the current month
          final dispatchTasks = tasks!.where((task) {
            DateTime? preferredDate = DateTime.tryParse(task?.upreferredschedulebycustomer ?? "");

            return task?.uparentuservicetype == "Dispatch Model" &&
                (preferredDate != null && isDateInCurrentMonth(preferredDate));
          });

          /// Checking if there are any dispatch tasks
          if (dispatchTasks.isNotEmpty) {
            /// Total count of dispatch tasks
            dispatchTotalCount = dispatchTasks.length;

            /// Count of resolved dispatch tasks with customer satisfaction marked as "yes"
            dispatchResolvedCount = dispatchTasks
                .where(
                  (task) => task?.state == "10" && task?.ucustomersatisfaction == "yes",
                )
                .length;

            /// Count of closed dispatch tasks
            dispatchClosedCount = dispatchTasks
                .where(
                  (task) => task?.state == "3",
                )
                .length;

            /// Count of pending SCR (Service Completion Report) for dispatch tasks
            dispatchPendingSCRCount = dispatchTasks
                .where(
                  (task) => task?.state == "10" && task?.ucustomersatisfaction == "",
                )
                .length;

            /// Count of upcoming dispatch tasks
            dispatchUpcomingCount = dispatchTasks
                .where(
                  (task) =>
                      (task!.state != "10" && task.state != "11" && task.state != "3") &&
                      task.ucustomersatisfaction != "yes" &&
                      (task.upreferredschedulebycustomer != ""),
                )
                .length;

            /// Total count of open dispatch tasks
            dispatchOpenCount = dispatchUpcomingCount + dispatchPendingSCRCount;
          }

          /// Filtering tasks related to Scheduled Visits that are scheduled for the current month
          final scheduledVisitedTasks = tasks.where((task) {
            DateTime? preferredDate = DateTime.tryParse(task?.upreferredschedulebycustomer ?? "");
            return task?.uparentuservicetype == 'Scheduled Visit' &&
                (preferredDate != null && isDateInCurrentMonth(preferredDate));
          });

          /// Checking if there are any scheduled visited tasks
          if (scheduledVisitedTasks.isNotEmpty) {
            /// Total count of scheduled visited tasks
            scheduledTotalCount = scheduledVisitedTasks.length;

            /// Count of resolved scheduled visited tasks with customer satisfaction marked as "yes"
            scheduledResolvedCount = scheduledVisitedTasks.where(
              (task) {
                return task?.state == "10" && task?.ucustomersatisfaction == "yes";
              },
            ).length;

            /// Count of pending SCR (Service Completion Report) for scheduled visited tasks
            scheduledPendingSCRCount = scheduledVisitedTasks
                .where(
                  (task) => task?.state == "10" && task?.ucustomersatisfaction == "",
                )
                .length;

            /// Count of closed scheduled visited tasks
            scheduledClosedCount = scheduledVisitedTasks
                .where(
                  (task) => task?.state == "3",
                )
                .length;

            /// Count of upcoming scheduled visited tasks
            scheduledUpcomingCount = scheduledVisitedTasks
                .where(
                  (task) =>
                      (task!.state != "10" && task.state != "11" && task.state != "3") &&
                      task.ucustomersatisfaction != "yes" &&
                      (task.upreferredschedulebycustomer != ""),
                )
                .length;

            /// Total count of open scheduled visited tasks
            scheduledOpenCount = scheduledUpcomingCount + scheduledPendingSCRCount;
          }

          return SmartRefresher(
            onRefresh: onRefresh,
            onLoading: () {
              _onLoading(context);
            },
            enablePullDown: _connectionStatus != ConnectivityResult.none,
            controller: _refreshController,
            child: setInitialUI(state.response),
          );
        } else if (state is DashboardErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Error!!'),
          );
        }
      },
    );
  }

  void onAction() {
    logger.i('ACTION Tapped');
  }

  Widget setInitialUI(DashboardResult result) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.red,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        surfaceTintColor: AppColors.red,
        elevation: 0,
        leading: Image.asset(
          AppImage.dashboardLogo,
          scale: 4.h,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                AppImage.dashboardLogoRectangle,
                scale: 4.h,
              ),
              20.horizontalSpace,
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 130.h,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(AppImage.dashboardCurve),
                filterQuality: FilterQuality.high,
                invertColors: false,
                fit: BoxFit.fill,
              ),
            ),
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Hi, $firstName!",
                    style: Styles.textStyleWhite25dpBold,
                  ),
                ),
                5.verticalSpace,
                Text(
                  "You have an amazing day",
                  style: Styles.textStyledarkBlack14dpBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  15.verticalSpace,
                  buildCardLayout(
                    mainCardTitle: "Dispatch",
                    openCount: dispatchOpenCount,
                    resolvedCount: dispatchResolvedCount,
                    pendingSCRCount: dispatchPendingSCRCount,
                    closedCount: dispatchClosedCount,
                    totalCount: dispatchTotalCount,
                    upcomingCount: dispatchUpcomingCount,
                  ),
                  15.verticalSpace,
                  buildCardLayout(
                    mainCardTitle: "Scheduled Visits",
                    openCount: scheduledOpenCount,
                    resolvedCount: scheduledResolvedCount,
                    pendingSCRCount: scheduledPendingSCRCount,
                    closedCount: scheduledClosedCount,
                    totalCount: scheduledTotalCount,
                    upcomingCount: scheduledUpcomingCount,
                  ),
                  30.verticalSpace,
                  buildLastButtons(),
                ],
              ),
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }

  Widget dashboardItems(String itemName, String imgName) {
    return Padding(
      padding: userType == UserType.fm
          ? EdgeInsets.symmetric(horizontal: 21.0.w)
          : EdgeInsets.symmetric(horizontal: 7.0.w),
      child: GestureDetector(
        onTap: () {
          switch (itemName) {
            case dashboardMyTeam:
              tabBarIndex.value = 0;

              break;

            case dashboardVisit:
              if (userType == UserType.fm) {
                GoRouter.of(context).push('/${RouteConstants.unassignVisit}');
              } else {
                tabBarIndex.value = 1;
                feTaskListNewTabRefreshIndicator.value = true;
                // GoRouter.of(context).pushNamed('/${RouteConstants.fieldEngineerTask}');
              }

              break;

            case dashboardDiagnostic:
              context.push('/${RouteConstants.diagnostic}');
              break;

            case dashboardLogs:
              tabBarIndex.value = 3;

              ///pushNamed(RouteConstants.fieldEngineerLogList);
              break;

            case dashboardCalendar:
              tabBarIndex.value = 0;

              // GoRouter.of(context).pushNamed(RouteConstants.calendarTaskViewList);
              break;

            case dashboardSettings:
              tabBarIndex.value = 4;

              // GoRouter.of(context)
              // .pushNamed(RouteConstants.fieldEngineerSettings);
              break;

            default:
          }
        },
        child: Column(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    spreadRadius: -10,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.20),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                imgName,
              ),
            ),
            Text(
              itemName,
              textAlign: TextAlign.center,
              style: Styles.textStyledarkBlack12dpRegular,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> itemForManager() {
    return [
      dashboardItems(dashboardMyTeam, AppImage.icMyTeam),
      dashboardItems(dashboardVisit, AppImage.icVisits),
      dashboardItems(dashboardDiagnostic, AppImage.icDiagnostic),
    ];
  }

  List<Widget> itemForFieldEngineer() {
    return [
      dashboardItems(dashboardCalendar, AppImage.icCalendar),
      dashboardItems(dashboardVisit, AppImage.icVisits),
      dashboardItems(dashboardLogs, AppImage.icLogs),
      dashboardItems(dashboardSettings, AppImage.icSetting),
      dashboardItems(dashboardDiagnostic, AppImage.icDiagnostic),
    ];
  }

  Widget buildLastButtons() {
    return SizedBox(
      child: userType == UserType.fm
          ? SizedBox(
              height: 100.h,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount:
                    (userType == UserType.fm ? itemForManager() : itemForFieldEngineer()).length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return (userType == UserType.fm
                      ? itemForManager()
                      : itemForFieldEngineer())[index];
                },
              ),
            )
          : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: .8,
                mainAxisSpacing: 10,
              ),
              itemCount:
                  (userType == UserType.fm ? itemForManager() : itemForFieldEngineer()).length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return (userType == UserType.fm ? itemForManager() : itemForFieldEngineer())[index];
              },
            ),
    );
  }

// (userType == UserType.fm ? itemForManager() : itemForFieldEngineer()).length,
  //
  Widget buildCardLayout({
    required int openCount,
    required int resolvedCount,
    required int pendingSCRCount,
    required int closedCount,
    required int upcomingCount,
    required int totalCount,
    required String mainCardTitle,
  }) {
    // print("-----------------------------");
    // print("openCount: $openCount");
    // print("openCount: $openCount");
    // print("resolvedCount: $resolvedCount");
    // print("pendingSCRCount: $pendingSCRCount");
    // print("closedCount: $closedCount");
    // print("upcomingCount: $upcomingCount");
    // print("-----------------------------");
    double percentage = 0;
    double total = (resolvedCount + pendingSCRCount + closedCount + 5).toDouble();
    // logger.i("total Upcoming Task: $upcomingCount");
    // logger.i("openCount: $openCount");
    if (openCount != 0 && total != 0) {
      percentage = (openCount / total);
      // Ensure percentage is between 0.0 and 1.0
      percentage = min(percentage, 1.0);
    }
    // logger.i("percentage: $percentage");

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            spreadRadius: -8,
            blurRadius: 10,
            color: Colors.black.withOpacity(0.90),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mainCardTitle,
                  style: Styles.textStyleGrey14dpBold,
                ),
                Text(
                  DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  style: Styles.textStyleGrey14dpBold,
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 50.0,
                      lineWidth: 7.0,
                      percent: percentage,
                      backgroundColor: AppColors.geryshade300,
                      progressColor: AppColors.red,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        '$openCount',
                        style: Styles.textStyleDarkBlack60dpBold.copyWith(fontSize: 30.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text(
                        "Open",
                        style: Styles.textStyleGrey14dpBold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    taskStatusWidget(title: 'Resolved', tasks: resolvedCount),
                    taskStatusWidget(
                      title: 'Pending SCR',
                      tasks: pendingSCRCount,
                    ),
                    taskStatusWidget(title: 'Closed', tasks: closedCount),
                    taskStatusWidget(title: 'Upcoming', tasks: upcomingCount),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget taskStatusWidget({required String title, required int tasks}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 15.w,
                  child: Divider(
                    color: AppColors.red,
                    height: 1.h,
                    thickness: 2,
                  ),
                ),
                10.horizontalSpace,
                Text(
                  title,
                  style: Styles.textStyleGrey14dpRegular,
                ),
              ],
            ),
          ),
          Container(
            width: 40.w,
            height: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.geryshade300,
            ),
            child: Text(
              '$tasks',
              style: Styles.textStyledarkBlack18dpBold,
            ),
          ),
        ],
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final String title;

  const TabContent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
