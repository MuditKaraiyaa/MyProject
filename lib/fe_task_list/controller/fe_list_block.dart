// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/offline/model/offline_table.dart';
import 'package:xbridge/common/utils/date_extention.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/fe_task_list/controller/fe_list_event.dart';
import 'package:xbridge/fe_task_list/controller/fe_list_state.dart';
import 'package:xbridge/fe_task_list/data/fe_task_list_repositories.dart';

import '../../task_details/data/models/task_detail_entity.dart';
import '../../unassigned_visits/data/model/unassigned_task_entity.dart';

class FieldEngineerTaskListBlock
    extends Bloc<FieldEngineerTaskListEvent, FieldEngineerTaskListState> {
  FieldEngineerTaskListRepository repository;

  FieldEngineerTaskListBlock({required this.repository})
      : super(FieldEngineerTaskListLoadingState()) {
    on<LoadFieldEngineerTaskListEvent>(_loadTaskList);
    on<LoadFieldEngineerTaskListByIDEvent>(_loadTaskListByID);
    on<LoadFieldEngineerTaskUpdateEvent>(_updateTask);
  }

  Future<void> _loadTaskList(
    LoadFieldEngineerTaskListEvent event,
    Emitter<FieldEngineerTaskListState> emit,
  ) async {
    try {
      emit(FieldEngineerTaskListLoadingState());
      UnassignedTaskEntity data = await repository.getAllTasks(isInComplete: event.isInComplete);
      if (event.isInComplete) {
        List<UnassignedTaskResult> list = [];
        for (UnassignedTaskResult e in data.result ?? []) {
          if (e.uPreferredScheduleByCustomer == '') {
            if (e.state?.toLowerCase() != 'cancelled' && e.state?.toLowerCase() != 'resolved') {
              list.add(e);
            }
          } else {
            DateTime taskTime = DateTime.parse(e.uPreferredScheduleByCustomer ?? '');
            if ((e.state?.toLowerCase() != 'cancelled') &&
                (e.state?.toLowerCase() != 'resolved') &&
                (DateTime.now().compareTo(taskTime) == -1)) {
              // -1 means future date
              list.add(e);
            }
          }
        }
        emit(
          FieldEngineerTaskLoadedState(response: list),
        );
      } else {
        Map<String, List<UnassignedTaskResult>> dateWiseData = {};
        dateWiseData =
            data.result!.groupListsBy((e) => DateTime.parse(e.sysCreatedOn ?? '').onlyDate);

        emit(
          FieldEngineerAllTaskLoadedState(data: dateWiseData),
        );
      }
    } catch (e) {
      emit(
        FieldEngineerTaskErrorState(message: e.toString()),
      );
    }
  }

  Future<void> _loadTaskListByID(
    LoadFieldEngineerTaskListByIDEvent event,
    Emitter<FieldEngineerTaskListState> emit,
  ) async {
    if (!event.softReload) {
      emit(FieldEngineerTaskListLoadingState());
    }
    try {
      if (event.id == inProgressAcceptedTaskStatus) {
        // Accepted Tab
        UnassignedTaskEntity data = await repository.getAcceptedTasks();
        List<UnassignedTaskResult> list = [];
        for (UnassignedTaskResult e in data.result ?? []) {
          if (e.state?.toLowerCase() == 'resolved' &&
              e.uCustomerSatisfaction == null &&
              e.uPreferredScheduleByCustomer != '' &&
              DateTime.now().isSameDate(
                DateTime.parse(e.uPreferredScheduleByCustomer ?? ''),
              )) {
            list.add(e);
          } else if ((e.state?.toLowerCase() != 'closed' &&
              e.state?.toLowerCase() != 'cancelled' &&
              e.state?.toLowerCase() != 'resolved' &&
              e.state?.toLowerCase() != 'additional visit required')) {
            list.add(e);
          }
        }
        emit(
          FieldEngineerTaskLoadedState(response: list),
        );
      } else if (event.id == openNewTaskStatus) {
        // New tasks
        UnassignedTaskEntity data = await repository.getNewTasks();

        emit(
          FieldEngineerTaskLoadedState(response: data.result ?? []),
        );
      } else if (event.id == completeTaskStatus) {
        // Resolved tasks
        UnassignedTaskEntity data = await repository.getResolvedTasks();
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
        UnassignedTaskEntity data = await repository.getIncompleteTasks();
        List<UnassignedTaskResult> list = [];
        for (UnassignedTaskResult e in data.result ?? []) {
          if (e.uCustomerSatisfaction == null) {
            if (e.uPreferredScheduleByCustomer != '') {
              DateTime taskTime = DateTime.parse(e.uPreferredScheduleByCustomer ?? '');
              if (!DateTime.now().isSameDate(taskTime)) {
                // Past date
                list.add(e);
              }
            }
          }
        }
        emit(
          FieldEngineerTaskLoadedState(response: list),
        );
      }
    } catch (e) {
      emit(
        FieldEngineerTaskErrorState(message: e.toString()),
      );
    }
  }

  Future<void> _updateTask(
    LoadFieldEngineerTaskUpdateEvent event,
    Emitter<FieldEngineerTaskListState> emit,
  ) async {
    if (isInternetAvailable) {
      emit(FieldEngineerTaskListLoadingState());
      try {
        TaskDetailEntity data = await repository.updateTask(
          id: event.id,
          data: event.data,
        );
        if (data.result != null) {
          // if (event.currentTabStatus == cancelledTaskStatus) {
          //   add(LoadFieldEngineerTaskListEvent(isInComplete: true));
          // } else {
          deleteTableFromDatabase(Constants.tblFETaskList)
              .then((value) => add(LoadFieldEngineerTaskListByIDEvent(id: event.currentTabStatus)));
          // }
        }
      } catch (e) {
        emit(
          FieldEngineerTaskErrorState(message: e.toString()),
        );
      }
    } else {
      UnsyncAPI apiData = UnsyncAPI();
      apiData.apiMethod = "put";
      apiData.apiName = '${APIConstant.updateTaskAPI}${event.id}';
      apiData.parameters = event.data;
      apiData.isSync = false;
      addToUnSyncedAPITable(apiData);
    }
  }
}
