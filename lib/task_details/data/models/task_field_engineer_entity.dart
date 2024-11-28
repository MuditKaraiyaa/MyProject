// Importing necessary packages and files
import 'package:xbridge/generated/json/base/json_field.dart';
import 'package:xbridge/generated/json/task_field_engineer_entity.g.dart';
import 'dart:convert';
export 'package:xbridge/generated/json/task_field_engineer_entity.g.dart';

// JSON Serializable class for Task Field Engineer Entity
@JsonSerializable()
class TaskFieldEngineerEntity {
  TaskFieldEngineerResult? result;

  TaskFieldEngineerEntity();

  factory TaskFieldEngineerEntity.fromJson(Map<String, dynamic> json) =>
      $TaskFieldEngineerEntityFromJson(json);

  Map<String, dynamic> toJson() => $TaskFieldEngineerEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

// JSON Serializable class for Task Field Engineer Result
@JsonSerializable()
class TaskFieldEngineerResult {
  List<TaskFieldEngineerResultFieldEngineers>? fieldEngineers;

  TaskFieldEngineerResult();

  factory TaskFieldEngineerResult.fromJson(Map<String, dynamic> json) =>
      $TaskFieldEngineerResultFromJson(json);

  Map<String, dynamic> toJson() => $TaskFieldEngineerResultToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

// JSON Serializable class for Task Field Engineer Result Field Engineers
@JsonSerializable()
class TaskFieldEngineerResultFieldEngineers {
  @JSONField(name: "user_name")
  String? userName;
  @JSONField(name: "name")
  String? name;
  @JSONField(name: "sys_id")
  String? sysId;
  @JSONField(name: "task_count")
  String? taskCount;

  TaskFieldEngineerResultFieldEngineers();

  factory TaskFieldEngineerResultFieldEngineers.fromJson(Map<String, dynamic> json) =>
      $TaskFieldEngineerResultFieldEngineersFromJson(json);

  Map<String, dynamic> toJson() => $TaskFieldEngineerResultFieldEngineersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
