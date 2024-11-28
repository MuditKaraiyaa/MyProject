import 'package:xbridge/generated/json/base/json_field.dart';
import 'package:xbridge/generated/json/diagnostic_entity.g.dart';
import 'dart:convert';
export 'package:xbridge/generated/json/diagnostic_entity.g.dart';

@JsonSerializable()
class DiagnosticEntity {
	DiagnosticResult? result;

	DiagnosticEntity();

	factory DiagnosticEntity.fromJson(Map<String, dynamic> json) => $DiagnosticEntityFromJson(json);

	Map<String, dynamic> toJson() => $DiagnosticEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DiagnosticResult {
	@JSONField(name: "u_send_to_cargotec")
	String? uSendToCargotec = '';
	@JSONField(name: "size_bytes")
	String? sizeBytes = '';
	@JSONField(name: "file_name")
	String? fileName = '';
	@JSONField(name: "sys_mod_count")
	String? sysModCount = '';
	@JSONField(name: "average_image_color")
	String? averageImageColor = '';
	@JSONField(name: "image_width")
	String? imageWidth = '';
	@JSONField(name: "sys_updated_on")
	String? sysUpdatedOn = '';
	@JSONField(name: "sys_tags")
	String? sysTags = '';
	@JSONField(name: "table_name")
	String? tableName = '';
	@JSONField(name: "encryption_context")
	String? encryptionContext = '';
	@JSONField(name: "sys_id")
	String? sysId = '';
	@JSONField(name: "u_internal")
	String? uInternal = '';
	@JSONField(name: "image_height")
	String? imageHeight = '';
	@JSONField(name: "sys_updated_by")
	String? sysUpdatedBy = '';
	@JSONField(name: "download_link")
	String? downloadLink = '';
	@JSONField(name: "content_type")
	String? contentType = '';
	@JSONField(name: "sys_created_on")
	String? sysCreatedOn = '';
	@JSONField(name: "size_compressed")
	String? sizeCompressed = '';
	String? compressed = '';
	String? state = '';
	@JSONField(name: "table_sys_id")
	String? tableSysId = '';
	@JSONField(name: "chunk_size_bytes")
	String? chunkSizeBytes = '';
	String? hash = '';
	@JSONField(name: "sys_created_by")
	String? sysCreatedBy = '';

	DiagnosticResult();

	factory DiagnosticResult.fromJson(Map<String, dynamic> json) => $DiagnosticResultFromJson(json);

	Map<String, dynamic> toJson() => $DiagnosticResultToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}