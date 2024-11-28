import 'package:xbridge/generated/json/base/json_convert_content.dart';
import 'package:xbridge/task_details/data/models/task_field_engineer_entity.dart';

TaskFieldEngineerEntity $TaskFieldEngineerEntityFromJson(
    Map<String, dynamic> json) {
  final TaskFieldEngineerEntity taskFieldEngineerEntity = TaskFieldEngineerEntity();
  final TaskFieldEngineerResult? result = jsonConvert.convert<
      TaskFieldEngineerResult>(json['result']);
  if (result != null) {
    taskFieldEngineerEntity.result = result;
  }
  return taskFieldEngineerEntity;
}

Map<String, dynamic> $TaskFieldEngineerEntityToJson(
    TaskFieldEngineerEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result?.toJson();
  return data;
}

extension TaskFieldEngineerEntityExtension on TaskFieldEngineerEntity {
  TaskFieldEngineerEntity copyWith({
    TaskFieldEngineerResult? result,
  }) {
    return TaskFieldEngineerEntity()
      ..result = result ?? this.result;
  }
}

TaskFieldEngineerResult $TaskFieldEngineerResultFromJson(
    Map<String, dynamic> json) {
  final TaskFieldEngineerResult taskFieldEngineerResult = TaskFieldEngineerResult();
  final List<
      TaskFieldEngineerResultFieldEngineers>? fieldEngineers = (json['field_engineers'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<TaskFieldEngineerResultFieldEngineers>(
          e) as TaskFieldEngineerResultFieldEngineers).toList();
  if (fieldEngineers != null) {
    taskFieldEngineerResult.fieldEngineers = fieldEngineers;
  }
  return taskFieldEngineerResult;
}

Map<String, dynamic> $TaskFieldEngineerResultToJson(
    TaskFieldEngineerResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['field_engineers'] =
      entity.fieldEngineers?.map((v) => v.toJson()).toList();
  return data;
}

extension TaskFieldEngineerResultExtension on TaskFieldEngineerResult {
  TaskFieldEngineerResult copyWith({
    List<TaskFieldEngineerResultFieldEngineers>? fieldEngineers,
  }) {
    return TaskFieldEngineerResult()
      ..fieldEngineers = fieldEngineers ?? this.fieldEngineers;
  }
}

TaskFieldEngineerResultFieldEngineers $TaskFieldEngineerResultFieldEngineersFromJson(
    Map<String, dynamic> json) {
  final TaskFieldEngineerResultFieldEngineers taskFieldEngineerResultFieldEngineers = TaskFieldEngineerResultFieldEngineers();
  final String? userName = jsonConvert.convert<String>(json['user_name']);
  if (userName != null) {
    taskFieldEngineerResultFieldEngineers.userName = userName;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    taskFieldEngineerResultFieldEngineers.name = name;
  }
  final String? sysId = jsonConvert.convert<String>(json['sys_id']);
  if (sysId != null) {
    taskFieldEngineerResultFieldEngineers.sysId = sysId;
  }
  final String? taskCount = jsonConvert.convert<String>(json['task_count']);
  if (taskCount != null) {
    taskFieldEngineerResultFieldEngineers.taskCount = taskCount;
  }
  return taskFieldEngineerResultFieldEngineers;
}

Map<String, dynamic> $TaskFieldEngineerResultFieldEngineersToJson(
    TaskFieldEngineerResultFieldEngineers entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user_name'] = entity.userName;
  data['name'] = entity.name;
  data['sys_id'] = entity.sysId;
  data['task_count'] = entity.taskCount;
  return data;
}

extension TaskFieldEngineerResultFieldEngineersExtension on TaskFieldEngineerResultFieldEngineers {
  TaskFieldEngineerResultFieldEngineers copyWith({
    String? userName,
    String? name,
    String? sysId,
    String? taskCount,
  }) {
    return TaskFieldEngineerResultFieldEngineers()
      ..userName = userName ?? this.userName
      ..name = name ?? this.name
      ..sysId = sysId ?? this.sysId
      ..taskCount = taskCount ?? this.taskCount;
  }
}