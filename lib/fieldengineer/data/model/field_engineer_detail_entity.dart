import 'dart:convert';

import 'package:xbridge/generated/json/base/json_field.dart';
import 'package:xbridge/generated/json/field_engineer_detail_entity.g.dart';

export 'package:xbridge/generated/json/field_engineer_detail_entity.g.dart';

@JsonSerializable()
class FieldEngineerDetailEntity {
  List<FieldEngineerDetailResult>? result;
  @JSONField(name: "sys_id")
  String? sysId;
  FieldEngineerDetailEntity();

  factory FieldEngineerDetailEntity.fromJson(Map<String, dynamic> json) =>
      $FieldEngineerDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $FieldEngineerDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FieldEngineerDetailResult {
  @JSONField(name: "calendar_integration")
  String? calendarIntegration;
  String? country;
  @JSONField(name: "last_position_update")
  String? lastPositionUpdate;
  @JSONField(name: "user_password")
  String? userPassword;
  @JSONField(name: "last_login_time")
  String? lastLoginTime;
  String? source;
  @JSONField(name: "sys_updated_on")
  String? sysUpdatedOn;
  @JSONField(name: "u_national_id_number")
  String? uNationalIdNumber;
  String? building;
  @JSONField(name: "u_national_id_type")
  String? uNationalIdType;
  @JSONField(name: "web_service_access_only")
  String? webServiceAccessOnly;
  String? notification;
  @JSONField(name: "u_assigned_cases")
  String? uAssignedCases;
  @JSONField(name: "enable_multifactor_authn")
  String? enableMultifactorAuthn;
  @JSONField(name: "sys_updated_by")
  String? sysUpdatedBy;
  @JSONField(name: "sso_source")
  String? ssoSource;
  @JSONField(name: "sys_created_on")
  String? sysCreatedOn;
  @JSONField(name: "agent_status")
  String? agentStatus;
  @JSONField(name: "sys_domain")
  FieldEngineerDetailResultSysDomain? sysDomain;
  @JSONField(name: "u_password_last_reset")
  String? uPasswordLastReset;
  String? state;
  String? vip;
  @JSONField(name: "sys_created_by")
  String? sysCreatedBy;
  String? longitude;
  @JSONField(name: "u_type_of_user")
  String? uTypeOfUser;
  String? zip;
  @JSONField(name: "home_phone")
  String? homePhone;
  @JSONField(name: "u_country")
  String? uCountry;
  @JSONField(name: "time_format")
  String? timeFormat;
  @JSONField(name: "last_login")
  String? lastLogin;
  @JSONField(name: "default_perspective")
  String? defaultPerspective;
  @JSONField(name: "geolocation_tracked")
  String? geolocationTracked;
  String? active;
  @JSONField(name: "time_sheet_policy")
  String? timeSheetPolicy;
  @JSONField(name: "sys_domain_path")
  String? sysDomainPath;
  @JSONField(name: "cost_center")
  String? costCenter;
  String? phone;
  String? name;
  @JSONField(name: "employee_number")
  String? employeeNumber;
  @JSONField(name: "u_assigned_case_tasks")
  String? uAssignedCaseTasks;
  @JSONField(name: "password_needs_reset")
  String? passwordNeedsReset;
  String? gender;
  String? city;
  @JSONField(name: "failed_attempts")
  String? failedAttempts;
  @JSONField(name: "user_name")
  String? userName;
  String? latitude;
  String? roles;
  String? title;
  @JSONField(name: "sys_class_name")
  String? sysClassName;
  @JSONField(name: "sys_id")
  String? sysId;
  @JSONField(name: "internal_integration_user")
  String? internalIntegrationUser;
  @JSONField(name: "ldap_server")
  String? ldapServer;
  @JSONField(name: "mobile_phone")
  String? mobilePhone;
  String? street;
  String? company;
  String? department;
  @JSONField(name: "first_name")
  String? firstName;
  String? email;
  String? introduction;
  @JSONField(name: "preferred_language")
  String? preferredLanguage;
  String? manager;
  @JSONField(name: "locked_out")
  String? lockedOut;
  @JSONField(name: "sys_mod_count")
  String? sysModCount;
  @JSONField(name: "last_name")
  String? lastName;
  String? photo;
  String? avatar;
  @JSONField(name: "middle_name")
  String? middleName;
  @JSONField(name: "sys_tags")
  String? sysTags;
  @JSONField(name: "time_zone")
  String? timeZone;
  String? schedule;
  @JSONField(name: "on_schedule")
  String? onSchedule;
  @JSONField(name: "u_xbl_device_token")
  String? uXblDeviceToken;
  @JSONField(name: "date_format")
  String? dateFormat;
  String? location;

  FieldEngineerDetailResult();

  factory FieldEngineerDetailResult.fromJson(Map<String, dynamic> json) =>
      $FieldEngineerDetailResultFromJson(json);

  Map<String, dynamic> toJson() => $FieldEngineerDetailResultToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class FieldEngineerDetailResultSysDomain {
  String? link;
  String? value;

  FieldEngineerDetailResultSysDomain();

  factory FieldEngineerDetailResultSysDomain.fromJson(
    Map<String, dynamic> json,
  ) =>
      $FieldEngineerDetailResultSysDomainFromJson(json);

  Map<String, dynamic> toJson() =>
      $FieldEngineerDetailResultSysDomainToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
