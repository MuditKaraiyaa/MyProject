import 'package:xbridge/generated/json/base/json_convert_content.dart';
import 'package:xbridge/service_call_report/data/model/csr_response_entity.dart';

CsrResponseEntity $CsrResponseEntityFromJson(Map<String, dynamic> json) {
  final CsrResponseEntity csrResponseEntity = CsrResponseEntity();
  final CsrResponseResult? result = jsonConvert.convert<CsrResponseResult>(
      json['result']);
  if (result != null) {
    csrResponseEntity.result = result;
  }
  return csrResponseEntity;
}

Map<String, dynamic> $CsrResponseEntityToJson(CsrResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result?.toJson();
  return data;
}

extension CsrResponseEntityExtension on CsrResponseEntity {
  CsrResponseEntity copyWith({
    CsrResponseResult? result,
  }) {
    return CsrResponseEntity()
      ..result = result ?? this.result;
  }
}

CsrResponseResult $CsrResponseResultFromJson(Map<String, dynamic> json) {
  final CsrResponseResult csrResponseResult = CsrResponseResult();
  final String? agent = jsonConvert.convert<String>(json['agent']);
  if (agent != null) {
    csrResponseResult.agent = agent;
  }
  final String? signature = jsonConvert.convert<String>(json['signature']);
  if (signature != null) {
    csrResponseResult.signature = signature;
  }
  final String? responseTo = jsonConvert.convert<String>(json['response_to']);
  if (responseTo != null) {
    csrResponseResult.responseTo = responseTo;
  }
  final String? sysModCount = jsonConvert.convert<String>(
      json['sys_mod_count']);
  if (sysModCount != null) {
    csrResponseResult.sysModCount = sysModCount;
  }
  final String? fromSysId = jsonConvert.convert<String>(json['from_sys_id']);
  if (fromSysId != null) {
    csrResponseResult.fromSysId = fromSysId;
  }
  final String? source = jsonConvert.convert<String>(json['source']);
  if (source != null) {
    csrResponseResult.source = source;
  }
  final String? sysUpdatedOn = jsonConvert.convert<String>(
      json['sys_updated_on']);
  if (sysUpdatedOn != null) {
    csrResponseResult.sysUpdatedOn = sysUpdatedOn;
  }
  final String? agentCorrelator = jsonConvert.convert<String>(
      json['agent_correlator']);
  if (agentCorrelator != null) {
    csrResponseResult.agentCorrelator = agentCorrelator;
  }
  final String? priority = jsonConvert.convert<String>(json['priority']);
  if (priority != null) {
    csrResponseResult.priority = priority;
  }
  final String? sysDomainPath = jsonConvert.convert<String>(
      json['sys_domain_path']);
  if (sysDomainPath != null) {
    csrResponseResult.sysDomainPath = sysDomainPath;
  }
  final String? errorString = jsonConvert.convert<String>(json['error_string']);
  if (errorString != null) {
    csrResponseResult.errorString = errorString;
  }
  final String? processed = jsonConvert.convert<String>(json['processed']);
  if (processed != null) {
    csrResponseResult.processed = processed;
  }
  final String? sequence = jsonConvert.convert<String>(json['sequence']);
  if (sequence != null) {
    csrResponseResult.sequence = sequence;
  }
  final String? sysId = jsonConvert.convert<String>(json['sys_id']);
  if (sysId != null) {
    csrResponseResult.sysId = sysId;
  }
  final String? sysUpdatedBy = jsonConvert.convert<String>(
      json['sys_updated_by']);
  if (sysUpdatedBy != null) {
    csrResponseResult.sysUpdatedBy = sysUpdatedBy;
  }
  final String? fromHost = jsonConvert.convert<String>(json['from_host']);
  if (fromHost != null) {
    csrResponseResult.fromHost = fromHost;
  }
  final String? payload = jsonConvert.convert<String>(json['payload']);
  if (payload != null) {
    csrResponseResult.payload = payload;
  }
  final String? sysCreatedOn = jsonConvert.convert<String>(
      json['sys_created_on']);
  if (sysCreatedOn != null) {
    csrResponseResult.sysCreatedOn = sysCreatedOn;
  }
  final CsrResponseResultSysDomain? sysDomain = jsonConvert.convert<
      CsrResponseResultSysDomain>(json['sys_domain']);
  if (sysDomain != null) {
    csrResponseResult.sysDomain = sysDomain;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    csrResponseResult.name = name;
  }
  final String? topic = jsonConvert.convert<String>(json['topic']);
  if (topic != null) {
    csrResponseResult.topic = topic;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    csrResponseResult.state = state;
  }
  final String? queue = jsonConvert.convert<String>(json['queue']);
  if (queue != null) {
    csrResponseResult.queue = queue;
  }
  final String? sysCreatedBy = jsonConvert.convert<String>(
      json['sys_created_by']);
  if (sysCreatedBy != null) {
    csrResponseResult.sysCreatedBy = sysCreatedBy;
  }
  return csrResponseResult;
}

Map<String, dynamic> $CsrResponseResultToJson(CsrResponseResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['agent'] = entity.agent;
  data['signature'] = entity.signature;
  data['response_to'] = entity.responseTo;
  data['sys_mod_count'] = entity.sysModCount;
  data['from_sys_id'] = entity.fromSysId;
  data['source'] = entity.source;
  data['sys_updated_on'] = entity.sysUpdatedOn;
  data['agent_correlator'] = entity.agentCorrelator;
  data['priority'] = entity.priority;
  data['sys_domain_path'] = entity.sysDomainPath;
  data['error_string'] = entity.errorString;
  data['processed'] = entity.processed;
  data['sequence'] = entity.sequence;
  data['sys_id'] = entity.sysId;
  data['sys_updated_by'] = entity.sysUpdatedBy;
  data['from_host'] = entity.fromHost;
  data['payload'] = entity.payload;
  data['sys_created_on'] = entity.sysCreatedOn;
  data['sys_domain'] = entity.sysDomain?.toJson();
  data['name'] = entity.name;
  data['topic'] = entity.topic;
  data['state'] = entity.state;
  data['queue'] = entity.queue;
  data['sys_created_by'] = entity.sysCreatedBy;
  return data;
}

extension CsrResponseResultExtension on CsrResponseResult {
  CsrResponseResult copyWith({
    String? agent,
    String? signature,
    String? responseTo,
    String? sysModCount,
    String? fromSysId,
    String? source,
    String? sysUpdatedOn,
    String? agentCorrelator,
    String? priority,
    String? sysDomainPath,
    String? errorString,
    String? processed,
    String? sequence,
    String? sysId,
    String? sysUpdatedBy,
    String? fromHost,
    String? payload,
    String? sysCreatedOn,
    CsrResponseResultSysDomain? sysDomain,
    String? name,
    String? topic,
    String? state,
    String? queue,
    String? sysCreatedBy,
  }) {
    return CsrResponseResult()
      ..agent = agent ?? this.agent
      ..signature = signature ?? this.signature
      ..responseTo = responseTo ?? this.responseTo
      ..sysModCount = sysModCount ?? this.sysModCount
      ..fromSysId = fromSysId ?? this.fromSysId
      ..source = source ?? this.source
      ..sysUpdatedOn = sysUpdatedOn ?? this.sysUpdatedOn
      ..agentCorrelator = agentCorrelator ?? this.agentCorrelator
      ..priority = priority ?? this.priority
      ..sysDomainPath = sysDomainPath ?? this.sysDomainPath
      ..errorString = errorString ?? this.errorString
      ..processed = processed ?? this.processed
      ..sequence = sequence ?? this.sequence
      ..sysId = sysId ?? this.sysId
      ..sysUpdatedBy = sysUpdatedBy ?? this.sysUpdatedBy
      ..fromHost = fromHost ?? this.fromHost
      ..payload = payload ?? this.payload
      ..sysCreatedOn = sysCreatedOn ?? this.sysCreatedOn
      ..sysDomain = sysDomain ?? this.sysDomain
      ..name = name ?? this.name
      ..topic = topic ?? this.topic
      ..state = state ?? this.state
      ..queue = queue ?? this.queue
      ..sysCreatedBy = sysCreatedBy ?? this.sysCreatedBy;
  }
}

CsrResponseResultSysDomain $CsrResponseResultSysDomainFromJson(
    Map<String, dynamic> json) {
  final CsrResponseResultSysDomain csrResponseResultSysDomain = CsrResponseResultSysDomain();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    csrResponseResultSysDomain.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    csrResponseResultSysDomain.value = value;
  }
  return csrResponseResultSysDomain;
}

Map<String, dynamic> $CsrResponseResultSysDomainToJson(
    CsrResponseResultSysDomain entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension CsrResponseResultSysDomainExtension on CsrResponseResultSysDomain {
  CsrResponseResultSysDomain copyWith({
    String? link,
    String? value,
  }) {
    return CsrResponseResultSysDomain()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}