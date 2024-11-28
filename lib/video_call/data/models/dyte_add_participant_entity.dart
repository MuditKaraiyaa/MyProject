import 'package:xbridge/generated/json/base/json_field.dart';
import 'package:xbridge/generated/json/dyte_add_participant_entity.g.dart';
import 'dart:convert';
export 'package:xbridge/generated/json/dyte_add_participant_entity.g.dart';

@JsonSerializable()
class DyteAddParticipantEntity {
	bool? success;
	DyteAddParticipantData? data;

	DyteAddParticipantEntity();

	factory DyteAddParticipantEntity.fromJson(Map<String, dynamic> json) => $DyteAddParticipantEntityFromJson(json);

	Map<String, dynamic> toJson() => $DyteAddParticipantEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DyteAddParticipantData {
	@JSONField(name: "created_at")
	String? createdAt;
	@JSONField(name: "updated_at")
	String? updatedAt;
	String? id;
	String? name;
	String? picture;
	@JSONField(name: "custom_participant_id")
	String? customParticipantId;
	@JSONField(name: "preset_id")
	String? presetId;
	@JSONField(name: "is_deleted")
	bool? isDeleted;
	String? token;

	DyteAddParticipantData();

	factory DyteAddParticipantData.fromJson(Map<String, dynamic> json) => $DyteAddParticipantDataFromJson(json);

	Map<String, dynamic> toJson() => $DyteAddParticipantDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}