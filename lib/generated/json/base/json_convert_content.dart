// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:xbridge/diagnostic/data/model/diagnostic_entity.dart';
import 'package:xbridge/fieldengineer/data/model/field_engineer_detail_entity.dart';
import 'package:xbridge/my_team/data/model/my_team_entity.dart';
import 'package:xbridge/service_call_report/data/model/csr_response_entity.dart';
import 'package:xbridge/task_details/data/models/case_detail_entity.dart';
import 'package:xbridge/task_details/data/models/task_detail_entity.dart';
import 'package:xbridge/task_details/data/models/task_field_engineer_entity.dart';
import 'package:xbridge/unassigned_visits/data/model/unassigned_task_entity.dart';
import 'package:xbridge/video_call/data/models/dyte_add_participant_entity.dart';
import 'package:xbridge/video_call/data/models/dyte_create_meeting_entity.dart';

JsonConvert jsonConvert = JsonConvert();

typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);
typedef EnumConvertFunction<T> = T Function(String value);
typedef ConvertExceptionHandler = void Function(Object error, StackTrace stackTrace);

class JsonConvert {
  static ConvertExceptionHandler? onError;
  JsonConvertClassCollection convertFuncMap = JsonConvertClassCollection();

  /// When you are in the development, to generate a new model class, hot-reload doesn't find new generation model class, you can build on MaterialApp method called jsonConvert. ReassembleConvertFuncMap (); This method only works in a development environment
  /// https://flutter.cn/docs/development/tools/hot-reload
  /// class MyApp extends StatelessWidget {
  ///    const MyApp({Key? key})
  ///        : super(key: key);
  ///
  ///    @override
  ///    Widget build(BuildContext context) {
  ///      jsonConvert.reassembleConvertFuncMap();
  ///      return MaterialApp();
  ///    }
  /// }
  void reassembleConvertFuncMap() {
    bool isReleaseMode = const bool.fromEnvironment('dart.vm.product');
    if (!isReleaseMode) {
      convertFuncMap = JsonConvertClassCollection();
    }
  }

  T? convert<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    if (value is T) {
      return value;
    }
    try {
      if (value.runtimeType != String) {
        return _asT<T>(value, enumConvert: enumConvert);
      }
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return null;
    }
    return null;
  }

  List<T?>? convertList<T>(
    List<dynamic>? value, {
    EnumConvertFunction? enumConvert,
  }) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => _asT<T>(e, enumConvert: enumConvert)).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(
    dynamic value, {
    EnumConvertFunction? enumConvert,
  }) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>)
          .map(
            (dynamic e) => _asT<T>(e, enumConvert: enumConvert)!,
          )
          .toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return <T>[];
    }
  }

  T? _asT<T extends Object?>(
    dynamic value, {
    EnumConvertFunction? enumConvert,
  }) {
    final String type = T.toString();
    final String valueS = value.toString();
    if (enumConvert != null) {
      return enumConvert(valueS) as T;
    } else if (type == "String") {
      return valueS as T;
    } else if (type == "int") {
      final int? intValue = int.tryParse(valueS);
      if (intValue == null) {
        return double.tryParse(valueS)?.toInt() as T?;
      } else {
        return intValue as T;
      }
    } else if (type == "double") {
      return double.parse(valueS) as T;
    } else if (type == "DateTime") {
      return DateTime.parse(valueS) as T;
    } else if (type == "bool") {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return (valueS == 'true') as T;
    } else if (type == "Map" || type.startsWith("Map<")) {
      return value as T;
    } else {
      if (convertFuncMap.containsKey(type)) {
        if (value == null) {
          return null;
        }
        return convertFuncMap[type]!(value as Map<String, dynamic>) as T;
      } else {
        throw UnimplementedError(
          '$type unimplemented,you can try running the app again',
        );
      }
    }
  }

  //list is returned by type
  static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
    if (<DiagnosticEntity>[] is M) {
      return data
          .map<DiagnosticEntity>(
            (Map<String, dynamic> e) => DiagnosticEntity.fromJson(e),
          )
          .toList() as M;
    }
    if (<DiagnosticResult>[] is M) {
      return data
          .map<DiagnosticResult>(
            (Map<String, dynamic> e) => DiagnosticResult.fromJson(e),
          )
          .toList() as M;
    }
    if (<FieldEngineerDetailEntity>[] is M) {
      return data
          .map<FieldEngineerDetailEntity>(
            (Map<String, dynamic> e) => FieldEngineerDetailEntity.fromJson(e),
          )
          .toList() as M;
    }
    if (<FieldEngineerDetailResult>[] is M) {
      return data
          .map<FieldEngineerDetailResult>(
            (Map<String, dynamic> e) => FieldEngineerDetailResult.fromJson(e),
          )
          .toList() as M;
    }
    if (<FieldEngineerDetailResultSysDomain>[] is M) {
      return data
          .map<FieldEngineerDetailResultSysDomain>(
            (
              Map<String, dynamic> e,
            ) =>
                FieldEngineerDetailResultSysDomain.fromJson(e),
          )
          .toList() as M;
    }
    if (<MyTeamEntity>[] is M) {
      return data
          .map<MyTeamEntity>(
            (Map<String, dynamic> e) => MyTeamEntity.fromJson(e),
          )
          .toList() as M;
    }
    // if (<MyTeamResult>[] is M) {
    //   return data
    //       .map<MyTeamResult>(
    //         (Map<String, dynamic> e) => MyTeamResult.fromJson(e),
    //       )
    //       .toList() as M;
    // }
    if (<CsrResponseEntity>[] is M) {
      return data
          .map<CsrResponseEntity>(
            (Map<String, dynamic> e) => CsrResponseEntity.fromJson(e),
          )
          .toList() as M;
    }
    if (<CsrResponseResult>[] is M) {
      return data
          .map<CsrResponseResult>(
            (Map<String, dynamic> e) => CsrResponseResult.fromJson(e),
          )
          .toList() as M;
    }
    if (<CsrResponseResultSysDomain>[] is M) {
      return data
          .map<CsrResponseResultSysDomain>(
            (Map<String, dynamic> e) => CsrResponseResultSysDomain.fromJson(e),
          )
          .toList() as M;
    }
    if (<CaseDetailEntity>[] is M) {
      return data
          .map<CaseDetailEntity>(
            (Map<String, dynamic> e) => CaseDetailEntity.fromJson(e),
          )
          .toList() as M;
    }
    if (<CaseDetailResult>[] is M) {
      return data
          .map<CaseDetailResult>(
            (Map<String, dynamic> e) => CaseDetailResult.fromJson(e),
          )
          .toList() as M;
    }
    if (<CaseDetailResultTask>[] is M) {
      return data
          .map<CaseDetailResultTask>(
            (Map<String, dynamic> e) => CaseDetailResultTask.fromJson(e),
          )
          .toList() as M;
    }
    if (<CaseDetailResultTaskCaseRecord>[] is M) {
      return data
          .map<CaseDetailResultTaskCaseRecord>(
            (
              Map<String, dynamic> e,
            ) =>
                CaseDetailResultTaskCaseRecord.fromJson(e),
          )
          .toList() as M;
    }
    if (<CaseDetailResultTaskCaseRecordLocation>[] is M) {
      return data
          .map<CaseDetailResultTaskCaseRecordLocation>(
            (
              Map<String, dynamic> e,
            ) =>
                CaseDetailResultTaskCaseRecordLocation.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailEntity>[] is M) {
      return data
          .map<TaskDetailEntity>(
            (Map<String, dynamic> e) => TaskDetailEntity.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResult>[] is M) {
      return data
          .map<TaskDetailResult>(
            (Map<String, dynamic> e) => TaskDetailResult.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultParent>[] is M) {
      return data
          .map<TaskDetailResultParent>(
            (Map<String, dynamic> e) => TaskDetailResultParent.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultUCaseAccount>[] is M) {
      return data
          .map<TaskDetailResultUCaseAccount>(
            (Map<String, dynamic> e) => TaskDetailResultUCaseAccount.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultClosedBy>[] is M) {
      return data
          .map<TaskDetailResultClosedBy>(
            (Map<String, dynamic> e) => TaskDetailResultClosedBy.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultAssignedTo>[] is M) {
      return data
          .map<TaskDetailResultAssignedTo>(
            (Map<String, dynamic> e) => TaskDetailResultAssignedTo.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultOpenedBy>[] is M) {
      return data
          .map<TaskDetailResultOpenedBy>(
            (Map<String, dynamic> e) => TaskDetailResultOpenedBy.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultContact>[] is M) {
      return data
          .map<TaskDetailResultContact>(
            (Map<String, dynamic> e) => TaskDetailResultContact.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultSysDomain>[] is M) {
      return data
          .map<TaskDetailResultSysDomain>(
            (Map<String, dynamic> e) => TaskDetailResultSysDomain.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultUParent>[] is M) {
      return data
          .map<TaskDetailResultUParent>(
            (Map<String, dynamic> e) => TaskDetailResultUParent.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultAssignmentGroup>[] is M) {
      return data
          .map<TaskDetailResultAssignmentGroup>(
            (
              Map<String, dynamic> e,
            ) =>
                TaskDetailResultAssignmentGroup.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultParentCase>[] is M) {
      return data
          .map<TaskDetailResultParentCase>(
            (Map<String, dynamic> e) => TaskDetailResultParentCase.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskDetailResultAccount>[] is M) {
      return data
          .map<TaskDetailResultAccount>(
            (Map<String, dynamic> e) => TaskDetailResultAccount.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskFieldEngineerEntity>[] is M) {
      return data
          .map<TaskFieldEngineerEntity>(
            (Map<String, dynamic> e) => TaskFieldEngineerEntity.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskFieldEngineerResult>[] is M) {
      return data
          .map<TaskFieldEngineerResult>(
            (Map<String, dynamic> e) => TaskFieldEngineerResult.fromJson(e),
          )
          .toList() as M;
    }
    if (<TaskFieldEngineerResultFieldEngineers>[] is M) {
      return data
          .map<TaskFieldEngineerResultFieldEngineers>(
            (
              Map<String, dynamic> e,
            ) =>
                TaskFieldEngineerResultFieldEngineers.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskEntity>[] is M) {
      return data
          .map<UnassignedTaskEntity>(
            (Map<String, dynamic> e) => UnassignedTaskEntity.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResult>[] is M) {
      return data
          .map<UnassignedTaskResult>(
            (Map<String, dynamic> e) => UnassignedTaskResult.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultParent>[] is M) {
      return data
          .map<UnassignedTaskResultParent>(
            (Map<String, dynamic> e) => UnassignedTaskResultParent.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultUCaseAccount>[] is M) {
      return data
          .map<UnassignedTaskResultUCaseAccount>(
            (
              Map<String, dynamic> e,
            ) =>
                UnassignedTaskResultUCaseAccount.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultClosedBy>[] is M) {
      return data
          .map<UnassignedTaskResultClosedBy>(
            (Map<String, dynamic> e) => UnassignedTaskResultClosedBy.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultAssignedTo>[] is M) {
      return data
          .map<UnassignedTaskResultAssignedTo>(
            (
              Map<String, dynamic> e,
            ) =>
                UnassignedTaskResultAssignedTo.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultOpenedBy>[] is M) {
      return data
          .map<UnassignedTaskResultOpenedBy>(
            (Map<String, dynamic> e) => UnassignedTaskResultOpenedBy.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultContact>[] is M) {
      return data
          .map<UnassignedTaskResultContact>(
            (Map<String, dynamic> e) => UnassignedTaskResultContact.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultSysDomain>[] is M) {
      return data
          .map<UnassignedTaskResultSysDomain>(
            (Map<String, dynamic> e) => UnassignedTaskResultSysDomain.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultUParent>[] is M) {
      return data
          .map<UnassignedTaskResultUParent>(
            (Map<String, dynamic> e) => UnassignedTaskResultUParent.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultAssignmentGroup>[] is M) {
      return data
          .map<UnassignedTaskResultAssignmentGroup>(
            (
              Map<String, dynamic> e,
            ) =>
                UnassignedTaskResultAssignmentGroup.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultParentCase>[] is M) {
      return data
          .map<UnassignedTaskResultParentCase>(
            (
              Map<String, dynamic> e,
            ) =>
                UnassignedTaskResultParentCase.fromJson(e),
          )
          .toList() as M;
    }
    if (<UnassignedTaskResultAccount>[] is M) {
      return data
          .map<UnassignedTaskResultAccount>(
            (Map<String, dynamic> e) => UnassignedTaskResultAccount.fromJson(e),
          )
          .toList() as M;
    }
    if (<DyteAddParticipantEntity>[] is M) {
      return data
          .map<DyteAddParticipantEntity>(
            (Map<String, dynamic> e) => DyteAddParticipantEntity.fromJson(e),
          )
          .toList() as M;
    }
    if (<DyteAddParticipantData>[] is M) {
      return data
          .map<DyteAddParticipantData>(
            (Map<String, dynamic> e) => DyteAddParticipantData.fromJson(e),
          )
          .toList() as M;
    }
    if (<DyteCreateMeetingEntity>[] is M) {
      return data
          .map<DyteCreateMeetingEntity>(
            (Map<String, dynamic> e) => DyteCreateMeetingEntity.fromJson(e),
          )
          .toList() as M;
    }
    if (<DyteCreateMeetingData>[] is M) {
      return data
          .map<DyteCreateMeetingData>(
            (Map<String, dynamic> e) => DyteCreateMeetingData.fromJson(e),
          )
          .toList() as M;
    }

    debugPrint("$M not found");

    return null;
  }

  static M? fromJsonAsT<M>(dynamic json) {
    if (json is M) {
      return json;
    }
    if (json is List) {
      return _getListChildType<M>(
        json.map((dynamic e) => e as Map<String, dynamic>).toList(),
      );
    } else {
      return jsonConvert.convert<M>(json);
    }
  }
}

class JsonConvertClassCollection {
  Map<String, JsonConvertFunction> convertFuncMap = {
    (DiagnosticEntity).toString(): DiagnosticEntity.fromJson,
    (DiagnosticResult).toString(): DiagnosticResult.fromJson,
    (FieldEngineerDetailEntity).toString(): FieldEngineerDetailEntity.fromJson,
    (FieldEngineerDetailResult).toString(): FieldEngineerDetailResult.fromJson,
    (FieldEngineerDetailResultSysDomain).toString(): FieldEngineerDetailResultSysDomain.fromJson,
    (MyTeamEntity).toString(): MyTeamEntity.fromJson,
    //(MyTeamResult).toString(): MyTeamResult.fromJson,
    (CsrResponseEntity).toString(): CsrResponseEntity.fromJson,
    (CsrResponseResult).toString(): CsrResponseResult.fromJson,
    (CsrResponseResultSysDomain).toString(): CsrResponseResultSysDomain.fromJson,
    (CaseDetailEntity).toString(): CaseDetailEntity.fromJson,
    (CaseDetailResult).toString(): CaseDetailResult.fromJson,
    (CaseDetailResultTask).toString(): CaseDetailResultTask.fromJson,
    (CaseDetailResultTaskCaseRecord).toString(): CaseDetailResultTaskCaseRecord.fromJson,
    (CaseDetailResultTaskCaseRecordLocation).toString():
        CaseDetailResultTaskCaseRecordLocation.fromJson,
    (TaskDetailEntity).toString(): TaskDetailEntity.fromJson,
    (TaskDetailResult).toString(): TaskDetailResult.fromJson,
    (TaskDetailResultParent).toString(): TaskDetailResultParent.fromJson,
    (TaskDetailResultUCaseAccount).toString(): TaskDetailResultUCaseAccount.fromJson,
    (TaskDetailResultClosedBy).toString(): TaskDetailResultClosedBy.fromJson,
    (TaskDetailResultAssignedTo).toString(): TaskDetailResultAssignedTo.fromJson,
    (TaskDetailResultOpenedBy).toString(): TaskDetailResultOpenedBy.fromJson,
    (TaskDetailResultContact).toString(): TaskDetailResultContact.fromJson,
    (TaskDetailResultSysDomain).toString(): TaskDetailResultSysDomain.fromJson,
    (TaskDetailResultUParent).toString(): TaskDetailResultUParent.fromJson,
    (TaskDetailResultAssignmentGroup).toString(): TaskDetailResultAssignmentGroup.fromJson,
    (TaskDetailResultParentCase).toString(): TaskDetailResultParentCase.fromJson,
    (TaskDetailResultAccount).toString(): TaskDetailResultAccount.fromJson,
    (TaskFieldEngineerEntity).toString(): TaskFieldEngineerEntity.fromJson,
    (TaskFieldEngineerResult).toString(): TaskFieldEngineerResult.fromJson,
    (TaskFieldEngineerResultFieldEngineers).toString():
        TaskFieldEngineerResultFieldEngineers.fromJson,
    (UnassignedTaskEntity).toString(): UnassignedTaskEntity.fromJson,
    (UnassignedTaskResult).toString(): UnassignedTaskResult.fromJson,
    (UnassignedTaskResultParent).toString(): UnassignedTaskResultParent.fromJson,
    (UnassignedTaskResultUCaseAccount).toString(): UnassignedTaskResultUCaseAccount.fromJson,
    (UnassignedTaskResultClosedBy).toString(): UnassignedTaskResultClosedBy.fromJson,
    (UnassignedTaskResultAssignedTo).toString(): UnassignedTaskResultAssignedTo.fromJson,
    (UnassignedTaskResultOpenedBy).toString(): UnassignedTaskResultOpenedBy.fromJson,
    (UnassignedTaskResultContact).toString(): UnassignedTaskResultContact.fromJson,
    (UnassignedTaskResultSysDomain).toString(): UnassignedTaskResultSysDomain.fromJson,
    (UnassignedTaskResultUParent).toString(): UnassignedTaskResultUParent.fromJson,
    (UnassignedTaskResultAssignmentGroup).toString(): UnassignedTaskResultAssignmentGroup.fromJson,
    (UnassignedTaskResultParentCase).toString(): UnassignedTaskResultParentCase.fromJson,
    (UnassignedTaskResultAccount).toString(): UnassignedTaskResultAccount.fromJson,
    (DyteAddParticipantEntity).toString(): DyteAddParticipantEntity.fromJson,
    (DyteAddParticipantData).toString(): DyteAddParticipantData.fromJson,
    (DyteCreateMeetingEntity).toString(): DyteCreateMeetingEntity.fromJson,
    (DyteCreateMeetingData).toString(): DyteCreateMeetingData.fromJson,
  };

  bool containsKey(String type) {
    return convertFuncMap.containsKey(type);
  }

  JsonConvertFunction? operator [](String key) {
    return convertFuncMap[key];
  }
}