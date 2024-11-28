// Importing necessary packages and files
import 'dart:convert';
import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/network/api_provider.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/task_details/data/models/case_detail_entity.dart';
import '../../../main.dart';
import '../models/task_detail_entity.dart';
import '../models/task_field_engineer_entity.dart';

// Abstract class defining the contract for the task details repository
abstract class TaskDetailsRepository {
  Future<TaskDetailEntity> getTaskDetails({required String id});
  Future<CaseDetailEntity> caseDetail({required String id});
  Future<TaskFieldEngineerEntity> taskEngineers({required String id});
  Future<TaskDetailEntity> updateTask({
    required String id,
    required Map<String, dynamic> data,
  });
  Future updateTaskTiming({
    required String id,
    required Map<String, dynamic> data,
  });
}

// Implementation of the TaskDetailsRepository interface
class TaskDetailsRepositoryImpl implements TaskDetailsRepository {
  final APIProvider provider;

  TaskDetailsRepositoryImpl({required this.provider});

  @override
  Future<TaskDetailEntity> getTaskDetails({required String id}) async {
    var addedRecord = await getLocalData(
      Constants.tblManagerTaskDetails,
      TaskDetailEntity,
      identifier: id,
    );

    if (addedRecord == null) {
      final response = await provider.getMethod(APIConstant.API_Task_Details + id);
      addToDatabase(
        Constants.tblManagerTaskDetails,
        TaskDetailEntity,
        TaskDetailEntity.fromJson(response),
        identifier: id,
      );
      return TaskDetailEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<CaseDetailEntity> caseDetail({required String id}) async {
    var addedRecord = await getLocalData(
      Constants.tblFECaseDetails,
      CaseDetailEntity,
      identifierName: "task.sys_id",
      identifier: id,
    );

    if (addedRecord == null) {
      final response = await provider.getMethod(APIConstant.caseDetail + id);
      logger.i(getJson(response));
      addToDatabase(
        Constants.tblFECaseDetails,
        CaseDetailEntity,
        identifierName: "task.sys_id",
        CaseDetailEntity.fromJson(response),
        identifier: id,
      );
      return CaseDetailEntity.fromJson(response);
    }
    return addedRecord;
  }

  @override
  Future<TaskFieldEngineerEntity> taskEngineers({required String id}) async {
    var addedRecord = await getLocalData(
      Constants.tblTaskEngineersList,
      TaskFieldEngineerEntity,
      identifierName: "task_id",
      identifier: id,
    );

    if (addedRecord == null) {
      final response = await provider.getMethod(APIConstant.taskEngineerList + id);
      response['result']['task_id'] = id;
      logger.f("=>>>>>>>>>>>>>>>>>>>>>${response['result']}");
      addToDatabase(
        Constants.tblTaskEngineersList,
        TaskFieldEngineerEntity,
        response,
        identifierName: "task_id",
        identifier: id,
      );
      return TaskFieldEngineerEntity.fromJson(response);
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
  Future updateTaskTiming({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    final response = await provider.patchMethod(
      '${APIConstant.updateTaskNewAPI}$id',
      data: jsonEncode(data),
    );
    return response;
  }
}
