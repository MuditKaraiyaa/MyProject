import 'package:xbridge/generated/json/base/json_convert_content.dart';
import 'package:xbridge/fieldengineer/data/model/field_engineer_detail_entity.dart';

FieldEngineerDetailEntity $FieldEngineerDetailEntityFromJson(
    Map<String, dynamic> json) {
  final FieldEngineerDetailEntity fieldEngineerDetailEntity = FieldEngineerDetailEntity();
  final List<FieldEngineerDetailResult>? result = (json['result'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<FieldEngineerDetailResult>(
          e) as FieldEngineerDetailResult).toList();
  if (result != null) {
    fieldEngineerDetailEntity.result = result;
  }
  final String? sysId = jsonConvert.convert<String>(json['sys_id']);
  if (sysId != null) {
    fieldEngineerDetailEntity.sysId = sysId;
  }
  return fieldEngineerDetailEntity;
}

Map<String, dynamic> $FieldEngineerDetailEntityToJson(
    FieldEngineerDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result?.map((v) => v.toJson()).toList();
  data['sys_id'] = entity.sysId;
  return data;
}

extension FieldEngineerDetailEntityExtension on FieldEngineerDetailEntity {
  FieldEngineerDetailEntity copyWith({
    List<FieldEngineerDetailResult>? result,
    String? sysId,
  }) {
    return FieldEngineerDetailEntity()
      ..result = result ?? this.result
      ..sysId = sysId ?? this.sysId;
  }
}

FieldEngineerDetailResult $FieldEngineerDetailResultFromJson(
    Map<String, dynamic> json) {
  final FieldEngineerDetailResult fieldEngineerDetailResult = FieldEngineerDetailResult();
  final String? calendarIntegration = jsonConvert.convert<String>(
      json['calendar_integration']);
  if (calendarIntegration != null) {
    fieldEngineerDetailResult.calendarIntegration = calendarIntegration;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    fieldEngineerDetailResult.country = country;
  }
  final String? lastPositionUpdate = jsonConvert.convert<String>(
      json['last_position_update']);
  if (lastPositionUpdate != null) {
    fieldEngineerDetailResult.lastPositionUpdate = lastPositionUpdate;
  }
  final String? userPassword = jsonConvert.convert<String>(
      json['user_password']);
  if (userPassword != null) {
    fieldEngineerDetailResult.userPassword = userPassword;
  }
  final String? lastLoginTime = jsonConvert.convert<String>(
      json['last_login_time']);
  if (lastLoginTime != null) {
    fieldEngineerDetailResult.lastLoginTime = lastLoginTime;
  }
  final String? source = jsonConvert.convert<String>(json['source']);
  if (source != null) {
    fieldEngineerDetailResult.source = source;
  }
  final String? sysUpdatedOn = jsonConvert.convert<String>(
      json['sys_updated_on']);
  if (sysUpdatedOn != null) {
    fieldEngineerDetailResult.sysUpdatedOn = sysUpdatedOn;
  }
  final String? uNationalIdNumber = jsonConvert.convert<String>(
      json['u_national_id_number']);
  if (uNationalIdNumber != null) {
    fieldEngineerDetailResult.uNationalIdNumber = uNationalIdNumber;
  }
  final String? building = jsonConvert.convert<String>(json['building']);
  if (building != null) {
    fieldEngineerDetailResult.building = building;
  }
  final String? uNationalIdType = jsonConvert.convert<String>(
      json['u_national_id_type']);
  if (uNationalIdType != null) {
    fieldEngineerDetailResult.uNationalIdType = uNationalIdType;
  }
  final String? webServiceAccessOnly = jsonConvert.convert<String>(
      json['web_service_access_only']);
  if (webServiceAccessOnly != null) {
    fieldEngineerDetailResult.webServiceAccessOnly = webServiceAccessOnly;
  }
  final String? notification = jsonConvert.convert<String>(
      json['notification']);
  if (notification != null) {
    fieldEngineerDetailResult.notification = notification;
  }
  final String? uAssignedCases = jsonConvert.convert<String>(
      json['u_assigned_cases']);
  if (uAssignedCases != null) {
    fieldEngineerDetailResult.uAssignedCases = uAssignedCases;
  }
  final String? enableMultifactorAuthn = jsonConvert.convert<String>(
      json['enable_multifactor_authn']);
  if (enableMultifactorAuthn != null) {
    fieldEngineerDetailResult.enableMultifactorAuthn = enableMultifactorAuthn;
  }
  final String? sysUpdatedBy = jsonConvert.convert<String>(
      json['sys_updated_by']);
  if (sysUpdatedBy != null) {
    fieldEngineerDetailResult.sysUpdatedBy = sysUpdatedBy;
  }
  final String? ssoSource = jsonConvert.convert<String>(json['sso_source']);
  if (ssoSource != null) {
    fieldEngineerDetailResult.ssoSource = ssoSource;
  }
  final String? sysCreatedOn = jsonConvert.convert<String>(
      json['sys_created_on']);
  if (sysCreatedOn != null) {
    fieldEngineerDetailResult.sysCreatedOn = sysCreatedOn;
  }
  final String? agentStatus = jsonConvert.convert<String>(json['agent_status']);
  if (agentStatus != null) {
    fieldEngineerDetailResult.agentStatus = agentStatus;
  }
  final FieldEngineerDetailResultSysDomain? sysDomain = jsonConvert.convert<
      FieldEngineerDetailResultSysDomain>(json['sys_domain']);
  if (sysDomain != null) {
    fieldEngineerDetailResult.sysDomain = sysDomain;
  }
  final String? uPasswordLastReset = jsonConvert.convert<String>(
      json['u_password_last_reset']);
  if (uPasswordLastReset != null) {
    fieldEngineerDetailResult.uPasswordLastReset = uPasswordLastReset;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    fieldEngineerDetailResult.state = state;
  }
  final String? vip = jsonConvert.convert<String>(json['vip']);
  if (vip != null) {
    fieldEngineerDetailResult.vip = vip;
  }
  final String? sysCreatedBy = jsonConvert.convert<String>(
      json['sys_created_by']);
  if (sysCreatedBy != null) {
    fieldEngineerDetailResult.sysCreatedBy = sysCreatedBy;
  }
  final String? longitude = jsonConvert.convert<String>(json['longitude']);
  if (longitude != null) {
    fieldEngineerDetailResult.longitude = longitude;
  }
  final String? uTypeOfUser = jsonConvert.convert<String>(
      json['u_type_of_user']);
  if (uTypeOfUser != null) {
    fieldEngineerDetailResult.uTypeOfUser = uTypeOfUser;
  }
  final String? zip = jsonConvert.convert<String>(json['zip']);
  if (zip != null) {
    fieldEngineerDetailResult.zip = zip;
  }
  final String? homePhone = jsonConvert.convert<String>(json['home_phone']);
  if (homePhone != null) {
    fieldEngineerDetailResult.homePhone = homePhone;
  }
  final String? uCountry = jsonConvert.convert<String>(json['u_country']);
  if (uCountry != null) {
    fieldEngineerDetailResult.uCountry = uCountry;
  }
  final String? timeFormat = jsonConvert.convert<String>(json['time_format']);
  if (timeFormat != null) {
    fieldEngineerDetailResult.timeFormat = timeFormat;
  }
  final String? lastLogin = jsonConvert.convert<String>(json['last_login']);
  if (lastLogin != null) {
    fieldEngineerDetailResult.lastLogin = lastLogin;
  }
  final String? defaultPerspective = jsonConvert.convert<String>(
      json['default_perspective']);
  if (defaultPerspective != null) {
    fieldEngineerDetailResult.defaultPerspective = defaultPerspective;
  }
  final String? geolocationTracked = jsonConvert.convert<String>(
      json['geolocation_tracked']);
  if (geolocationTracked != null) {
    fieldEngineerDetailResult.geolocationTracked = geolocationTracked;
  }
  final String? active = jsonConvert.convert<String>(json['active']);
  if (active != null) {
    fieldEngineerDetailResult.active = active;
  }
  final String? timeSheetPolicy = jsonConvert.convert<String>(
      json['time_sheet_policy']);
  if (timeSheetPolicy != null) {
    fieldEngineerDetailResult.timeSheetPolicy = timeSheetPolicy;
  }
  final String? sysDomainPath = jsonConvert.convert<String>(
      json['sys_domain_path']);
  if (sysDomainPath != null) {
    fieldEngineerDetailResult.sysDomainPath = sysDomainPath;
  }
  final String? costCenter = jsonConvert.convert<String>(json['cost_center']);
  if (costCenter != null) {
    fieldEngineerDetailResult.costCenter = costCenter;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    fieldEngineerDetailResult.phone = phone;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    fieldEngineerDetailResult.name = name;
  }
  final String? employeeNumber = jsonConvert.convert<String>(
      json['employee_number']);
  if (employeeNumber != null) {
    fieldEngineerDetailResult.employeeNumber = employeeNumber;
  }
  final String? uAssignedCaseTasks = jsonConvert.convert<String>(
      json['u_assigned_case_tasks']);
  if (uAssignedCaseTasks != null) {
    fieldEngineerDetailResult.uAssignedCaseTasks = uAssignedCaseTasks;
  }
  final String? passwordNeedsReset = jsonConvert.convert<String>(
      json['password_needs_reset']);
  if (passwordNeedsReset != null) {
    fieldEngineerDetailResult.passwordNeedsReset = passwordNeedsReset;
  }
  final String? gender = jsonConvert.convert<String>(json['gender']);
  if (gender != null) {
    fieldEngineerDetailResult.gender = gender;
  }
  final String? city = jsonConvert.convert<String>(json['city']);
  if (city != null) {
    fieldEngineerDetailResult.city = city;
  }
  final String? failedAttempts = jsonConvert.convert<String>(
      json['failed_attempts']);
  if (failedAttempts != null) {
    fieldEngineerDetailResult.failedAttempts = failedAttempts;
  }
  final String? userName = jsonConvert.convert<String>(json['user_name']);
  if (userName != null) {
    fieldEngineerDetailResult.userName = userName;
  }
  final String? latitude = jsonConvert.convert<String>(json['latitude']);
  if (latitude != null) {
    fieldEngineerDetailResult.latitude = latitude;
  }
  final String? roles = jsonConvert.convert<String>(json['roles']);
  if (roles != null) {
    fieldEngineerDetailResult.roles = roles;
  }
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    fieldEngineerDetailResult.title = title;
  }
  final String? sysClassName = jsonConvert.convert<String>(
      json['sys_class_name']);
  if (sysClassName != null) {
    fieldEngineerDetailResult.sysClassName = sysClassName;
  }
  final String? sysId = jsonConvert.convert<String>(json['sys_id']);
  if (sysId != null) {
    fieldEngineerDetailResult.sysId = sysId;
  }
  final String? internalIntegrationUser = jsonConvert.convert<String>(
      json['internal_integration_user']);
  if (internalIntegrationUser != null) {
    fieldEngineerDetailResult.internalIntegrationUser = internalIntegrationUser;
  }
  final String? ldapServer = jsonConvert.convert<String>(json['ldap_server']);
  if (ldapServer != null) {
    fieldEngineerDetailResult.ldapServer = ldapServer;
  }
  final String? mobilePhone = jsonConvert.convert<String>(json['mobile_phone']);
  if (mobilePhone != null) {
    fieldEngineerDetailResult.mobilePhone = mobilePhone;
  }
  final String? street = jsonConvert.convert<String>(json['street']);
  if (street != null) {
    fieldEngineerDetailResult.street = street;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    fieldEngineerDetailResult.company = company;
  }
  final String? department = jsonConvert.convert<String>(json['department']);
  if (department != null) {
    fieldEngineerDetailResult.department = department;
  }
  final String? firstName = jsonConvert.convert<String>(json['first_name']);
  if (firstName != null) {
    fieldEngineerDetailResult.firstName = firstName;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    fieldEngineerDetailResult.email = email;
  }
  final String? introduction = jsonConvert.convert<String>(
      json['introduction']);
  if (introduction != null) {
    fieldEngineerDetailResult.introduction = introduction;
  }
  final String? preferredLanguage = jsonConvert.convert<String>(
      json['preferred_language']);
  if (preferredLanguage != null) {
    fieldEngineerDetailResult.preferredLanguage = preferredLanguage;
  }
  final String? manager = jsonConvert.convert<String>(json['manager']);
  if (manager != null) {
    fieldEngineerDetailResult.manager = manager;
  }
  final String? lockedOut = jsonConvert.convert<String>(json['locked_out']);
  if (lockedOut != null) {
    fieldEngineerDetailResult.lockedOut = lockedOut;
  }
  final String? sysModCount = jsonConvert.convert<String>(
      json['sys_mod_count']);
  if (sysModCount != null) {
    fieldEngineerDetailResult.sysModCount = sysModCount;
  }
  final String? lastName = jsonConvert.convert<String>(json['last_name']);
  if (lastName != null) {
    fieldEngineerDetailResult.lastName = lastName;
  }
  final String? photo = jsonConvert.convert<String>(json['photo']);
  if (photo != null) {
    fieldEngineerDetailResult.photo = photo;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    fieldEngineerDetailResult.avatar = avatar;
  }
  final String? middleName = jsonConvert.convert<String>(json['middle_name']);
  if (middleName != null) {
    fieldEngineerDetailResult.middleName = middleName;
  }
  final String? sysTags = jsonConvert.convert<String>(json['sys_tags']);
  if (sysTags != null) {
    fieldEngineerDetailResult.sysTags = sysTags;
  }
  final String? timeZone = jsonConvert.convert<String>(json['time_zone']);
  if (timeZone != null) {
    fieldEngineerDetailResult.timeZone = timeZone;
  }
  final String? schedule = jsonConvert.convert<String>(json['schedule']);
  if (schedule != null) {
    fieldEngineerDetailResult.schedule = schedule;
  }
  final String? onSchedule = jsonConvert.convert<String>(json['on_schedule']);
  if (onSchedule != null) {
    fieldEngineerDetailResult.onSchedule = onSchedule;
  }
  final String? uXblDeviceToken = jsonConvert.convert<String>(
      json['u_xbl_device_token']);
  if (uXblDeviceToken != null) {
    fieldEngineerDetailResult.uXblDeviceToken = uXblDeviceToken;
  }
  final String? dateFormat = jsonConvert.convert<String>(json['date_format']);
  if (dateFormat != null) {
    fieldEngineerDetailResult.dateFormat = dateFormat;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    fieldEngineerDetailResult.location = location;
  }
  return fieldEngineerDetailResult;
}

Map<String, dynamic> $FieldEngineerDetailResultToJson(
    FieldEngineerDetailResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['calendar_integration'] = entity.calendarIntegration;
  data['country'] = entity.country;
  data['last_position_update'] = entity.lastPositionUpdate;
  data['user_password'] = entity.userPassword;
  data['last_login_time'] = entity.lastLoginTime;
  data['source'] = entity.source;
  data['sys_updated_on'] = entity.sysUpdatedOn;
  data['u_national_id_number'] = entity.uNationalIdNumber;
  data['building'] = entity.building;
  data['u_national_id_type'] = entity.uNationalIdType;
  data['web_service_access_only'] = entity.webServiceAccessOnly;
  data['notification'] = entity.notification;
  data['u_assigned_cases'] = entity.uAssignedCases;
  data['enable_multifactor_authn'] = entity.enableMultifactorAuthn;
  data['sys_updated_by'] = entity.sysUpdatedBy;
  data['sso_source'] = entity.ssoSource;
  data['sys_created_on'] = entity.sysCreatedOn;
  data['agent_status'] = entity.agentStatus;
  data['sys_domain'] = entity.sysDomain?.toJson();
  data['u_password_last_reset'] = entity.uPasswordLastReset;
  data['state'] = entity.state;
  data['vip'] = entity.vip;
  data['sys_created_by'] = entity.sysCreatedBy;
  data['longitude'] = entity.longitude;
  data['u_type_of_user'] = entity.uTypeOfUser;
  data['zip'] = entity.zip;
  data['home_phone'] = entity.homePhone;
  data['u_country'] = entity.uCountry;
  data['time_format'] = entity.timeFormat;
  data['last_login'] = entity.lastLogin;
  data['default_perspective'] = entity.defaultPerspective;
  data['geolocation_tracked'] = entity.geolocationTracked;
  data['active'] = entity.active;
  data['time_sheet_policy'] = entity.timeSheetPolicy;
  data['sys_domain_path'] = entity.sysDomainPath;
  data['cost_center'] = entity.costCenter;
  data['phone'] = entity.phone;
  data['name'] = entity.name;
  data['employee_number'] = entity.employeeNumber;
  data['u_assigned_case_tasks'] = entity.uAssignedCaseTasks;
  data['password_needs_reset'] = entity.passwordNeedsReset;
  data['gender'] = entity.gender;
  data['city'] = entity.city;
  data['failed_attempts'] = entity.failedAttempts;
  data['user_name'] = entity.userName;
  data['latitude'] = entity.latitude;
  data['roles'] = entity.roles;
  data['title'] = entity.title;
  data['sys_class_name'] = entity.sysClassName;
  data['sys_id'] = entity.sysId;
  data['internal_integration_user'] = entity.internalIntegrationUser;
  data['ldap_server'] = entity.ldapServer;
  data['mobile_phone'] = entity.mobilePhone;
  data['street'] = entity.street;
  data['company'] = entity.company;
  data['department'] = entity.department;
  data['first_name'] = entity.firstName;
  data['email'] = entity.email;
  data['introduction'] = entity.introduction;
  data['preferred_language'] = entity.preferredLanguage;
  data['manager'] = entity.manager;
  data['locked_out'] = entity.lockedOut;
  data['sys_mod_count'] = entity.sysModCount;
  data['last_name'] = entity.lastName;
  data['photo'] = entity.photo;
  data['avatar'] = entity.avatar;
  data['middle_name'] = entity.middleName;
  data['sys_tags'] = entity.sysTags;
  data['time_zone'] = entity.timeZone;
  data['schedule'] = entity.schedule;
  data['on_schedule'] = entity.onSchedule;
  data['u_xbl_device_token'] = entity.uXblDeviceToken;
  data['date_format'] = entity.dateFormat;
  data['location'] = entity.location;
  return data;
}

extension FieldEngineerDetailResultExtension on FieldEngineerDetailResult {
  FieldEngineerDetailResult copyWith({
    String? calendarIntegration,
    String? country,
    String? lastPositionUpdate,
    String? userPassword,
    String? lastLoginTime,
    String? source,
    String? sysUpdatedOn,
    String? uNationalIdNumber,
    String? building,
    String? uNationalIdType,
    String? webServiceAccessOnly,
    String? notification,
    String? uAssignedCases,
    String? enableMultifactorAuthn,
    String? sysUpdatedBy,
    String? ssoSource,
    String? sysCreatedOn,
    String? agentStatus,
    FieldEngineerDetailResultSysDomain? sysDomain,
    String? uPasswordLastReset,
    String? state,
    String? vip,
    String? sysCreatedBy,
    String? longitude,
    String? uTypeOfUser,
    String? zip,
    String? homePhone,
    String? uCountry,
    String? timeFormat,
    String? lastLogin,
    String? defaultPerspective,
    String? geolocationTracked,
    String? active,
    String? timeSheetPolicy,
    String? sysDomainPath,
    String? costCenter,
    String? phone,
    String? name,
    String? employeeNumber,
    String? uAssignedCaseTasks,
    String? passwordNeedsReset,
    String? gender,
    String? city,
    String? failedAttempts,
    String? userName,
    String? latitude,
    String? roles,
    String? title,
    String? sysClassName,
    String? sysId,
    String? internalIntegrationUser,
    String? ldapServer,
    String? mobilePhone,
    String? street,
    String? company,
    String? department,
    String? firstName,
    String? email,
    String? introduction,
    String? preferredLanguage,
    String? manager,
    String? lockedOut,
    String? sysModCount,
    String? lastName,
    String? photo,
    String? avatar,
    String? middleName,
    String? sysTags,
    String? timeZone,
    String? schedule,
    String? onSchedule,
    String? uXblDeviceToken,
    String? dateFormat,
    String? location,
  }) {
    return FieldEngineerDetailResult()
      ..calendarIntegration = calendarIntegration ?? this.calendarIntegration
      ..country = country ?? this.country
      ..lastPositionUpdate = lastPositionUpdate ?? this.lastPositionUpdate
      ..userPassword = userPassword ?? this.userPassword
      ..lastLoginTime = lastLoginTime ?? this.lastLoginTime
      ..source = source ?? this.source
      ..sysUpdatedOn = sysUpdatedOn ?? this.sysUpdatedOn
      ..uNationalIdNumber = uNationalIdNumber ?? this.uNationalIdNumber
      ..building = building ?? this.building
      ..uNationalIdType = uNationalIdType ?? this.uNationalIdType
      ..webServiceAccessOnly = webServiceAccessOnly ?? this.webServiceAccessOnly
      ..notification = notification ?? this.notification
      ..uAssignedCases = uAssignedCases ?? this.uAssignedCases
      ..enableMultifactorAuthn = enableMultifactorAuthn ??
          this.enableMultifactorAuthn
      ..sysUpdatedBy = sysUpdatedBy ?? this.sysUpdatedBy
      ..ssoSource = ssoSource ?? this.ssoSource
      ..sysCreatedOn = sysCreatedOn ?? this.sysCreatedOn
      ..agentStatus = agentStatus ?? this.agentStatus
      ..sysDomain = sysDomain ?? this.sysDomain
      ..uPasswordLastReset = uPasswordLastReset ?? this.uPasswordLastReset
      ..state = state ?? this.state
      ..vip = vip ?? this.vip
      ..sysCreatedBy = sysCreatedBy ?? this.sysCreatedBy
      ..longitude = longitude ?? this.longitude
      ..uTypeOfUser = uTypeOfUser ?? this.uTypeOfUser
      ..zip = zip ?? this.zip
      ..homePhone = homePhone ?? this.homePhone
      ..uCountry = uCountry ?? this.uCountry
      ..timeFormat = timeFormat ?? this.timeFormat
      ..lastLogin = lastLogin ?? this.lastLogin
      ..defaultPerspective = defaultPerspective ?? this.defaultPerspective
      ..geolocationTracked = geolocationTracked ?? this.geolocationTracked
      ..active = active ?? this.active
      ..timeSheetPolicy = timeSheetPolicy ?? this.timeSheetPolicy
      ..sysDomainPath = sysDomainPath ?? this.sysDomainPath
      ..costCenter = costCenter ?? this.costCenter
      ..phone = phone ?? this.phone
      ..name = name ?? this.name
      ..employeeNumber = employeeNumber ?? this.employeeNumber
      ..uAssignedCaseTasks = uAssignedCaseTasks ?? this.uAssignedCaseTasks
      ..passwordNeedsReset = passwordNeedsReset ?? this.passwordNeedsReset
      ..gender = gender ?? this.gender
      ..city = city ?? this.city
      ..failedAttempts = failedAttempts ?? this.failedAttempts
      ..userName = userName ?? this.userName
      ..latitude = latitude ?? this.latitude
      ..roles = roles ?? this.roles
      ..title = title ?? this.title
      ..sysClassName = sysClassName ?? this.sysClassName
      ..sysId = sysId ?? this.sysId
      ..internalIntegrationUser = internalIntegrationUser ??
          this.internalIntegrationUser
      ..ldapServer = ldapServer ?? this.ldapServer
      ..mobilePhone = mobilePhone ?? this.mobilePhone
      ..street = street ?? this.street
      ..company = company ?? this.company
      ..department = department ?? this.department
      ..firstName = firstName ?? this.firstName
      ..email = email ?? this.email
      ..introduction = introduction ?? this.introduction
      ..preferredLanguage = preferredLanguage ?? this.preferredLanguage
      ..manager = manager ?? this.manager
      ..lockedOut = lockedOut ?? this.lockedOut
      ..sysModCount = sysModCount ?? this.sysModCount
      ..lastName = lastName ?? this.lastName
      ..photo = photo ?? this.photo
      ..avatar = avatar ?? this.avatar
      ..middleName = middleName ?? this.middleName
      ..sysTags = sysTags ?? this.sysTags
      ..timeZone = timeZone ?? this.timeZone
      ..schedule = schedule ?? this.schedule
      ..onSchedule = onSchedule ?? this.onSchedule
      ..uXblDeviceToken = uXblDeviceToken ?? this.uXblDeviceToken
      ..dateFormat = dateFormat ?? this.dateFormat
      ..location = location ?? this.location;
  }
}

FieldEngineerDetailResultSysDomain $FieldEngineerDetailResultSysDomainFromJson(
    Map<String, dynamic> json) {
  final FieldEngineerDetailResultSysDomain fieldEngineerDetailResultSysDomain = FieldEngineerDetailResultSysDomain();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    fieldEngineerDetailResultSysDomain.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    fieldEngineerDetailResultSysDomain.value = value;
  }
  return fieldEngineerDetailResultSysDomain;
}

Map<String, dynamic> $FieldEngineerDetailResultSysDomainToJson(
    FieldEngineerDetailResultSysDomain entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension FieldEngineerDetailResultSysDomainExtension on FieldEngineerDetailResultSysDomain {
  FieldEngineerDetailResultSysDomain copyWith({
    String? link,
    String? value,
  }) {
    return FieldEngineerDetailResultSysDomain()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}