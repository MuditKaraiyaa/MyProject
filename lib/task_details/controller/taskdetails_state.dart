import 'package:equatable/equatable.dart';

import '../data/models/case_detail_entity.dart';
import '../data/models/task_field_engineer_entity.dart';

// Abstract class representing states related to Task Details
abstract class TaskDetailState extends Equatable {}

// State representing loading state for Task Details
class TaskDetailsLoadingState extends TaskDetailState {
  @override
  List<Object> get props => [];
}

// State representing loaded state for Task Details
class TaskDetailslLoadedState extends TaskDetailState {
  final CaseDetailEntity response;
  final List<TaskFieldEngineerResultFieldEngineers> engList;

  TaskDetailslLoadedState({required this.response, required this.engList});

  @override
  List<Object> get props => [response, engList];
}

// State representing error state for Task Details
class TaskDetailsErrorState extends TaskDetailState {
  final String message;

  TaskDetailsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

// State representing loaded state for Task Engineers
class TaskEngineerLoadedState extends TaskDetailState {
  final List<TaskFieldEngineerResultFieldEngineers> response;

  TaskEngineerLoadedState({required this.response});

  @override
  List<Object> get props => [response];
}

// State representing going back from Task Engineers
class TaskEngineerBackState extends TaskDetailState {
  TaskEngineerBackState();

  @override
  List<Object> get props => [];
}
