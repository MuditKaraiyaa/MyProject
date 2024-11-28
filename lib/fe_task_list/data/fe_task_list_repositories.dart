import 'dart:convert';

import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/utils/util.dart';

import '../../common/constants/api_constant.dart';
import '../../common/constants/globals.dart';
import '../../common/network/api_provider.dart';
import '../../task_details/data/models/task_detail_entity.dart';
import '../../unassigned_visits/data/model/unassigned_task_entity.dart';

abstract class FieldEngineerTaskListRepository {
  Future<UnassignedTaskEntity> getTasksById({required int id});

  Future<TaskDetailEntity> updateTask({
    required String id,
    required Map<String, dynamic> data,
  });

  Future<UnassignedTaskEntity> getAllTasks({bool isInComplete = false});

  Future<UnassignedTaskEntity> getAcceptedTasks();
  Future<UnassignedTaskEntity> getResolvedTasks();
  Future<UnassignedTaskEntity> getNewTasks();
  Future<UnassignedTaskEntity> getIncompleteTasks();
}

class FieldEngineerTaskListImpl implements FieldEngineerTaskListRepository {
  final APIProvider provider;

  FieldEngineerTaskListImpl({required this.provider});

  @override
  Future<UnassignedTaskEntity> getAllTasks({bool isInComplete = false}) async {
    if (isInComplete) {
      var addedRecord = await getLocalData(
        Constants.tblFETaskList,
        UnassignedTaskEntity,
        taskStatus: inCompleteTaskStatus,
      );
      if (addedRecord == null) {
        final response = await provider.getMethod(APIConstant.getTaskListEngineer);
        addToDatabase(
          Constants.tblFETaskList,
          UnassignedTaskEntity,
          UnassignedTaskEntity.fromJson(response),
          taskStatus: inCompleteTaskStatus,
        );
        return UnassignedTaskEntity.fromJson(response);
      }
      return addedRecord;
    } else {
      var addedRecord = await getLocalData(
        Constants.tblFETaskList,
        UnassignedTaskEntity,
        taskStatus: allTaskStatus,
      );
      if (addedRecord == null) {
        final response = await provider.getMethod(APIConstant.getTaskListEngineer);
        addToDatabase(
          Constants.tblFETaskList,
          UnassignedTaskEntity,
          UnassignedTaskEntity.fromJson(response),
          taskStatus: allTaskStatus,
        );
        return UnassignedTaskEntity.fromJson(response);
      }
      return addedRecord;
    }
  }

  @override
  Future<UnassignedTaskEntity> getTasksById({required int id}) async {
    // final response = await provider.getMethod('${APIConstant.taskByStatusEngineer}$id');
    // return UnassignedTaskEntity.fromJson(response);

    var addedRecord = await getLocalData(
      Constants.tblFETaskList,
      UnassignedTaskEntity,
      taskStatus: id,
    );
    if (addedRecord == null) {
      final response = await provider.getMethod('${APIConstant.taskByStatusEngineer}$id');
      addToDatabase(
        Constants.tblFETaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
        taskStatus: id,
      );
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<TaskDetailEntity> updateTask({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    final response = await provider.putMethod(
      '${APIConstant.updateTaskAPI}$id',
      data: jsonEncode(data),
    );
    return TaskDetailEntity.fromJson(response);
  }

  @override
  Future<UnassignedTaskEntity> getAcceptedTasks() async {
    var addedRecord = await getLocalData(
      Constants.tblFETaskList,
      UnassignedTaskEntity,
      taskStatus: acceptedTaskStatus,
    );
    if (addedRecord == null) {
      final response = await provider.getMethod(APIConstant.getAcceptedTaskListEngineer);
      addToDatabase(
        Constants.tblFETaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
        taskStatus: acceptedTaskStatus,
      );
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<UnassignedTaskEntity> getResolvedTasks() async {
    var addedRecord = await getLocalData(
      Constants.tblFETaskList,
      UnassignedTaskEntity,
      taskStatus: completeTaskStatus,
    );
    if (addedRecord == null) {
      final response = await provider.getMethod(APIConstant.getResolveTaskListEngineer);
      addToDatabase(
        Constants.tblFETaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
        taskStatus: completeTaskStatus,
      );
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<UnassignedTaskEntity> getIncompleteTasks() async {
    var addedRecord = await getLocalData(
      Constants.tblFETaskList,
      UnassignedTaskEntity,
      taskStatus: inCompleteTaskStatus,
    );
    if (addedRecord == null) {
      final response = await provider.getMethod(APIConstant.getIncompleteTaskListEngineer);
      addToDatabase(
        Constants.tblFETaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
        taskStatus: inCompleteTaskStatus,
      );
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<UnassignedTaskEntity> getNewTasks() async {
    var addedRecord = await getLocalData(
      Constants.tblFETaskList,
      UnassignedTaskEntity,
      taskStatus: openNewTaskStatus,
    );
    if (addedRecord == null) {
      final response = await provider.getMethod(APIConstant.getNewTaskListEngineer(userName));
      addToDatabase(
        Constants.tblFETaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
        taskStatus: openNewTaskStatus,
      );
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }
}
