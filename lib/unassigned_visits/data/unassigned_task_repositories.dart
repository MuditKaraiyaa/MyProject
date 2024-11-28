import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/unassigned_visits/data/model/unassigned_task_entity.dart';

import '../../common/constants/api_constant.dart';
import '../../common/constants/globals.dart';
import '../../common/network/api_provider.dart';
import '../../main.dart';

abstract class UnassignedTasksRepository {
  Future<UnassignedTaskEntity> getTasks();

  Future<UnassignedTaskEntity> getTasksById({required int id});

  Future<UnassignedTaskEntity> getAcceptedTasks({required String uName});

  Future<UnassignedTaskEntity> getResolvedTasks({required String uName});

  Future<UnassignedTaskEntity> getNewTasks({required String uName});

  Future<UnassignedTaskEntity> getIncompleteTasks({required String uName});
}

class UnassignedTasksRepositoryImpl implements UnassignedTasksRepository {
  final APIProvider provider;

  UnassignedTasksRepositoryImpl({required this.provider});

  @override
  Future<UnassignedTaskEntity> getTasks() async {
    var addedRecord = await getLocalData(
      Constants.tblManagerUnAssignedTaskList,
      UnassignedTaskEntity,
    );
    if (addedRecord == null) {
      final response = await provider.getMethod(APIConstant.taskListManager);
      addToDatabase(
        Constants.tblManagerUnAssignedTaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
      );
      logger.i(response);
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<UnassignedTaskEntity> getTasksById({required int id}) async {
    // final response =
    //     await provider.getMethod('${APIConstant.taskByStatusManager}$id');
    // return UnassignedTaskEntity.fromJson(response);

    var addedRecord = await getLocalData(
      Constants.tblManagerTaskList,
      UnassignedTaskEntity,
      taskStatus: id,
    );
    if (addedRecord == null) {
      final response =
          await provider.getMethod('${APIConstant.taskByStatusManager}$id');
      addToDatabase(
        Constants.tblManagerTaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
        taskStatus: id,
      );
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<UnassignedTaskEntity> getAcceptedTasks({required String uName}) async {
    var addedRecord = await getLocalData(
      Constants.tblManagerTaskList,
      UnassignedTaskEntity,
      taskStatus: acceptedTaskStatus,
    );
    if (addedRecord == null) {
      final response =
          await provider.getMethod(APIConstant.getAcceptedTasks + uName);
      addToDatabase(
        Constants.tblManagerTaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
        taskStatus: acceptedTaskStatus,
      );
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<UnassignedTaskEntity> getResolvedTasks({required String uName}) async {
    var addedRecord = await getLocalData(
      Constants.tblManagerTaskList,
      UnassignedTaskEntity,
      taskStatus: completeTaskStatus,
    );
    if (addedRecord == null) {
      final response =
          await provider.getMethod(APIConstant.getResolveTasks + uName);
      addToDatabase(
        Constants.tblManagerTaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
        taskStatus: completeTaskStatus,
      );
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<UnassignedTaskEntity> getIncompleteTasks(
      {required String uName}) async {
    var addedRecord = await getLocalData(
      Constants.tblManagerTaskList,
      UnassignedTaskEntity,
      taskStatus: inCompleteTaskStatus,
    );
    if (addedRecord == null) {
      final response =
          await provider.getMethod(APIConstant.getIncompleteTasks + uName);
      addToDatabase(
        Constants.tblManagerTaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
        taskStatus: inCompleteTaskStatus,
      );
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<UnassignedTaskEntity> getNewTasks({required String uName}) async {
    var addedRecord = await getLocalData(
      Constants.tblManagerTaskList,
      UnassignedTaskEntity,
      taskStatus: openNewTaskStatus,
    );
    if (addedRecord == null) {
      final response =
          await provider.getMethod(APIConstant.getNewTasks + uName);
      addToDatabase(
        Constants.tblManagerTaskList,
        UnassignedTaskEntity,
        UnassignedTaskEntity.fromJson(response),
        taskStatus: openNewTaskStatus,
      );
      return UnassignedTaskEntity.fromJson(response);
    }
    return addedRecord;
  }
}
