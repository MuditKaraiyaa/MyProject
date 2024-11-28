import 'package:equatable/equatable.dart';

import '../../unassigned_visits/data/model/unassigned_task_entity.dart';

abstract class FieldEngineerTaskListState extends Equatable {}

class FieldEngineerTaskListLoadingState extends FieldEngineerTaskListState {
  @override
  List<Object> get props => [];
}

class FieldEngineerAllTaskLoadedState extends FieldEngineerTaskListState {
  final Map<String, List<UnassignedTaskResult>> data;

  FieldEngineerAllTaskLoadedState({required this.data});

  @override
  List<Object> get props => [data];
}

class FieldEngineerTaskLoadedState extends FieldEngineerTaskListState {
  final List<UnassignedTaskResult> response;

  FieldEngineerTaskLoadedState({required this.response});

  @override
  List<Object> get props => [response];
}

class FieldEngineerTaskErrorState extends FieldEngineerTaskListState {
  final String message;

  FieldEngineerTaskErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

extension XFieldEngineerAllTaskLoadedState on FieldEngineerAllTaskLoadedState {
  List<UnassignedTaskResult>? getTasksByDate({required String date}) {
    return data[date];
  }
}
