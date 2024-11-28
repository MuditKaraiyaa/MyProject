import 'package:xbridge/generated/json/base/json_convert_content.dart';
import 'package:xbridge/task_details/data/models/case_detail_entity.dart';

CaseDetailEntity $CaseDetailEntityFromJson(Map<String, dynamic> json) {
  final CaseDetailEntity caseDetailEntity = CaseDetailEntity();
  final CaseDetailResult? result =
      jsonConvert.convert<CaseDetailResult>(json['result']);
  if (result != null) {
    caseDetailEntity.result = result;
  }
  return caseDetailEntity;
}

Map<String, dynamic> $CaseDetailEntityToJson(CaseDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result?.toJson();
  return data;
}

extension CaseDetailEntityExtension on CaseDetailEntity {
  CaseDetailEntity copyWith({
    CaseDetailResult? result,
  }) {
    return CaseDetailEntity()..result = result ?? this.result;
  }
}

CaseDetailResult $CaseDetailResultFromJson(Map<String, dynamic> json) {
  final CaseDetailResult caseDetailResult = CaseDetailResult();
  final CaseDetailResultTask? task =
      jsonConvert.convert<CaseDetailResultTask>(json['task']);
  if (task != null) {
    caseDetailResult.task = task;
  }
  return caseDetailResult;
}

Map<String, dynamic> $CaseDetailResultToJson(CaseDetailResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['task'] = entity.task?.toJson();
  return data;
}

extension CaseDetailResultExtension on CaseDetailResult {
  CaseDetailResult copyWith({
    CaseDetailResultTask? task,
  }) {
    return CaseDetailResult()..task = task ?? this.task;
  }
}

CaseDetailResultTask $CaseDetailResultTaskFromJson(Map<String, dynamic> json) {
  final CaseDetailResultTask caseDetailResultTask = CaseDetailResultTask();
  final String? number = jsonConvert.convert<String>(json['number']);
  if (number != null) {
    caseDetailResultTask.number = number;
  }
  final String? vendor = jsonConvert.convert<String>(json['vendor']);
  if (vendor != null) {
    caseDetailResultTask.vendor = vendor;
  }
  final String? sysId = jsonConvert.convert<String>(json['sys_id']);
  if (sysId != null) {
    caseDetailResultTask.sysId = sysId;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    caseDetailResultTask.state = state;
  }
  final String? uPreferredScheduleByCustomer =
      jsonConvert.convert<String>(json['u_preferred_schedule_by_customer']);
  if (uPreferredScheduleByCustomer != null) {
    caseDetailResultTask.uPreferredScheduleByCustomer =
        uPreferredScheduleByCustomer;
  }
  final String? uEtaProvidedVendorToTig =
      jsonConvert.convert<String>(json['u_eta_provided_vendor_to_tig']);
  if (uEtaProvidedVendorToTig != null) {
    caseDetailResultTask.uEtaProvidedVendorToTig = uEtaProvidedVendorToTig;
  }
  final String? uWorkStarted =
      jsonConvert.convert<String>(json['u_work_started']);
  if (uWorkStarted != null) {
    caseDetailResultTask.uWorkStarted = uWorkStarted;
  }
  final String? uTotalTimeWorked =
      jsonConvert.convert<String>(json['u_total_time_worked']);
  if (uTotalTimeWorked != null) {
    caseDetailResultTask.uTotalTimeWorked = uTotalTimeWorked;
  }
  final String? uDepartureTime =
      jsonConvert.convert<String>(json['u_departure_time']);
  if (uDepartureTime != null) {
    caseDetailResultTask.uDepartureTime = uDepartureTime;
  }
  final String? fieldEngineer =
      jsonConvert.convert<String>(json['field_engineer']);
  if (uDepartureTime != null) {
    caseDetailResultTask.fieldEngineer = fieldEngineer;
  }

  final String? fieldengineerDevicetoken =
      jsonConvert.convert<String>(json['fieldengineer_devicetoken']);
  if (uDepartureTime != null) {
    caseDetailResultTask.fieldengineerDevicetoken = fieldengineerDevicetoken;
  }
  final String? fieldEngineerSysId =
      jsonConvert.convert<String>(json['field_engineer_sysid']);
  if (uDepartureTime != null) {
    caseDetailResultTask.fieldEngineerSysId = fieldEngineerSysId;
  }
  final String? uTravelStartTime =
      jsonConvert.convert<String>(json['u_travel_start_time']);
  if (uTravelStartTime != null) {
    caseDetailResultTask.uTravelStartTime = uTravelStartTime;
  }
  final String? uAssignedTo =
      jsonConvert.convert<String>(json['u_assigned_to']);
  if (uAssignedTo != null) {
    caseDetailResultTask.uAssignedTo = uAssignedTo;
  }
  final String? uArrivalTime =
      jsonConvert.convert<String>(json['u_arrival_time']);
  if (uArrivalTime != null) {
    caseDetailResultTask.uArrivalTime = uArrivalTime;
  }
  final String? uWorkCompleted =
      jsonConvert.convert<String>(json['u_work_completed']);
  if (uWorkCompleted != null) {
    caseDetailResultTask.uWorkCompleted = uWorkCompleted;
  }
  final String? uDispatchOtNumber =
      jsonConvert.convert<String>(json['u_dispatch_ot_number']);
  if (uDispatchOtNumber != null) {
    caseDetailResultTask.uDispatchOtNumber = uDispatchOtNumber;
  }
  final String? uPartCode = jsonConvert.convert<String>(json['u_part_code']);
  if (uPartCode != null) {
    caseDetailResultTask.uPartCode = uPartCode;
  }
  final dynamic uPartType = json['u_part_type'];
  if (uPartType != null) {
    caseDetailResultTask.uPartType = uPartType;
  }
  final String? uPartName = jsonConvert.convert<String>(json['u_part_name']);
  if (uPartName != null) {
    caseDetailResultTask.uPartName = uPartName;
  }
  final dynamic uPartStatus = json['u_part_status'];
  if (uPartStatus != null) {
    caseDetailResultTask.uPartStatus = uPartStatus;
  }
  final dynamic uReturnRequestType = json['u_return_request_type'];
  if (uReturnRequestType != null) {
    caseDetailResultTask.uReturnRequestType = uReturnRequestType;
  }
  final dynamic uResolutionCode = json['u_resolution_code'];
  if (uResolutionCode != null) {
    caseDetailResultTask.uResolutionCode = uResolutionCode;
  }
  final String? uResolutionComments =
      jsonConvert.convert<String>(json['u_resolution_comments']);
  if (uResolutionComments != null) {
    caseDetailResultTask.uResolutionComments = uResolutionComments;
  }
  final String? uCustomerSatisfaction =
      jsonConvert.convert<String>(json['u_customer_satisfaction']);
  if (uCustomerSatisfaction != null) {
    caseDetailResultTask.uCustomerSatisfaction = uCustomerSatisfaction;
  }
  final String? uFeLastLatitude =
      jsonConvert.convert<String>(json['u_fe_last_latitude']);
  if (uFeLastLatitude != null) {
    caseDetailResultTask.uFeLastLatitude = uFeLastLatitude;
  }
  final String? uFeLastLongitude =
      jsonConvert.convert<String>(json['u_fe_last_longitude']);
  if (uFeLastLongitude != null) {
    caseDetailResultTask.uFeLastLongitude = uFeLastLongitude;
  }
  final CaseDetailResultTaskCaseRecord? caseRecord =
      jsonConvert.convert<CaseDetailResultTaskCaseRecord>(json['caseRecord']);
  if (caseRecord != null) {
    caseDetailResultTask.caseRecord = caseRecord;
  }
  return caseDetailResultTask;
}

Map<String, dynamic> $CaseDetailResultTaskToJson(CaseDetailResultTask entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['number'] = entity.number;
  data['vendor'] = entity.vendor;
  data['sys_id'] = entity.sysId;
  data['state'] = entity.state;
  data['u_preferred_schedule_by_customer'] =
      entity.uPreferredScheduleByCustomer;
  data['u_eta_provided_vendor_to_tig'] = entity.uEtaProvidedVendorToTig;
  data['u_work_started'] = entity.uWorkStarted;
  data['u_total_time_worked'] = entity.uTotalTimeWorked;
  data['u_departure_time'] = entity.uDepartureTime;

  data['field_engineer'] = entity.fieldEngineer;
  data['fieldengineer_devicetoken'] = entity.fieldengineerDevicetoken;
  data['field_engineer_sysid'] = entity.fieldEngineerSysId;

  data['u_assigned_to'] = entity.uAssignedTo;
  data['u_arrival_time'] = entity.uArrivalTime;
  data['u_work_completed'] = entity.uWorkCompleted;
  data['u_dispatch_ot_number'] = entity.uDispatchOtNumber;
  data['u_part_code'] = entity.uPartCode;
  data['u_part_type'] = entity.uPartType;
  data['u_part_name'] = entity.uPartName;
  data['u_part_status'] = entity.uPartStatus;
  data['u_return_request_type'] = entity.uReturnRequestType;
  data['u_resolution_code'] = entity.uResolutionCode;
  data['u_resolution_comments'] = entity.uResolutionComments;
  data['u_customer_satisfaction'] = entity.uCustomerSatisfaction;
  data['u_fe_last_latitude'] = entity.uFeLastLatitude;
  data['u_fe_last_longitude'] = entity.uFeLastLongitude;
  data['caseRecord'] = entity.caseRecord?.toJson();
  return data;
}

extension CaseDetailResultTaskExtension on CaseDetailResultTask {
  CaseDetailResultTask copyWith({
    String? number,
    String? vendor,
    String? sysId,
    String? state,
    String? uPreferredScheduleByCustomer,
    String? uEtaProvidedVendorToTig,
    String? uWorkStarted,
    String? uTotalTimeWorked,
    String? uDepartureTime,
    String? uAssignedTo,
    String? uArrivalTime,
    String? uWorkCompleted,
    String? uDispatchOtNumber,
    String? uPartCode,
    dynamic uPartType,
    String? uPartName,
    dynamic uPartStatus,
    dynamic uReturnRequestType,
    dynamic uResolutionCode,
    String? uResolutionComments,
    String? uCustomerSatisfaction,
    String? uFeLastLatitude,
    String? uFeLastLongitude,
    CaseDetailResultTaskCaseRecord? caseRecord,
  }) {
    return CaseDetailResultTask()
      ..number = number ?? this.number
      ..vendor = vendor ?? this.vendor
      ..sysId = sysId ?? this.sysId
      ..state = state ?? this.state
      ..uPreferredScheduleByCustomer =
          uPreferredScheduleByCustomer ?? this.uPreferredScheduleByCustomer
      ..uEtaProvidedVendorToTig =
          uEtaProvidedVendorToTig ?? this.uEtaProvidedVendorToTig
      ..uWorkStarted = uWorkStarted ?? this.uWorkStarted
      ..uTotalTimeWorked = uTotalTimeWorked ?? this.uTotalTimeWorked
      ..uDepartureTime = uDepartureTime ?? this.uDepartureTime
      ..uAssignedTo = uAssignedTo ?? this.uAssignedTo
      ..uArrivalTime = uArrivalTime ?? this.uArrivalTime
      ..uWorkCompleted = uWorkCompleted ?? this.uWorkCompleted
      ..uDispatchOtNumber = uDispatchOtNumber ?? this.uDispatchOtNumber
      ..uPartCode = uPartCode ?? this.uPartCode
      ..uPartType = uPartType ?? this.uPartType
      ..uPartName = uPartName ?? this.uPartName
      ..uPartStatus = uPartStatus ?? this.uPartStatus
      ..uReturnRequestType = uReturnRequestType ?? this.uReturnRequestType
      ..uResolutionCode = uResolutionCode ?? this.uResolutionCode
      ..uResolutionComments = uResolutionComments ?? this.uResolutionComments
      ..uCustomerSatisfaction =
          uCustomerSatisfaction ?? this.uCustomerSatisfaction
      ..uFeLastLatitude = uFeLastLatitude ?? this.uFeLastLatitude
      ..uFeLastLongitude = uFeLastLongitude ?? this.uFeLastLongitude
      ..caseRecord = caseRecord ?? this.caseRecord;
  }
}

CaseDetailResultTaskCaseRecord $CaseDetailResultTaskCaseRecordFromJson(
    Map<String, dynamic> json) {
  final CaseDetailResultTaskCaseRecord caseDetailResultTaskCaseRecord =
      CaseDetailResultTaskCaseRecord();
  final String? number = jsonConvert.convert<String>(json['number']);
  if (number != null) {
    caseDetailResultTaskCaseRecord.number = number;
  }
  final String? contact = jsonConvert.convert<String>(json['contact']);
  if (contact != null) {
    caseDetailResultTaskCaseRecord.contact = contact;
  }
  final String? contractId = jsonConvert.convert<String>(json['contract_id']);
  if (contractId != null) {
    caseDetailResultTaskCaseRecord.contractId = contractId;
  }
  final String? openedBy = jsonConvert.convert<String>(json['opened_by']);
  if (openedBy != null) {
    caseDetailResultTaskCaseRecord.openedBy = openedBy;
  }
  final dynamic contactType = json['Contact_type'];
  if (contactType != null) {
    caseDetailResultTaskCaseRecord.contactType = contactType;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    caseDetailResultTaskCaseRecord.state = state;
  }
  final String? account = jsonConvert.convert<String>(json['account']);
  if (account != null) {
    caseDetailResultTaskCaseRecord.account = account;
  }
  final String? uEndUserEmailId =
      jsonConvert.convert<String>(json['u_end_user_email_id']);
  if (uEndUserEmailId != null) {
    caseDetailResultTaskCaseRecord.uEndUserEmailId = uEndUserEmailId;
  }
  final String? uEndUserContactNumber =
      jsonConvert.convert<String>(json['u_end_user_contact_number']);
  if (uEndUserContactNumber != null) {
    caseDetailResultTaskCaseRecord.uEndUserContactNumber =
        uEndUserContactNumber;
  }
  final String? uEndUserName =
      jsonConvert.convert<String>(json['u_end_user_name']);
  if (uEndUserName != null) {
    caseDetailResultTaskCaseRecord.uEndUserName = uEndUserName;
  }
  final String? uServiceType =
      jsonConvert.convert<String>(json['u_service_type']);
  if (uServiceType != null) {
    caseDetailResultTaskCaseRecord.uServiceType = uServiceType;
  }
  final String? uServiceSubtype =
      jsonConvert.convert<String>(json['u_service_subtype']);
  if (uServiceSubtype != null) {
    caseDetailResultTaskCaseRecord.uServiceSubtype = uServiceSubtype;
  }
  final String? priority = jsonConvert.convert<String>(json['priority']);
  if (priority != null) {
    caseDetailResultTaskCaseRecord.priority = priority;
  }
  final String? uInScope = jsonConvert.convert<String>(json['u_in_scope']);
  if (uInScope != null) {
    caseDetailResultTaskCaseRecord.uInScope = uInScope;
  }
  final String? shortDescription =
      jsonConvert.convert<String>(json['short_description']);
  if (shortDescription != null) {
    caseDetailResultTaskCaseRecord.shortDescription = shortDescription;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    caseDetailResultTaskCaseRecord.description = description;
  }
  final String? correlationId =
      jsonConvert.convert<String>(json['correlation_id']);
  if (correlationId != null) {
    caseDetailResultTaskCaseRecord.correlationId = correlationId;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    caseDetailResultTaskCaseRecord.category = category;
  }
  final String? subcategory = jsonConvert.convert<String>(json['subcategory']);
  if (subcategory != null) {
    caseDetailResultTaskCaseRecord.subcategory = subcategory;
  }
  final String? uDeviceName =
      jsonConvert.convert<String>(json['u_device_name']);
  if (uDeviceName != null) {
    caseDetailResultTaskCaseRecord.uDeviceName = uDeviceName;
  }
  final String? uDevicename = jsonConvert.convert<String>(json['u_devicename']);
  if (uDevicename != null) {
    caseDetailResultTaskCaseRecord.uDevicename = uDevicename;
  }
  final String? uDeviceType =
      jsonConvert.convert<String>(json['u_device_type']);
  if (uDeviceType != null) {
    caseDetailResultTaskCaseRecord.uDeviceType = uDeviceType;
  }
  final String? uSerialNumber =
      jsonConvert.convert<String>(json['u_serial_number']);
  if (uSerialNumber != null) {
    caseDetailResultTaskCaseRecord.uSerialNumber = uSerialNumber;
  }
  final String? uDeviceMake =
      jsonConvert.convert<String>(json['u_device_make']);
  if (uDeviceMake != null) {
    caseDetailResultTaskCaseRecord.uDeviceMake = uDeviceMake;
  }
  final String? uDeviceModel =
      jsonConvert.convert<String>(json['u_device_model']);
  if (uDeviceModel != null) {
    caseDetailResultTaskCaseRecord.uDeviceModel = uDeviceModel;
  }
  final dynamic uDeviceStatus = json['u_device_status'];
  if (uDeviceStatus != null) {
    caseDetailResultTaskCaseRecord.uDeviceStatus = uDeviceStatus;
  }
  final String? uRackNumber =
      jsonConvert.convert<String>(json['u_rack_number']);
  if (uRackNumber != null) {
    caseDetailResultTaskCaseRecord.uRackNumber = uRackNumber;
  }
  final String? uCaseType = jsonConvert.convert<String>(json['u_case_type']);
  if (uCaseType != null) {
    caseDetailResultTaskCaseRecord.uCaseType = uCaseType;
  }
  final String? uSpoc1Name = jsonConvert.convert<String>(json['u_spoc_1_name']);
  if (uSpoc1Name != null) {
    caseDetailResultTaskCaseRecord.uSpoc1Name = uSpoc1Name;
  }
  final String? uSpoc1ContactNumber =
      jsonConvert.convert<String>(json['u_spoc_1_contact_number']);
  if (uSpoc1ContactNumber != null) {
    caseDetailResultTaskCaseRecord.uSpoc1ContactNumber = uSpoc1ContactNumber;
  }
  final String? uSpoc1EmailId =
      jsonConvert.convert<String>(json['u_spoc_1_email_id']);
  if (uSpoc1EmailId != null) {
    caseDetailResultTaskCaseRecord.uSpoc1EmailId = uSpoc1EmailId;
  }
  final String? uSpoc2Name = jsonConvert.convert<String>(json['u_spoc_2_name']);
  if (uSpoc2Name != null) {
    caseDetailResultTaskCaseRecord.uSpoc2Name = uSpoc2Name;
  }
  final String? uSpoc2ContactNumber =
      jsonConvert.convert<String>(json['u_spoc_2_contact_number']);
  if (uSpoc2ContactNumber != null) {
    caseDetailResultTaskCaseRecord.uSpoc2ContactNumber = uSpoc2ContactNumber;
  }
  final String? uSpoc2EmailId =
      jsonConvert.convert<String>(json['u_spoc_2_email_id']);
  if (uSpoc2EmailId != null) {
    caseDetailResultTaskCaseRecord.uSpoc2EmailId = uSpoc2EmailId;
  }
  final CaseDetailResultTaskCaseRecordLocation? location = jsonConvert
      .convert<CaseDetailResultTaskCaseRecordLocation>(json['location']);
  if (location != null) {
    caseDetailResultTaskCaseRecord.location = location;
  }

  if (json['vendor_managers'] != null) {
    caseDetailResultTaskCaseRecord.vendorManagers = <VendorManagers>[];

    (json['vendor_managers'] as List<dynamic>).forEach((v) {
      caseDetailResultTaskCaseRecord.vendorManagers!
          .add(VendorManagers.fromJson(v));
    });
  }

  // final List<VendorManagers>? vendorManagers =
  //     (json['vendor_managers'] as List<dynamic>?)
  //         ?.map((e) => jsonConvert.convert<VendorManagers>(e) as VendorManagers)
  //         .toList();

  // if (vendorManagers != null) {
  //   caseDetailResultTaskCaseRecord.vendorManagers = vendorManagers;
  // }

  return caseDetailResultTaskCaseRecord;
}

Map<String, dynamic> $CaseDetailResultTaskCaseRecordToJson(
    CaseDetailResultTaskCaseRecord entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['number'] = entity.number;
  data['contact'] = entity.contact;
  data['contract_id'] = entity.contractId;
  data['opened_by'] = entity.openedBy;
  data['Contact_type'] = entity.contactType;
  data['state'] = entity.state;
  data['account'] = entity.account;
  data['u_end_user_email_id'] = entity.uEndUserEmailId;
  data['u_end_user_contact_number'] = entity.uEndUserContactNumber;
  data['u_end_user_name'] = entity.uEndUserName;
  data['u_service_type'] = entity.uServiceType;
  data['u_service_subtype'] = entity.uServiceSubtype;
  data['priority'] = entity.priority;
  data['u_in_scope'] = entity.uInScope;
  data['short_description'] = entity.shortDescription;
  data['description'] = entity.description;
  data['correlation_id'] = entity.correlationId;
  data['category'] = entity.category;
  data['subcategory'] = entity.subcategory;
  data['u_device_name'] = entity.uDeviceName;
  data['u_devicename'] = entity.uDevicename;
  data['u_device_type'] = entity.uDeviceType;
  data['u_serial_number'] = entity.uSerialNumber;
  data['u_device_make'] = entity.uDeviceMake;
  data['u_device_model'] = entity.uDeviceModel;
  data['u_device_status'] = entity.uDeviceStatus;
  data['u_rack_number'] = entity.uRackNumber;
  data['u_case_type'] = entity.uCaseType;
  data['u_spoc_1_name'] = entity.uSpoc1Name;
  data['u_spoc_1_contact_number'] = entity.uSpoc1ContactNumber;
  data['u_spoc_1_email_id'] = entity.uSpoc1EmailId;
  data['u_spoc_2_name'] = entity.uSpoc2Name;
  data['u_spoc_2_contact_number'] = entity.uSpoc2ContactNumber;
  data['u_spoc_2_email_id'] = entity.uSpoc2EmailId;
  data['location'] = entity.location?.toJson();

  data['vendor_managers'] = entity.vendorManagers != null
      ? entity.vendorManagers!.map((v) => v?.toJson()).toList()
      : null;

  // data['vendor_managers'] = entity.vendorManagers?.toList();
  return data;
}

extension CaseDetailResultTaskCaseRecordExtension
    on CaseDetailResultTaskCaseRecord {
  CaseDetailResultTaskCaseRecord copyWith({
    String? number,
    String? contact,
    String? contractId,
    String? openedBy,
    dynamic contactType,
    String? state,
    String? account,
    String? uEndUserEmailId,
    String? uEndUserContactNumber,
    String? uEndUserName,
    String? uServiceType,
    String? uServiceSubtype,
    String? priority,
    String? uInScope,
    String? shortDescription,
    String? description,
    String? correlationId,
    String? category,
    String? subcategory,
    String? uDeviceName,
    String? uDevicename,
    String? uDeviceType,
    String? uSerialNumber,
    String? uDeviceMake,
    String? uDeviceModel,
    dynamic uDeviceStatus,
    String? uRackNumber,
    String? uCaseType,
    String? uSpoc1Name,
    String? uSpoc1ContactNumber,
    String? uSpoc1EmailId,
    String? uSpoc2Name,
    String? uSpoc2ContactNumber,
    String? uSpoc2EmailId,
    CaseDetailResultTaskCaseRecordLocation? location,
    List<VendorManagers>? vendorManagers,
  }) {
    return CaseDetailResultTaskCaseRecord()
      ..number = number ?? this.number
      ..contact = contact ?? this.contact
      ..contractId = contractId ?? this.contractId
      ..openedBy = openedBy ?? this.openedBy
      ..contactType = contactType ?? this.contactType
      ..state = state ?? this.state
      ..account = account ?? this.account
      ..uEndUserEmailId = uEndUserEmailId ?? this.uEndUserEmailId
      ..uEndUserContactNumber =
          uEndUserContactNumber ?? this.uEndUserContactNumber
      ..uEndUserName = uEndUserName ?? this.uEndUserName
      ..uServiceType = uServiceType ?? this.uServiceType
      ..uServiceSubtype = uServiceSubtype ?? this.uServiceSubtype
      ..priority = priority ?? this.priority
      ..uInScope = uInScope ?? this.uInScope
      ..shortDescription = shortDescription ?? this.shortDescription
      ..description = description ?? this.description
      ..correlationId = correlationId ?? this.correlationId
      ..category = category ?? this.category
      ..subcategory = subcategory ?? this.subcategory
      ..uDeviceName = uDeviceName ?? this.uDeviceName
      ..uDevicename = uDevicename ?? this.uDevicename
      ..uDeviceType = uDeviceType ?? this.uDeviceType
      ..uSerialNumber = uSerialNumber ?? this.uSerialNumber
      ..uDeviceMake = uDeviceMake ?? this.uDeviceMake
      ..uDeviceModel = uDeviceModel ?? this.uDeviceModel
      ..uDeviceStatus = uDeviceStatus ?? this.uDeviceStatus
      ..uRackNumber = uRackNumber ?? this.uRackNumber
      ..uCaseType = uCaseType ?? this.uCaseType
      ..uSpoc1Name = uSpoc1Name ?? this.uSpoc1Name
      ..uSpoc1ContactNumber = uSpoc1ContactNumber ?? this.uSpoc1ContactNumber
      ..uSpoc1EmailId = uSpoc1EmailId ?? this.uSpoc1EmailId
      ..uSpoc2Name = uSpoc2Name ?? this.uSpoc2Name
      ..uSpoc2ContactNumber = uSpoc2ContactNumber ?? this.uSpoc2ContactNumber
      ..uSpoc2EmailId = uSpoc2EmailId ?? this.uSpoc2EmailId
      ..location = location ?? this.location
      ..vendorManagers = vendorManagers ?? this.vendorManagers;
  }
}

CaseDetailResultTaskCaseRecordLocation
    $CaseDetailResultTaskCaseRecordLocationFromJson(Map<String, dynamic> json) {
  final CaseDetailResultTaskCaseRecordLocation
      caseDetailResultTaskCaseRecordLocation =
      CaseDetailResultTaskCaseRecordLocation();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    caseDetailResultTaskCaseRecordLocation.name = name;
  }
  final String? street = jsonConvert.convert<String>(json['street']);
  if (street != null) {
    caseDetailResultTaskCaseRecordLocation.street = street;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    caseDetailResultTaskCaseRecordLocation.city = city;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    caseDetailResultTaskCaseRecordLocation.state = state;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    caseDetailResultTaskCaseRecordLocation.country = country;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    caseDetailResultTaskCaseRecordLocation.latitude = latitude;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    caseDetailResultTaskCaseRecordLocation.longitude = longitude;
  }
  return caseDetailResultTaskCaseRecordLocation;
}

Map<String, dynamic> $CaseDetailResultTaskCaseRecordLocationToJson(
    CaseDetailResultTaskCaseRecordLocation entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['street'] = entity.street;
  data['city'] = entity.city;
  data['state'] = entity.state;
  data['country'] = entity.country;
  data['latitude'] = entity.latitude;
  data['longitude'] = entity.longitude;
  return data;
}

extension CaseDetailResultTaskCaseRecordLocationExtension
    on CaseDetailResultTaskCaseRecordLocation {
  CaseDetailResultTaskCaseRecordLocation copyWith({
    String? name,
    String? street,
    String? city,
    String? state,
    String? country,
    String? latitude,
    String? longitude,
  }) {
    return CaseDetailResultTaskCaseRecordLocation()
      ..name = name ?? this.name
      ..street = street ?? this.street
      ..city = city ?? this.city
      ..state = state ?? this.state
      ..country = country ?? this.country
      ..latitude = latitude ?? this.latitude
      ..longitude = longitude ?? this.longitude;
  }
}
