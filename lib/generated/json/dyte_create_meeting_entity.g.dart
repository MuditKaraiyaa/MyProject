import 'package:xbridge/generated/json/base/json_convert_content.dart';
import 'package:xbridge/video_call/data/models/dyte_create_meeting_entity.dart';

DyteCreateMeetingEntity $DyteCreateMeetingEntityFromJson(
    Map<String, dynamic> json) {
  final DyteCreateMeetingEntity dyteCreateMeetingEntity = DyteCreateMeetingEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    dyteCreateMeetingEntity.success = success;
  }
  final DyteCreateMeetingData? data = jsonConvert.convert<
      DyteCreateMeetingData>(json['data']);
  if (data != null) {
    dyteCreateMeetingEntity.data = data;
  }
  return dyteCreateMeetingEntity;
}

Map<String, dynamic> $DyteCreateMeetingEntityToJson(
    DyteCreateMeetingEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['data'] = entity.data?.toJson();
  return data;
}

extension DyteCreateMeetingEntityExtension on DyteCreateMeetingEntity {
  DyteCreateMeetingEntity copyWith({
    bool? success,
    DyteCreateMeetingData? data,
  }) {
    return DyteCreateMeetingEntity()
      ..success = success ?? this.success
      ..data = data ?? this.data;
  }
}

DyteCreateMeetingData $DyteCreateMeetingDataFromJson(
    Map<String, dynamic> json) {
  final DyteCreateMeetingData dyteCreateMeetingData = DyteCreateMeetingData();
  final String? preferredRegion = jsonConvert.convert<String>(
      json['preferred_region']);
  if (preferredRegion != null) {
    dyteCreateMeetingData.preferredRegion = preferredRegion;
  }
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    dyteCreateMeetingData.id = id;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    dyteCreateMeetingData.title = title;
  }
  final bool? recordOnStart = jsonConvert.convert<bool>(
      json['record_on_start']);
  if (recordOnStart != null) {
    dyteCreateMeetingData.recordOnStart = recordOnStart;
  }
  final bool? liveStreamOnStart = jsonConvert.convert<bool>(
      json['live_stream_on_start']);
  if (liveStreamOnStart != null) {
    dyteCreateMeetingData.liveStreamOnStart = liveStreamOnStart;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    dyteCreateMeetingData.status = status;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    dyteCreateMeetingData.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    dyteCreateMeetingData.updatedAt = updatedAt;
  }
  return dyteCreateMeetingData;
}

Map<String, dynamic> $DyteCreateMeetingDataToJson(
    DyteCreateMeetingData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['preferred_region'] = entity.preferredRegion;
  data['id'] = entity.id;
  data['title'] = entity.title;
  data['record_on_start'] = entity.recordOnStart;
  data['live_stream_on_start'] = entity.liveStreamOnStart;
  data['status'] = entity.status;
  data['created_at'] = entity.createdAt;
  data['updated_at'] = entity.updatedAt;
  return data;
}

extension DyteCreateMeetingDataExtension on DyteCreateMeetingData {
  DyteCreateMeetingData copyWith({
    String? preferredRegion,
    String? id,
    String? title,
    bool? recordOnStart,
    bool? liveStreamOnStart,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return DyteCreateMeetingData()
      ..preferredRegion = preferredRegion ?? this.preferredRegion
      ..id = id ?? this.id
      ..title = title ?? this.title
      ..recordOnStart = recordOnStart ?? this.recordOnStart
      ..liveStreamOnStart = liveStreamOnStart ?? this.liveStreamOnStart
      ..status = status ?? this.status
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}