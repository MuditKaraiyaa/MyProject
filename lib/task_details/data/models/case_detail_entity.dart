import 'dart:convert';

import 'package:xbridge/generated/json/base/json_field.dart';
import 'package:xbridge/generated/json/case_detail_entity.g.dart';

export 'package:xbridge/generated/json/case_detail_entity.g.dart';

// JSON Serializable classes for Case Detail Entity
@JsonSerializable()
class CaseDetailEntity {
  CaseDetailResult? result;

  CaseDetailEntity();

  factory CaseDetailEntity.fromJson(Map<String, dynamic> json) =>
      $CaseDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $CaseDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CaseDetailResult {
  // Properties related to case details
  CaseDetailResultTask? task;

  CaseDetailResult();

  factory CaseDetailResult.fromJson(Map<String, dynamic> json) =>
      $CaseDetailResultFromJson(json);

  Map<String, dynamic> toJson() => $CaseDetailResultToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CaseDetailResultTask {
  // Properties related to case details
  String? number;
  String? vendor;
  @JSONField(name: "sys_id")
  String? sysId;
  String? state;
  @JSONField(name: "u_preferred_schedule_by_customer")
  String? uPreferredScheduleByCustomer;
  @JSONField(name: "u_eta_provided_vendor_to_tig")
  String? uEtaProvidedVendorToTig;
  @JSONField(name: "u_work_started")
  String? uWorkStarted;
  @JSONField(name: "u_total_time_worked")
  String? uTotalTimeWorked;
  @JSONField(name: "u_departure_time")
  String? uDepartureTime;

  @JSONField(name: "field_engineer")
  String? fieldEngineer;
  @JSONField(name: "fieldengineer_devicetoken")
  String? fieldengineerDevicetoken;
  @JSONField(name: "field_engineer_sysid")
  String? fieldEngineerSysId;

  @JSONField(name: "u_travel_start_time")
  String? uTravelStartTime;

  @JSONField(name: "u_assigned_to")
  String? uAssignedTo;
  @JSONField(name: "u_arrival_time")
  String? uArrivalTime;
  @JSONField(name: "u_work_completed")
  String? uWorkCompleted;
  @JSONField(name: "u_dispatch_ot_number")
  String? uDispatchOtNumber;
  @JSONField(name: "u_part_code")
  String? uPartCode;
  @JSONField(name: "u_part_type")
  dynamic uPartType;
  @JSONField(name: "u_part_name")
  String? uPartName;
  @JSONField(name: "u_part_status")
  dynamic uPartStatus;
  @JSONField(name: "u_return_request_type")
  dynamic uReturnRequestType;
  @JSONField(name: "u_resolution_code")
  dynamic uResolutionCode;
  @JSONField(name: "u_resolution_comments")
  String? uResolutionComments;
  @JSONField(name: "u_customer_satisfaction")
  String? uCustomerSatisfaction;
  @JSONField(name: "u_fe_last_latitude")
  String? uFeLastLatitude;
  @JSONField(name: "u_fe_last_longitude")
  String? uFeLastLongitude;
  CaseDetailResultTaskCaseRecord? caseRecord;

  CaseDetailResultTask();

  factory CaseDetailResultTask.fromJson(Map<String, dynamic> json) =>
      $CaseDetailResultTaskFromJson(json);

  Map<String, dynamic> toJson() => $CaseDetailResultTaskToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CaseDetailResultTaskCaseRecord {
  // Properties related to case record
  String? number;
  String? contact;
  @JSONField(name: "contract_id")
  String? contractId;
  @JSONField(name: "opened_by")
  String? openedBy;
  @JSONField(name: "contact_type")
  dynamic contactType;
  @JSONField(name: "sd_agent")
  dynamic sdAgent;
  @JSONField(name: "sdagent_devicetoken")
  dynamic sdAgentDeviceToken;

  String? state;
  String? account;
  @JSONField(name: "u_end_user_email_id")
  String? uEndUserEmailId;
  @JSONField(name: "u_end_user_contact_number")
  String? uEndUserContactNumber;
  @JSONField(name: "u_end_user_name")
  String? uEndUserName;
  @JSONField(name: "u_service_type")
  String? uServiceType;
  @JSONField(name: "u_service_subtype")
  String? uServiceSubtype;
  String? priority;
  @JSONField(name: "u_in_scope")
  String? uInScope;
  @JSONField(name: "short_description")
  String? shortDescription;
  String? description;
  @JSONField(name: "correlation_id")
  String? correlationId;
  String? category;
  String? subcategory;
  @JSONField(name: "u_device_name")
  String? uDeviceName;
  @JSONField(name: "u_devicename")
  String? uDevicename;
  @JSONField(name: "u_device_type")
  String? uDeviceType;
  @JSONField(name: "u_serial_number")
  String? uSerialNumber;
  @JSONField(name: "u_device_make")
  String? uDeviceMake;
  @JSONField(name: "u_device_model")
  String? uDeviceModel;
  @JSONField(name: "u_device_status")
  dynamic uDeviceStatus;
  @JSONField(name: "u_rack_number")
  String? uRackNumber;
  @JSONField(name: "u_case_type")
  String? uCaseType;
  @JSONField(name: "u_spoc_1_name")
  String? uSpoc1Name;
  @JSONField(name: "u_spoc_1_contact_number")
  String? uSpoc1ContactNumber;
  @JSONField(name: "u_spoc_1_email_id")
  String? uSpoc1EmailId;
  @JSONField(name: "u_spoc_2_name")
  String? uSpoc2Name;
  @JSONField(name: "u_spoc_2_contact_number")
  String? uSpoc2ContactNumber;
  @JSONField(name: "u_spoc_2_email_id")
  String? uSpoc2EmailId;
  CaseDetailResultTaskCaseRecordLocation? location;
  @JSONField(name: "vendor_managers")
  List<VendorManagers>? vendorManagers;

  CaseDetailResultTaskCaseRecord();

  factory CaseDetailResultTaskCaseRecord.fromJson(Map<String, dynamic> json) =>
      $CaseDetailResultTaskCaseRecordFromJson(json);

  Map<String, dynamic> toJson() => $CaseDetailResultTaskCaseRecordToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CaseDetailResultTaskCaseRecordLocation {
  // Properties related to case record location
  String? name;
  String? street;
  String? city;
  String? state;
  String? country;
  String? latitude;
  String? longitude;

  CaseDetailResultTaskCaseRecordLocation();

  factory CaseDetailResultTaskCaseRecordLocation.fromJson(
          Map<String, dynamic> json) =>
      $CaseDetailResultTaskCaseRecordLocationFromJson(json);

  Map<String, dynamic> toJson() =>
      $CaseDetailResultTaskCaseRecordLocationToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

// Extension to provide address information from location
extension XAddress on CaseDetailResultTaskCaseRecordLocation {
  String? get address =>
      '${street ?? ''} ${city ?? ''} ${state ?? ''} ${country ?? ''}';
}

// Model class for Vendor Managers
class VendorManagers {
  String? username;
  String? sysid;
  String? name;
  String? utypeofuser;
  String? uXblDeviceToken;

  VendorManagers(
      {this.username,
      this.sysid,
      this.name,
      this.utypeofuser,
      this.uXblDeviceToken});

  VendorManagers.fromJson(Map<String, dynamic> json) {
    username = json['user_name'];
    sysid = json['sys_id'];
    name = json['name'];
    utypeofuser = json['u_type_of_user'];
    uXblDeviceToken = json['u_xbl_device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = username;
    data['sys_id'] = sysid;
    data['name'] = name;
    data['u_type_of_user'] = utypeofuser;
    data['u_xbl_device_token'] = uXblDeviceToken;

    return data;
  }
}
