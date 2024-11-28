import 'package:xbridge/generated/json/base/json_convert_content.dart';
import 'package:xbridge/diagnostic/data/model/diagnostic_entity.dart';

DiagnosticEntity $DiagnosticEntityFromJson(Map<String, dynamic> json) {
  final DiagnosticEntity diagnosticEntity = DiagnosticEntity();
  final DiagnosticResult? result = jsonConvert.convert<DiagnosticResult>(
      json['result']);
  if (result != null) {
    diagnosticEntity.result = result;
  }
  return diagnosticEntity;
}

Map<String, dynamic> $DiagnosticEntityToJson(DiagnosticEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result?.toJson();
  return data;
}

extension DiagnosticEntityExtension on DiagnosticEntity {
  DiagnosticEntity copyWith({
    DiagnosticResult? result,
  }) {
    return DiagnosticEntity()
      ..result = result ?? this.result;
  }
}

DiagnosticResult $DiagnosticResultFromJson(Map<String, dynamic> json) {
  final DiagnosticResult diagnosticResult = DiagnosticResult();
  final String? uSendToCargotec = jsonConvert.convert<String>(
      json['u_send_to_cargotec']);
  if (uSendToCargotec != null) {
    diagnosticResult.uSendToCargotec = uSendToCargotec;
  }
  final String? sizeBytes = jsonConvert.convert<String>(json['size_bytes']);
  if (sizeBytes != null) {
    diagnosticResult.sizeBytes = sizeBytes;
  }
  final String? fileName = jsonConvert.convert<String>(json['file_name']);
  if (fileName != null) {
    diagnosticResult.fileName = fileName;
  }
  final String? sysModCount = jsonConvert.convert<String>(
      json['sys_mod_count']);
  if (sysModCount != null) {
    diagnosticResult.sysModCount = sysModCount;
  }
  final String? averageImageColor = jsonConvert.convert<String>(
      json['average_image_color']);
  if (averageImageColor != null) {
    diagnosticResult.averageImageColor = averageImageColor;
  }
  final String? imageWidth = jsonConvert.convert<String>(json['image_width']);
  if (imageWidth != null) {
    diagnosticResult.imageWidth = imageWidth;
  }
  final String? sysUpdatedOn = jsonConvert.convert<String>(
      json['sys_updated_on']);
  if (sysUpdatedOn != null) {
    diagnosticResult.sysUpdatedOn = sysUpdatedOn;
  }
  final String? sysTags = jsonConvert.convert<String>(json['sys_tags']);
  if (sysTags != null) {
    diagnosticResult.sysTags = sysTags;
  }
  final String? tableName = jsonConvert.convert<String>(json['table_name']);
  if (tableName != null) {
    diagnosticResult.tableName = tableName;
  }
  final String? encryptionContext = jsonConvert.convert<String>(
      json['encryption_context']);
  if (encryptionContext != null) {
    diagnosticResult.encryptionContext = encryptionContext;
  }
  final String? sysId = jsonConvert.convert<String>(json['sys_id']);
  if (sysId != null) {
    diagnosticResult.sysId = sysId;
  }
  final String? uInternal = jsonConvert.convert<String>(json['u_internal']);
  if (uInternal != null) {
    diagnosticResult.uInternal = uInternal;
  }
  final String? imageHeight = jsonConvert.convert<String>(json['image_height']);
  if (imageHeight != null) {
    diagnosticResult.imageHeight = imageHeight;
  }
  final String? sysUpdatedBy = jsonConvert.convert<String>(
      json['sys_updated_by']);
  if (sysUpdatedBy != null) {
    diagnosticResult.sysUpdatedBy = sysUpdatedBy;
  }
  final String? downloadLink = jsonConvert.convert<String>(
      json['download_link']);
  if (downloadLink != null) {
    diagnosticResult.downloadLink = downloadLink;
  }
  final String? contentType = jsonConvert.convert<String>(json['content_type']);
  if (contentType != null) {
    diagnosticResult.contentType = contentType;
  }
  final String? sysCreatedOn = jsonConvert.convert<String>(
      json['sys_created_on']);
  if (sysCreatedOn != null) {
    diagnosticResult.sysCreatedOn = sysCreatedOn;
  }
  final String? sizeCompressed = jsonConvert.convert<String>(
      json['size_compressed']);
  if (sizeCompressed != null) {
    diagnosticResult.sizeCompressed = sizeCompressed;
  }
  final String? compressed = jsonConvert.convert<String>(json['compressed']);
  if (compressed != null) {
    diagnosticResult.compressed = compressed;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    diagnosticResult.state = state;
  }
  final String? tableSysId = jsonConvert.convert<String>(json['table_sys_id']);
  if (tableSysId != null) {
    diagnosticResult.tableSysId = tableSysId;
  }
  final String? chunkSizeBytes = jsonConvert.convert<String>(
      json['chunk_size_bytes']);
  if (chunkSizeBytes != null) {
    diagnosticResult.chunkSizeBytes = chunkSizeBytes;
  }
  final String? hash = jsonConvert.convert<String>(json['hash']);
  if (hash != null) {
    diagnosticResult.hash = hash;
  }
  final String? sysCreatedBy = jsonConvert.convert<String>(
      json['sys_created_by']);
  if (sysCreatedBy != null) {
    diagnosticResult.sysCreatedBy = sysCreatedBy;
  }
  return diagnosticResult;
}

Map<String, dynamic> $DiagnosticResultToJson(DiagnosticResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['u_send_to_cargotec'] = entity.uSendToCargotec;
  data['size_bytes'] = entity.sizeBytes;
  data['file_name'] = entity.fileName;
  data['sys_mod_count'] = entity.sysModCount;
  data['average_image_color'] = entity.averageImageColor;
  data['image_width'] = entity.imageWidth;
  data['sys_updated_on'] = entity.sysUpdatedOn;
  data['sys_tags'] = entity.sysTags;
  data['table_name'] = entity.tableName;
  data['encryption_context'] = entity.encryptionContext;
  data['sys_id'] = entity.sysId;
  data['u_internal'] = entity.uInternal;
  data['image_height'] = entity.imageHeight;
  data['sys_updated_by'] = entity.sysUpdatedBy;
  data['download_link'] = entity.downloadLink;
  data['content_type'] = entity.contentType;
  data['sys_created_on'] = entity.sysCreatedOn;
  data['size_compressed'] = entity.sizeCompressed;
  data['compressed'] = entity.compressed;
  data['state'] = entity.state;
  data['table_sys_id'] = entity.tableSysId;
  data['chunk_size_bytes'] = entity.chunkSizeBytes;
  data['hash'] = entity.hash;
  data['sys_created_by'] = entity.sysCreatedBy;
  return data;
}

extension DiagnosticResultExtension on DiagnosticResult {
  DiagnosticResult copyWith({
    String? uSendToCargotec,
    String? sizeBytes,
    String? fileName,
    String? sysModCount,
    String? averageImageColor,
    String? imageWidth,
    String? sysUpdatedOn,
    String? sysTags,
    String? tableName,
    String? encryptionContext,
    String? sysId,
    String? uInternal,
    String? imageHeight,
    String? sysUpdatedBy,
    String? downloadLink,
    String? contentType,
    String? sysCreatedOn,
    String? sizeCompressed,
    String? compressed,
    String? state,
    String? tableSysId,
    String? chunkSizeBytes,
    String? hash,
    String? sysCreatedBy,
  }) {
    return DiagnosticResult()
      ..uSendToCargotec = uSendToCargotec ?? this.uSendToCargotec
      ..sizeBytes = sizeBytes ?? this.sizeBytes
      ..fileName = fileName ?? this.fileName
      ..sysModCount = sysModCount ?? this.sysModCount
      ..averageImageColor = averageImageColor ?? this.averageImageColor
      ..imageWidth = imageWidth ?? this.imageWidth
      ..sysUpdatedOn = sysUpdatedOn ?? this.sysUpdatedOn
      ..sysTags = sysTags ?? this.sysTags
      ..tableName = tableName ?? this.tableName
      ..encryptionContext = encryptionContext ?? this.encryptionContext
      ..sysId = sysId ?? this.sysId
      ..uInternal = uInternal ?? this.uInternal
      ..imageHeight = imageHeight ?? this.imageHeight
      ..sysUpdatedBy = sysUpdatedBy ?? this.sysUpdatedBy
      ..downloadLink = downloadLink ?? this.downloadLink
      ..contentType = contentType ?? this.contentType
      ..sysCreatedOn = sysCreatedOn ?? this.sysCreatedOn
      ..sizeCompressed = sizeCompressed ?? this.sizeCompressed
      ..compressed = compressed ?? this.compressed
      ..state = state ?? this.state
      ..tableSysId = tableSysId ?? this.tableSysId
      ..chunkSizeBytes = chunkSizeBytes ?? this.chunkSizeBytes
      ..hash = hash ?? this.hash
      ..sysCreatedBy = sysCreatedBy ?? this.sysCreatedBy;
  }
}