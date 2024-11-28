// Importing necessary packages and files
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/offline/model/offline_table.dart';
import 'package:xbridge/common/routes/route_config.dart';
import 'package:xbridge/common/utils/context_extension.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/location_update/controller/location_permission_bloc.dart';
import 'package:xbridge/task_details/controller/taskdetails_event.dart';
import 'package:xbridge/task_details/controller/taskdetails_state.dart';
import 'package:xbridge/task_details/data/models/case_detail_entity.dart';
import 'package:xbridge/task_details/data/models/task_detail_entity.dart';
import 'package:xbridge/task_details/data/models/task_field_engineer_entity.dart';
import 'package:xbridge/task_details/data/repositories/task_details_repositories.dart';

import '../../common/constants/constants.dart';
import '../../common/constants/globals.dart';
import '../../main.dart';

// Bloc class for Task Details
class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailState> {
  TaskDetailsRepository repository;

  TaskDetailsBloc({required this.repository}) : super(TaskDetailsLoadingState()) {
    // Event handlers
    on<TaskDetailsFetchDataEvent>(_getCaseDetail);
    on<TaskDetailsEngineerListEvent>(_loadTaskEngineers);
    on<TaskDetailsUpdateDataEvent>(_updateTask);
    on<TaskDetailsUpdateDataEventNew>(_updateTaskTiming);
    on<TaskDetailsEngineerBackEvent>(
      (event, emit) => emit(TaskEngineerBackState()),
    );
  }

  // Fetch case detail from repository
  Future<void> _getCaseDetail(
    TaskDetailsFetchDataEvent event,
    Emitter<TaskDetailState> emit,
  ) async {
    try {
      CaseDetailEntity result = await repository.caseDetail(id: event.id);
      emit(TaskDetailslLoadedState(response: result, engList: const []));
      if (userType == UserType.fm) {
        add(TaskDetailsEngineerListEvent(result: result));
      }
    } catch (e) {
      emit(TaskDetailsErrorState(message: e.toString()));
      logger.e('Error fetching case detail: $e');
    }
  }

  // Load task engineers from repository
  Future<void> _loadTaskEngineers(
    TaskDetailsEngineerListEvent event,
    Emitter<TaskDetailState> emit,
  ) async {
    try {
      TaskFieldEngineerEntity data = await repository.taskEngineers(
        id: event.result.result?.task?.number ?? '',
      );
      logger.i(">>>>>>${data.result?.fieldEngineers}");
      emit(
        TaskDetailslLoadedState(
          engList: data.result?.fieldEngineers ?? [],
          response: event.result,
        ),
      );
      logger.i('Task engineers loaded successfully');
    } catch (e) {
      emit(
        TaskDetailsErrorState(message: e.toString()),
      );
      logger.e('Error loading task engineers: $e');
    }
  }

  // Update task details
  Future<void> _updateTask(
    TaskDetailsUpdateDataEvent event,
    Emitter<TaskDetailState> emit,
  ) async {
    emit(TaskDetailsLoadingState());
    if (isInternetAvailable) {
      try {
        debugPrint("event.id: ${event.id}");
        debugPrint("event.data: ${event.data}");
        TaskDetailEntity data = await repository.updateTask(
          id: event.id,
          data: event.data,
        );
        if (data.result != null) {
          if (event.callUpdateTimeAPi) {
            var data = await repository.updateTaskTiming(
              id: event.taskNumber ?? "",
              data: {
                'u_eta_provided_vendor_to_tig': event.selectedDate,
              },
            );
            getJson(data);
          }
          geofenceStatusValueNotifier.value = GeofenceStatus.ENTER;
          showLoading(value: false);
          AppRouter.router.routerDelegate.navigatorKey.currentContext!.showSuccess(
            msg: event.toastMessage ?? 'Task assigned successfully',
          );
          if (event.isBack) {
            AppRouter.router.pop();
          }
        }
      } catch (e) {
        showLoading(value: false);
        emit(
          TaskDetailsErrorState(message: e.toString()),
        );
      }
    } else {
      showLoading(value: false);
      // Add task details to unsynced API table if no internet connection
      UnsyncAPI apiData = UnsyncAPI();
      apiData.apiMethod = "put";
      apiData.apiName = '${APIConstant.updateTaskAPI}${event.id}';
      apiData.parameters = event.data;
      apiData.isSync = false;
      addToUnSyncedAPITable(apiData);
    }
  }

  // Update task timing
  Future<void> _updateTaskTiming(
    TaskDetailsUpdateDataEventNew event,
    Emitter emit,
  ) async {
    if (isInternetAvailable) {
      try {
        logger.i(event.id);
        var data = await repository.updateTaskTiming(
          id: event.id,
          data: event.data,
        );
        if (data["result"]["result"] != null) {
          getJson(data);
          showLoading(value: false);
          AppRouter.router.routerDelegate.navigatorKey.currentContext!
              .showSuccess(msg: event.toastMessage ?? '');
          if (event.taskId != null) {
            await deleteDatabase();
            AppRouter.router.routerDelegate.navigatorKey.currentContext!
                .read<LocationPermissionBloc>()
                .add(UpdateLocationEvent());
            add(TaskDetailsFetchDataEvent(id: event.taskId!));
          }
        }
      } catch (e) {
        showLoading(value: false);
        emit(
          TaskDetailsErrorState(message: e.toString()),
        );
      }
    } else {
      showLoading(value: false);
      // Add task timing update to unsynced API table if no internet connection
      UnsyncAPI apiData = UnsyncAPI();
      apiData.apiMethod = "patch";
      apiData.apiName = '${APIConstant.updateTaskNewAPI}${event.id}';
      apiData.parameters = event.data;
      apiData.isSync = false;
      addToUnSyncedAPITable(apiData);
    }
  }

  // Delete data from local database
  Future<void> deleteDatabase() async {
    final result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      await deleteTableFromDatabase(Constants.tblFECaseDetails);
    }
  }
}
