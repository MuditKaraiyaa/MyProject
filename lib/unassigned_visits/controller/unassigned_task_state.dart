part of 'unassigned_task_bloc.dart';

abstract class UnassignedTaskState extends Equatable {}

class UnassignedTaskLoadingState extends UnassignedTaskState {
  @override
  List<Object> get props => [];
}

class UnassignedTaskLoadedState extends UnassignedTaskState {
  final List<UnassignedTaskResult> response;

  UnassignedTaskLoadedState({required this.response});

  @override
  List<Object> get props => [response];
}

class UnassignedTaskErrorState extends UnassignedTaskState {
  final String message;

  UnassignedTaskErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class FieldEngineerTaskLoadingState extends UnassignedTaskState {
  @override
  List<Object> get props => [];
}

class FieldEngineerTaskLoadedState extends UnassignedTaskState {
  final List<UnassignedTaskResult> response;

  FieldEngineerTaskLoadedState({required this.response});

  @override
  List<Object> get props => [response];
}

class FieldEngineerTaskErrorState extends UnassignedTaskState {
  final String message;

  FieldEngineerTaskErrorState({required this.message});

  @override
  List<Object> get props => [message];
}