import 'package:xbridge/generated/json/base/json_convert_content.dart';
import 'package:xbridge/video_call/data/models/dyte_add_participant_entity.dart';

DyteAddParticipantEntity $DyteAddParticipantEntityFromJson(
    Map<String, dynamic> json) {
  final DyteAddParticipantEntity dyteAddParticipantEntity = DyteAddParticipantEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    dyteAddParticipantEntity.success = success;
  }
  final DyteAddParticipantData? data = jsonConvert.convert<
      DyteAddParticipantData>(json['data']);
  if (data != null) {
    dyteAddParticipantEntity.data = data;
  }
  return dyteAddParticipantEntity;
}

Map<String, dynamic> $DyteAddParticipantEntityToJson(
    DyteAddParticipantEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['data'] = entity.data?.toJson();
  return data;
}

extension DyteAddParticipantEntityExtension on DyteAddParticipantEntity {
  DyteAddParticipantEntity copyWith({
    bool? success,
    DyteAddParticipantData? data,
  }) {
    return DyteAddParticipantEntity()
      ..success = success ?? this.success
      ..data = data ?? this.data;
  }
}

DyteAddParticipantData $DyteAddParticipantDataFromJson(
    Map<String, dynamic> json) {
  final DyteAddParticipantData dyteAddParticipantData = DyteAddParticipantData();
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    dyteAddParticipantData.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    dyteAddParticipantData.updatedAt = updatedAt;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    dyteAddParticipantData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    dyteAddParticipantData.name = name;
  }
  final String? picture = jsonConvert.convert<String>(json['picture']);
  if (picture != null) {
    dyteAddParticipantData.picture = picture;
  }
  final String? customParticipantId = jsonConvert.convert<String>(
      json['custom_participant_id']);
  if (customParticipantId != null) {
    dyteAddParticipantData.customParticipantId = customParticipantId;
  }
  final String? presetId = jsonConvert.convert<String>(json['preset_id']);
  if (presetId != null) {
    dyteAddParticipantData.presetId = presetId;
  }
  final bool? isDeleted = jsonConvert.convert<bool>(json['is_deleted']);
  if (isDeleted != null) {
    dyteAddParticipantData.isDeleted = isDeleted;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    dyteAddParticipantData.token = token;
  }
  return dyteAddParticipantData;
}

Map<String, dynamic> $DyteAddParticipantDataToJson(
    DyteAddParticipantData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['picture'] = entity.picture;
  data['custom_participant_id'] = entity.customParticipantId;
  data['preset_id'] = entity.presetId;
  data['is_deleted'] = entity.isDeleted;
  data['token'] = entity.token;
  return data;
}

extension DyteAddParticipantDataExtension on DyteAddParticipantData {
  DyteAddParticipantData copyWith({
    String? createdAt,
    String? updatedAt,
    String? id,
    String? name,
    String? picture,
    String? customParticipantId,
    String? presetId,
    bool? isDeleted,
    String? token,
  }) {
    return DyteAddParticipantData()
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..picture = picture ?? this.picture
      ..customParticipantId = customParticipantId ?? this.customParticipantId
      ..presetId = presetId ?? this.presetId
      ..isDeleted = isDeleted ?? this.isDeleted
      ..token = token ?? this.token;
  }
}