part of 'location_permission_bloc.dart';

abstract class LocationPermissionEvent extends Equatable {}

class LocationPermissionInitEvent extends LocationPermissionEvent {
  final bool isStop;
  LocationPermissionInitEvent({this.isStop = false});
  @override
  List<Object?> get props => [isStop];
}

class LocationPermissionCheckEvent extends LocationPermissionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LocationPermissionErrorEvent extends LocationPermissionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LocationPermissionUpdateEvent extends LocationPermissionEvent {
  final bool status;
  LocationPermissionUpdateEvent({this.status = false});
  @override
  List<Object?> get props => [status];
}

class LocationPermissionExtraEvent extends LocationPermissionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class StartLocationEvent extends LocationPermissionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class EndLocationEvent extends LocationPermissionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UpdateLocationEvent extends LocationPermissionEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
