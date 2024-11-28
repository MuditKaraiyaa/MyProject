part of 'unassigned_task_bloc.dart';

abstract class UnassignedTaskEvent extends Equatable {}

class LoadUnassignedTaskEvent extends UnassignedTaskEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadFieldEngineerTaskByIDEvent extends UnassignedTaskEvent {
  final int id;
  final bool softReload;
  final String? userName;
  LoadFieldEngineerTaskByIDEvent({
    required this.id,
    this.userName,
    this.softReload = false,
  });
  @override
  List<Object?> get props => [id, userName];
}
