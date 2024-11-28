import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xbridge/common/utils/shared_pref_helper.dart';
import 'package:xbridge/common/utils/util.dart';

import '../../common/constants/globals.dart';
import '../../main.dart';
import '../data/repository/location_repository.dart';

part 'location_permission_event.dart';
part 'location_permission_state.dart';

class LocationPermissionBloc extends Bloc<LocationPermissionEvent, LocationPermissionState> {
  LocationRepository repository;

  LocationPermissionBloc({
    required this.repository,
    required this.prefHelper,
  }) : super(LocationPermissionInitial()) {
    on<LocationPermissionInitEvent>(init);
    on<UpdateLocationEvent>(updateLocation);
    on<LocationPermissionCheckEvent>(checkLocationPermission);
    on<LocationPermissionUpdateEvent>(locationPermissionUpdate);
    on<StartLocationEvent>((event, emit) {
      debugPrint("Event: StartLocationEvent");
      startFetchLocation();
    });
    on<EndLocationEvent>((event, emit) {
      stopFetchLocation();
    });
  }

  final SharedPrefHelper prefHelper;
  late StreamSubscription<Position> locationSubscription;
  Timer? _timer;

  Future<void> init(
    LocationPermissionInitEvent event,
    Emitter<LocationPermissionState> emit,
  ) async {
    if (event.isStop) {
      stopFetchLocation();
      prefHelper.set(SharedPrefHelper.enableLocation, false);
      emit(LocationPermissionCheck(isEnable: false));
    } else {
      emit(LocationPermissionInitial());
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        emit(
          LocationPermissionError(message: 'deniedForever'),
        );
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          prefHelper.set(SharedPrefHelper.enableLocation, false);
          emit(
            LocationPermissionError(
              message: 'Location services are denied.',
            ),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        prefHelper.set(SharedPrefHelper.enableLocation, false);
        emit(LocationPermissionError(message: 'deniedForever'));
        return;
      }
      // final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      bool? enableLocation = await prefHelper.get(
        SharedPrefHelper.enableLocation,
        defaultValue: false,
      );
      print("Location Toggle : $enableLocation");

      emit(LocationPermissionCheck(isEnable: enableLocation ?? false));
      if (enableLocation == true) {
        startFetchLocation();
      } else {
        stopFetchLocation();
      }
    }
  }

  Future<void> checkLocationPermission(
    LocationPermissionCheckEvent event,
    Emitter<LocationPermissionState> emit,
  ) async {
    // Test if location services are enabled.
    bool enableLocation = await prefHelper.get(
      SharedPrefHelper.enableLocation,
      defaultValue: false,
    );
    if (!enableLocation) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return;
    }
    startFetchLocation();
    emit(LocationPermissionCheck(isEnable: enableLocation));
  }

  Future<void> locationPermissionUpdate(
    LocationPermissionUpdateEvent event,
    Emitter<LocationPermissionState> emit,
  ) async {
    emit(LocationPermissionCheck(isEnable: event.status));
    logger.i("Location Status: ${event.status}");
    await prefHelper.set(SharedPrefHelper.enableLocation, event.status);
    if (event.status) {
      startFetchLocation();
    } else {
      stopFetchLocation();
    }
  }

  void startFetchLocation() {
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) async {
      Position position = await Geolocator.getCurrentPosition();
      bool enableLocation = await prefHelper.get(
        SharedPrefHelper.enableLocation,
      );
      if (userType == UserType.fe && enableLocation) {
        try {
          await repository.updateUserLocation(position: position);
          userLastPosition = position;
        } catch (e) {
          logger.e('Location update error ===> $e');
        }
      } else {
        stopFetchLocation();
      }
    });
  }

  void updateLocation(
    UpdateLocationEvent event,
    Emitter<LocationPermissionState> emit,
  ) async {
    Position position = await Geolocator.getCurrentPosition();
    bool enableLocation = await prefHelper.get(
      SharedPrefHelper.enableLocation,
    );
    if (userType == UserType.fe && enableLocation) {
      try {
        await repository.updateUserLocation(position: position);
        logger.i('FE Current Location Updated ===> $position');
        userLastPosition = position;
      } catch (e) {
        logger.e('Location update error ===> $e');
      }
    } else {
      stopFetchLocation();
      logger.e('Location Toggle is Disabled');
    }
  }

  void stopFetchLocation() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }
}
