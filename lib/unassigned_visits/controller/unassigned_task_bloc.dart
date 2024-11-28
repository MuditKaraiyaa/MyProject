// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbridge/common/utils/date_extention.dart';

import '../../common/constants/globals.dart';
import '../data/model/unassigned_task_entity.dart';
import '../data/unassigned_task_repositories.dart';

part 'unassigned_task_event.dart';
part 'unassigned_task_state.dart';

class UnassignedTaskBloc extends Bloc<UnassignedTaskEvent, UnassignedTaskState> {
  UnassignedTasksRepository repository;

  UnassignedTaskBloc({required this.repository}) : super(UnassignedTaskLoadingState()) {
    on<LoadUnassignedTaskEvent>(_loadTasks);
    on<LoadFieldEngineerTaskByIDEvent>(_loadTaskListByID);
  }

  Future<void> _loadTasks(
    LoadUnassignedTaskEvent _,
    Emitter<UnassignedTaskState> emit,
  ) async {
    try {
      UnassignedTaskEntity data = await repository.getTasks();
      emit(
        UnassignedTaskLoadedState(response: data.result ?? []),
      );
    } catch (e) {
      emit(
        UnassignedTaskErrorState(message: e.toString()),
      );
    }
  }

  // Future<void> _loadTaskList(
  //   LoadFieldEngineerTaskByIDEvent event,
  //   Emitter<UnassignedTaskState> emit,
  // ) async {
  //   emit(FieldEngineerTaskLoadingState());
  //   try {
  //     UnassignedTaskEntity data = await repository.getTasksById(
  //       id: event.id,
  //     );
  //     emit(
  //       FieldEngineerTaskLoadedState(response: data.result ?? []),
  //     );
  //   } catch (e) {
  //     emit(
  //       FieldEngineerTaskErrorState(message: e.toString()),
  //     );
  //   }
  // }

  Future<void> _loadTaskListByID(
    LoadFieldEngineerTaskByIDEvent event,
    Emitter<UnassignedTaskState> emit,
  ) async {
    if (!event.softReload) {
      emit(FieldEngineerTaskLoadingState());
    }
    try {
      if (event.id == inProgressAcceptedTaskStatus) {
        // Accepted Tab
        UnassignedTaskEntity data = await repository.getAcceptedTasks(
          uName: event.userName ?? '',
        );
        List<UnassignedTaskResult> list = [];
        for (UnassignedTaskResult e in data.result ?? []) {
          if ((e.state?.toLowerCase() != 'closed' &&
                  e.state?.toLowerCase() != 'cancelled' &&
                  e.state?.toLowerCase() != 'additional visit required') ||
              (e.state?.toLowerCase() == 'resolved' &&
                  e.uCustomerSatisfaction == null &&
                  e.uPreferredScheduleByCustomer != '' &&
                  DateTime.now().isSameDate(
                    DateTime.parse(e.uPreferredScheduleByCustomer ?? ''),
                  ))) {
            list.add(e);
          }
        }
        emit(
          FieldEngineerTaskLoadedState(response: list),
        );
      } else if (event.id == openNewTaskStatus) {
        // New tasks
        UnassignedTaskEntity data = await repository.getNewTasks(
          uName: event.userName ?? '',
        );
        emit(
          FieldEngineerTaskLoadedState(response: data.result ?? []),
        );
      } else if (event.id == completeTaskStatus) {
        // Resolved tasks
        UnassignedTaskEntity data = await repository.getResolvedTasks(
          uName: event.userName ?? '',
        );
        List<UnassignedTaskResult> list = [];
        for (UnassignedTaskResult e in data.result ?? []) {
          if ((e.state?.toLowerCase() == 'closed' &&
                  e.state?.toLowerCase() == 'additional visit required') ||
              (e.state?.toLowerCase() == 'resolved' && e.uCustomerSatisfaction != null)) {
            list.add(e);
          }
        }
        emit(
          FieldEngineerTaskLoadedState(response: list),
        );
      } else {
        // Incomplete
        UnassignedTaskEntity data = await repository.getIncompleteTasks(
          uName: event.userName ?? '',
        );
        List<UnassignedTaskResult> list = [];
        for (UnassignedTaskResult e in data.result ?? []) {
          if (e.uCustomerSatisfaction == null) {
            if (e.uPreferredScheduleByCustomer != '') {
              DateTime taskTime = DateTime.parse(e.uPreferredScheduleByCustomer ?? '');
              if (DateTime.now().compareTo(taskTime) == 1) {
                // Past date
                list.add(e);
              }
            } else {
              list.add(e);
            }
          }
        }
        emit(
          FieldEngineerTaskLoadedState(response: data.result ?? []),
        );
      }
    } catch (e) {
      emit(
        FieldEngineerTaskErrorState(message: e.toString()),
      );
    }
  }
}
