import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:intl/intl.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/routes/route_config.dart';
import 'package:xbridge/common/utils/context_extension.dart';

import '../../task_details/data/repositories/task_details_repositories.dart';
import 'util.dart';

class GeoFenceHelper {
  late GeofenceService geofenceService;
  final TaskDetailsRepository repository;
  GeofenceStatus? geofenceStatus;
  late String taskId;

  GeoFenceHelper({required this.repository});

  /// Initializes the GeoFenceHelper.
  void init() {
    geofenceService = GeofenceService.instance.setup(
      interval: 5000,
      accuracy: 100,
      loiteringDelayMs: 60000,
      statusChangeDelayMs: 10000,
      useActivityRecognition: true,
      allowMockLocations: false,
      printDevLog: false,
      geofenceRadiusSortType: GeofenceRadiusSortType.DESC,
    );
    initListeners();
  }

  /// Initializes listeners for geofence events.
  void initListeners() {
    geofenceService.addGeofenceStatusChangeListener(_onGeofenceStatusChanged);
    geofenceService.addLocationChangeListener(_onLocationChanged);
    geofenceService.addLocationServicesStatusChangeListener(
        _onLocationServicesStatusChanged);
    geofenceService.addActivityChangeListener(_onActivityChanged);
    geofenceService.addStreamErrorListener(_onError);
  }

  /// Starts monitoring a geofence.
  void startGeofence(
      {required double lat, required double long, String? sysId}) {
    taskId = sysId ?? '';
    geofenceService
        .start([
          Geofence(
            id: 'task_location',
            latitude: lat,
            longitude: long,
            radius: [
              GeofenceRadius(id: 'radius_250m', length: Constants.taskRadius),
            ],
          ),
        ])
        .then((value) {})
        .catchError(_onError);
  }

  /// Ends traveling when the destination is reached.
  void endTraveling() async {
    try {
      final data = await repository.updateTaskTiming(
        id: taskId,
        data: {
          'u_arrival_time':
              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        },
      );
      if (data != null) {
        geofenceStatusValueNotifier.value = GeofenceStatus.ENTER;
        AppRouter.router.routerDelegate.navigatorKey.currentContext!
            .showSuccess(msg: 'You are at your destination');
        await geofenceService.stop();
      }
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
          msg: "The request couldn't be processed. Please try again.");
    }
  }

  /// Callback for handling geofence status changes.
  Future<void> _onGeofenceStatusChanged(
    Geofence geofence,
    GeofenceRadius geofenceRadius,
    GeofenceStatus status,
    Location location,
  ) async {
    debugPrint('GeoFenceHelper geofence: ${geofence.toJson()}');
    debugPrint('GeoFenceHelper geofenceRadius: ${geofenceRadius.toJson()}');
    debugPrint('GeoFenceHelper geofenceStatus: ${status.toString()}');
    geofenceStatus = status;
    if (status == GeofenceStatus.ENTER) {
      endTraveling();
    }
  }

  /// Callback for handling activity changes.
  void _onActivityChanged(Activity prevActivity, Activity currActivity) {
    debugPrint('GeoFenceHelper prevActivity: ${prevActivity.toJson()}');
    debugPrint('GeoFenceHelper currActivity: ${currActivity.toJson()}');
  }

  /// Callback for handling location changes.
  void _onLocationChanged(Location location) {
    debugPrint('GeoFenceHelper location: ${location.toJson()}');
  }

  /// Callback for handling location services status changes.
  void _onLocationServicesStatusChanged(bool status) {
    debugPrint('GeoFenceHelper isLocationServicesEnabled: $status');
  }

  /// Callback for handling errors that occur in the service.
  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      debugPrint('GeoFenceHelper Undefined error: $error');
      return;
    }

    // Fluttertoast.showToast(
    //     msg: "$errorCode",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 3,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    debugPrint('GeoFenceHelper ErrorCode: $errorCode');
  }
}
