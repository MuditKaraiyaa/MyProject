part of 'location_permission_bloc.dart';

abstract class LocationPermissionState extends Equatable {}

class LocationPermissionInitial extends LocationPermissionState {
  @override
  List<Object> get props => [];
}

class LocationPermissionError extends LocationPermissionState {
  final String message;
  LocationPermissionError({required this.message});
  @override
  List<Object> get props => [message];
}

class LocationPermissionCheck extends LocationPermissionState {
  final bool isEnable;
  final Position? position;
  LocationPermissionCheck({required this.isEnable, this.position});
  @override
  List<Object> get props => [isEnable];
}