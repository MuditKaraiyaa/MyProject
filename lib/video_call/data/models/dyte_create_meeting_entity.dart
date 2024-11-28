import 'package:xbridge/generated/json/base/json_field.dart';
import 'package:xbridge/generated/json/dyte_create_meeting_entity.g.dart';
import 'dart:convert';
export 'package:xbridge/generated/json/dyte_create_meeting_entity.g.dart';

@JsonSerializable()
class DyteCreateMeetingEntity {
	bool? success;
	DyteCreateMeetingData? data;

	DyteCreateMeetingEntity();

	factory DyteCreateMeetingEntity.fromJson(Map<String, dynamic> json) => $DyteCreateMeetingEntityFromJson(json);

	Map<String, dynamic> toJson() => $DyteCreateMeetingEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DyteCreateMeetingData {
	@JSONField(name: "preferred_region")
	String? preferredRegion;
	String? id;
	String? title;
	@JSONField(name: "record_on_start")
	bool? recordOnStart;
	@JSONField(name: "live_stream_on_start")
	bool? liveStreamOnStart;
	String? status;
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;

	DyteCreateMeetingData();

	factory DyteCreateMeetingData.fromJson(Map<String, dynamic> json) => $DyteCreateMeetingDataFromJson(json);

	Map<String, dynamic> toJson() => $DyteCreateMeetingDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}