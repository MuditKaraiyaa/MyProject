import 'package:xbridge/generated/json/base/json_field.dart';
import 'package:xbridge/generated/json/csr_response_entity.g.dart';
import 'dart:convert';
export 'package:xbridge/generated/json/csr_response_entity.g.dart';

@JsonSerializable()
class CsrResponseEntity {
	CsrResponseResult? result;

	CsrResponseEntity();

	factory CsrResponseEntity.fromJson(Map<String, dynamic> json) => $CsrResponseEntityFromJson(json);

	Map<String, dynamic> toJson() => $CsrResponseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CsrResponseResult {
	String? agent;
	String? signature;
	@JSONField(name: "response_to")
	String? responseTo;
	@JSONField(name: "sys_mod_count")
	String? sysModCount;
	@JSONField(name: "from_sys_id")
	String? fromSysId;
	String? source;
	@JSONField(name: "sys_updated_on")
	String? sysUpdatedOn;
	@JSONField(name: "agent_correlator")
	String? agentCorrelator;
	String? priority;
	@JSONField(name: "sys_domain_path")
	String? sysDomainPath;
	@JSONField(name: "error_string")
	String? errorString;
	String? processed;
	String? sequence;
	@JSONField(name: "sys_id")
	String? sysId;
	@JSONField(name: "sys_updated_by")
	String? sysUpdatedBy;
	@JSONField(name: "from_host")
	String? fromHost;
	String? payload;
	@JSONField(name: "sys_created_on")
	String? sysCreatedOn;
	@JSONField(name: "sys_domain")
	CsrResponseResultSysDomain? sysDomain;
	String? name;
	String? topic;
	String? state;
	String? queue;
	@JSONField(name: "sys_created_by")
	String? sysCreatedBy;

	CsrResponseResult();

	factory CsrResponseResult.fromJson(Map<String, dynamic> json) => $CsrResponseResultFromJson(json);

	Map<String, dynamic> toJson() => $CsrResponseResultToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CsrResponseResultSysDomain {
	String? link;
	String? value;

	CsrResponseResultSysDomain();

	factory CsrResponseResultSysDomain.fromJson(Map<String, dynamic> json) => $CsrResponseResultSysDomainFromJson(json);

	Map<String, dynamic> toJson() => $CsrResponseResultSysDomainToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}