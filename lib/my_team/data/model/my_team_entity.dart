/*
import 'package:xbridge/generated/json/base/json_field.dart';
import 'package:xbridge/generated/json/my_team_entity.g.dart';
import 'dart:convert';
export 'package:xbridge/generated/json/my_team_entity.g.dart';

@JsonSerializable()
class MyTeamEntity {
	List<MyTeamResult>? result = [];

	MyTeamEntity();

	factory MyTeamEntity.fromJson(Map<String, dynamic> json) => $MyTeamEntityFromJson(json);

	Map<String, dynamic> toJson() => $MyTeamEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class MyTeamResult {
	@JSONField(name: "user.sys_id")
	String? userSysId = '';
	@JSONField(name: "user.name")
	String? userName = '';
	@JSONField(name: "user.u_type_of_user")
	String? userUTypeOfUser = '';
	@JSONField(name: "user.user_name")
	String? userUserName = '';

	MyTeamResult();

	factory MyTeamResult.fromJson(Map<String, dynamic> json) => $MyTeamResultFromJson(json);

	Map<String, dynamic> toJson() => $MyTeamResultToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
*/
class MyTeamEntity {
	List<Result>? result;

	MyTeamEntity({this.result});

	MyTeamEntity.fromJson(Map<String, dynamic> json) {
		if (json['result'] != null) {
			result = <Result>[];
			json['result'].forEach((v) {
				result!.add(new Result.fromJson(v));
			});
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.result != null) {
			data['result'] = this.result!.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class Result {
	String? sysId;
	String? sysUpdatedBy;
	String? sysCreatedOn;
	String? sysModCount;
	String? uActive;
	String? sysUpdatedOn;
	String? sysTags;
	User? user;
	String? sysCreatedBy;
	User? group;

	Result(
			{this.sysId,
				this.sysUpdatedBy,
				this.sysCreatedOn,
				this.sysModCount,
				this.uActive,
				this.sysUpdatedOn,
				this.sysTags,
				this.user,
				this.sysCreatedBy,
				this.group});

	Result.fromJson(Map<String, dynamic> json) {
		sysId = json['sys_id'];
		sysUpdatedBy = json['sys_updated_by'];
		sysCreatedOn = json['sys_created_on'];
		sysModCount = json['sys_mod_count'];
		uActive = json['u_active'];
		sysUpdatedOn = json['sys_updated_on'];
		sysTags = json['sys_tags'];
		user = json['user'] != null ? new User.fromJson(json['user']) : null;
		sysCreatedBy = json['sys_created_by'];
		group = json['group'] != null ? new User.fromJson(json['group']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sys_id'] = this.sysId;
		data['sys_updated_by'] = this.sysUpdatedBy;
		data['sys_created_on'] = this.sysCreatedOn;
		data['sys_mod_count'] = this.sysModCount;
		data['u_active'] = this.uActive;
		data['sys_updated_on'] = this.sysUpdatedOn;
		data['sys_tags'] = this.sysTags;
		if (this.user != null) {
			data['user'] = this.user!.toJson();
		}
		data['sys_created_by'] = this.sysCreatedBy;
		if (this.group != null) {
			data['group'] = this.group!.toJson();
		}
		return data;
	}
}

class User {
	String? displayValue;
	String? link;

	User({this.displayValue, this.link});

	User.fromJson(Map<String, dynamic> json) {
		displayValue = json['display_value'];
		link = json['link'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['display_value'] = this.displayValue;
		data['link'] = this.link;
		return data;
	}
}
