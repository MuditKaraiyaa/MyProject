import 'package:equatable/equatable.dart';

abstract class FieldEngineerTaskListEvent extends Equatable {}

class LoadFieldEngineerTaskListEvent extends FieldEngineerTaskListEvent {
  final bool isInComplete;
  LoadFieldEngineerTaskListEvent({this.isInComplete = false});
  @override
  List<Object?> get props => [isInComplete];
}

class LoadFieldEngineerTaskListByIDEvent extends FieldEngineerTaskListEvent {
  final int id;
  final bool softReload;
  LoadFieldEngineerTaskListByIDEvent({
    required this.id,
    this.softReload = false,
  });

  @override
  List<Object?> get props => [id];
}

class LoadFieldEngineerTaskListByStatusEvent extends FieldEngineerTaskListEvent {
  final int status;

  LoadFieldEngineerTaskListByStatusEvent({required this.status});

  @override
  List<Object?> get props => [status];
}

class LoadFieldEngineerTaskUpdateEvent extends FieldEngineerTaskListEvent {
  final String id;
  final int currentTabStatus;
  final String? toastMessage;
  final Map<String, dynamic> data;

  LoadFieldEngineerTaskUpdateEvent({
    required this.id,
    required this.data,
    required this.currentTabStatus,
    this.toastMessage,
  });

  @override
  List<Object?> get props => [id, data, currentTabStatus];
}
