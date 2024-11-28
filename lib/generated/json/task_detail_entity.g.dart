import 'package:xbridge/generated/json/base/json_convert_content.dart';
import 'package:xbridge/task_details/data/models/task_detail_entity.dart';

TaskDetailEntity $TaskDetailEntityFromJson(Map<String, dynamic> json) {
  final TaskDetailEntity taskDetailEntity = TaskDetailEntity();
  final TaskDetailResult? result = jsonConvert.convert<TaskDetailResult>(
      json['result']);
  if (result != null) {
    taskDetailEntity.result = result;
  }
  return taskDetailEntity;
}

Map<String, dynamic> $TaskDetailEntityToJson(TaskDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result?.toJson();
  return data;
}

extension TaskDetailEntityExtension on TaskDetailEntity {
  TaskDetailEntity copyWith({
    TaskDetailResult? result,
  }) {
    return TaskDetailEntity()
      ..result = result ?? this.result;
  }
}

TaskDetailResult $TaskDetailResultFromJson(Map<String, dynamic> json) {
  final TaskDetailResult taskDetailResult = TaskDetailResult();
  final TaskDetailResultParent? parent = jsonConvert.convert<
      TaskDetailResultParent>(json['parent']);
  if (parent != null) {
    taskDetailResult.parent = parent;
  }
  final String? uEtaSystemTime = jsonConvert.convert<String>(
      json['u_eta_system_time']);
  if (uEtaSystemTime != null) {
    taskDetailResult.uEtaSystemTime = uEtaSystemTime;
  }
  final String? watchList = jsonConvert.convert<String>(json['watch_list']);
  if (watchList != null) {
    taskDetailResult.watchList = watchList;
  }
  final String? uponReject = jsonConvert.convert<String>(json['upon_reject']);
  if (uponReject != null) {
    taskDetailResult.uponReject = uponReject;
  }
  final String? sysUpdatedOn = jsonConvert.convert<String>(
      json['sys_updated_on']);
  if (sysUpdatedOn != null) {
    taskDetailResult.sysUpdatedOn = sysUpdatedOn;
  }
  final String? approvalHistory = jsonConvert.convert<String>(
      json['approval_history']);
  if (approvalHistory != null) {
    taskDetailResult.approvalHistory = approvalHistory;
  }
  final String? skills = jsonConvert.convert<String>(json['skills']);
  if (skills != null) {
    taskDetailResult.skills = skills;
  }
  final TaskDetailResultUCaseAccount? uCaseAccount = jsonConvert.convert<
      TaskDetailResultUCaseAccount>(json['u_case_account']);
  if (uCaseAccount != null) {
    taskDetailResult.uCaseAccount = uCaseAccount;
  }
  final String? number = jsonConvert.convert<String>(json['number']);
  if (number != null) {
    taskDetailResult.number = number;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    taskDetailResult.state = state;
  }
  final String? sysCreatedBy = jsonConvert.convert<String>(
      json['sys_created_by']);
  if (sysCreatedBy != null) {
    taskDetailResult.sysCreatedBy = sysCreatedBy;
  }
  final String? knowledge = jsonConvert.convert<String>(json['knowledge']);
  if (knowledge != null) {
    taskDetailResult.knowledge = knowledge;
  }
  final String? order = jsonConvert.convert<String>(json['order']);
  if (order != null) {
    taskDetailResult.order = order;
  }
  final String? cmdbCi = jsonConvert.convert<String>(json['cmdb_ci']);
  if (cmdbCi != null) {
    taskDetailResult.cmdbCi = cmdbCi;
  }
  final String? deliveryPlan = jsonConvert.convert<String>(
      json['delivery_plan']);
  if (deliveryPlan != null) {
    taskDetailResult.deliveryPlan = deliveryPlan;
  }
  final String? contract = jsonConvert.convert<String>(json['contract']);
  if (contract != null) {
    taskDetailResult.contract = contract;
  }
  final String? impact = jsonConvert.convert<String>(json['impact']);
  if (impact != null) {
    taskDetailResult.impact = impact;
  }
  final String? active = jsonConvert.convert<String>(json['active']);
  if (active != null) {
    taskDetailResult.active = active;
  }
  final String? workNotesList = jsonConvert.convert<String>(
      json['work_notes_list']);
  if (workNotesList != null) {
    taskDetailResult.workNotesList = workNotesList;
  }
  final String? priority = jsonConvert.convert<String>(json['priority']);
  if (priority != null) {
    taskDetailResult.priority = priority;
  }
  final String? sysDomainPath = jsonConvert.convert<String>(
      json['sys_domain_path']);
  if (sysDomainPath != null) {
    taskDetailResult.sysDomainPath = sysDomainPath;
  }
  final String? uVendorWatchlist = jsonConvert.convert<String>(
      json['u_vendor_watchlist']);
  if (uVendorWatchlist != null) {
    taskDetailResult.uVendorWatchlist = uVendorWatchlist;
  }
  final String? uVendorComments = jsonConvert.convert<String>(
      json['u_vendor_comments']);
  if (uVendorComments != null) {
    taskDetailResult.uVendorComments = uVendorComments;
  }
  final String? businessDuration = jsonConvert.convert<String>(
      json['business_duration']);
  if (businessDuration != null) {
    taskDetailResult.businessDuration = businessDuration;
  }
  final String? groupList = jsonConvert.convert<String>(json['group_list']);
  if (groupList != null) {
    taskDetailResult.groupList = groupList;
  }
  final String? uTotalTimeWorked = jsonConvert.convert<String>(
      json['u_total_time_worked']);
  if (uTotalTimeWorked != null) {
    taskDetailResult.uTotalTimeWorked = uTotalTimeWorked;
  }
  final String? approvalSet = jsonConvert.convert<String>(json['approval_set']);
  if (approvalSet != null) {
    taskDetailResult.approvalSet = approvalSet;
  }
  final String? needsAttention = jsonConvert.convert<String>(
      json['needs_attention']);
  if (needsAttention != null) {
    taskDetailResult.needsAttention = needsAttention;
  }
  final String? universalRequest = jsonConvert.convert<String>(
      json['universal_request']);
  if (universalRequest != null) {
    taskDetailResult.universalRequest = universalRequest;
  }
  final String? shortDescription = jsonConvert.convert<String>(
      json['short_description']);
  if (shortDescription != null) {
    taskDetailResult.shortDescription = shortDescription;
  }
  final String? correlationDisplay = jsonConvert.convert<String>(
      json['correlation_display']);
  if (correlationDisplay != null) {
    taskDetailResult.correlationDisplay = correlationDisplay;
  }
  final String? deliveryTask = jsonConvert.convert<String>(
      json['delivery_task']);
  if (deliveryTask != null) {
    taskDetailResult.deliveryTask = deliveryTask;
  }
  final String? workStart = jsonConvert.convert<String>(json['work_start']);
  if (workStart != null) {
    taskDetailResult.workStart = workStart;
  }
  final String? associatedTable = jsonConvert.convert<String>(
      json['associated_table']);
  if (associatedTable != null) {
    taskDetailResult.associatedTable = associatedTable;
  }
  final String? additionalAssigneeList = jsonConvert.convert<String>(
      json['additional_assignee_list']);
  if (additionalAssigneeList != null) {
    taskDetailResult.additionalAssigneeList = additionalAssigneeList;
  }
  final String? uDispatchOtNumber = jsonConvert.convert<String>(
      json['u_dispatch_ot_number']);
  if (uDispatchOtNumber != null) {
    taskDetailResult.uDispatchOtNumber = uDispatchOtNumber;
  }
  final String? uParentCaseType = jsonConvert.convert<String>(
      json['u_parent_case_type']);
  if (uParentCaseType != null) {
    taskDetailResult.uParentCaseType = uParentCaseType;
  }
  final String? uArrivalTimeSystem = jsonConvert.convert<String>(
      json['u_arrival_time_system']);
  if (uArrivalTimeSystem != null) {
    taskDetailResult.uArrivalTimeSystem = uArrivalTimeSystem;
  }
  final String? uTotalOvertimeWorked = jsonConvert.convert<String>(
      json['u_total_overtime_worked']);
  if (uTotalOvertimeWorked != null) {
    taskDetailResult.uTotalOvertimeWorked = uTotalOvertimeWorked;
  }
  final String? serviceOffering = jsonConvert.convert<String>(
      json['service_offering']);
  if (serviceOffering != null) {
    taskDetailResult.serviceOffering = serviceOffering;
  }
  final String? sysClassName = jsonConvert.convert<String>(
      json['sys_class_name']);
  if (sysClassName != null) {
    taskDetailResult.sysClassName = sysClassName;
  }
  final TaskDetailResultClosedBy? closedBy = jsonConvert.convert<
      TaskDetailResultClosedBy>(json['closed_by']);
  if (closedBy != null) {
    taskDetailResult.closedBy = closedBy;
  }
  final String? followUp = jsonConvert.convert<String>(json['follow_up']);
  if (followUp != null) {
    taskDetailResult.followUp = followUp;
  }
  final String? uUpdatesFromVendor = jsonConvert.convert<String>(
      json['u_updates_from_vendor']);
  if (uUpdatesFromVendor != null) {
    taskDetailResult.uUpdatesFromVendor = uUpdatesFromVendor;
  }
  final String? reassignmentCount = jsonConvert.convert<String>(
      json['reassignment_count']);
  if (reassignmentCount != null) {
    taskDetailResult.reassignmentCount = reassignmentCount;
  }
  final String? uWorkStarted = jsonConvert.convert<String>(
      json['u_work_started']);
  if (uWorkStarted != null) {
    taskDetailResult.uWorkStarted = uWorkStarted;
  }
  final TaskDetailResultAssignedTo? assignedTo = jsonConvert.convert<
      TaskDetailResultAssignedTo>(json['assigned_to']);
  if (assignedTo != null) {
    taskDetailResult.assignedTo = assignedTo;
  }
  final String? uMarkUnread = jsonConvert.convert<String>(
      json['u_mark_unread']);
  if (uMarkUnread != null) {
    taskDetailResult.uMarkUnread = uMarkUnread;
  }
  final String? slaDue = jsonConvert.convert<String>(json['sla_due']);
  if (slaDue != null) {
    taskDetailResult.slaDue = slaDue;
  }
  final String? uSlaBreached = jsonConvert.convert<String>(
      json['u_sla_breached']);
  if (uSlaBreached != null) {
    taskDetailResult.uSlaBreached = uSlaBreached;
  }
  final String? associatedRecord = jsonConvert.convert<String>(
      json['associated_record']);
  if (associatedRecord != null) {
    taskDetailResult.associatedRecord = associatedRecord;
  }
  final String? commentsAndWorkNotes = jsonConvert.convert<String>(
      json['comments_and_work_notes']);
  if (commentsAndWorkNotes != null) {
    taskDetailResult.commentsAndWorkNotes = commentsAndWorkNotes;
  }
  final String? uIsItTigServedSite = jsonConvert.convert<String>(
      json['u_is_it_tig_served_site']);
  if (uIsItTigServedSite != null) {
    taskDetailResult.uIsItTigServedSite = uIsItTigServedSite;
  }
  final String? uArrivalTime = jsonConvert.convert<String>(
      json['u_arrival_time']);
  if (uArrivalTime != null) {
    taskDetailResult.uArrivalTime = uArrivalTime;
  }
  final String? uWorkCompletedSystem = jsonConvert.convert<String>(
      json['u_work_completed_system']);
  if (uWorkCompletedSystem != null) {
    taskDetailResult.uWorkCompletedSystem = uWorkCompletedSystem;
  }
  final String? escalation = jsonConvert.convert<String>(json['escalation']);
  if (escalation != null) {
    taskDetailResult.escalation = escalation;
  }
  final String? uponApproval = jsonConvert.convert<String>(
      json['upon_approval']);
  if (uponApproval != null) {
    taskDetailResult.uponApproval = uponApproval;
  }
  final String? correlationId = jsonConvert.convert<String>(
      json['correlation_id']);
  if (correlationId != null) {
    taskDetailResult.correlationId = correlationId;
  }
  final String? visibleToCustomer = jsonConvert.convert<String>(
      json['visible_to_customer']);
  if (visibleToCustomer != null) {
    taskDetailResult.visibleToCustomer = visibleToCustomer;
  }
  final String? madeSla = jsonConvert.convert<String>(json['made_sla']);
  if (madeSla != null) {
    taskDetailResult.madeSla = madeSla;
  }
  final String? uInternalWatchlistCaseTask = jsonConvert.convert<String>(
      json['u_internal_watchlist_case_task']);
  if (uInternalWatchlistCaseTask != null) {
    taskDetailResult.uInternalWatchlistCaseTask = uInternalWatchlistCaseTask;
  }
  final String? uDifferenceDepartureArrivalTime = jsonConvert.convert<String>(
      json['u_difference_departure_arrival_time']);
  if (uDifferenceDepartureArrivalTime != null) {
    taskDetailResult.uDifferenceDepartureArrivalTime =
        uDifferenceDepartureArrivalTime;
  }
  final String? uPartCode = jsonConvert.convert<String>(json['u_part_code']);
  if (uPartCode != null) {
    taskDetailResult.uPartCode = uPartCode;
  }
  final String? uCheckCalendar = jsonConvert.convert<String>(
      json['u_check_calendar']);
  if (uCheckCalendar != null) {
    taskDetailResult.uCheckCalendar = uCheckCalendar;
  }
  final String? uPreferredScheduleByCustomerSystem = jsonConvert.convert<
      String>(json['u_preferred_schedule_by_customer_system']);
  if (uPreferredScheduleByCustomerSystem != null) {
    taskDetailResult.uPreferredScheduleByCustomerSystem =
        uPreferredScheduleByCustomerSystem;
  }
  final String? uInternalWatchlistForCc = jsonConvert.convert<String>(
      json['u_internal_watchlist_for_cc']);
  if (uInternalWatchlistForCc != null) {
    taskDetailResult.uInternalWatchlistForCc = uInternalWatchlistForCc;
  }
  final String? uScheduledDataByVendor = jsonConvert.convert<String>(
      json['u_scheduled_data_by_vendor']);
  if (uScheduledDataByVendor != null) {
    taskDetailResult.uScheduledDataByVendor = uScheduledDataByVendor;
  }
  final String? taskEffectiveNumber = jsonConvert.convert<String>(
      json['task_effective_number']);
  if (taskEffectiveNumber != null) {
    taskDetailResult.taskEffectiveNumber = taskEffectiveNumber;
  }
  final String? uTravelStartTime = jsonConvert.convert<String>(
      json['u_travel_start_time']);
  if (uTravelStartTime != null) {
    taskDetailResult.uTravelStartTime = uTravelStartTime;
  }
  final String? sysUpdatedBy = jsonConvert.convert<String>(
      json['sys_updated_by']);
  if (sysUpdatedBy != null) {
    taskDetailResult.sysUpdatedBy = sysUpdatedBy;
  }
  final String? uResolutionNotes = jsonConvert.convert<String>(
      json['u_resolution_notes']);
  if (uResolutionNotes != null) {
    taskDetailResult.uResolutionNotes = uResolutionNotes;
  }
  final TaskDetailResultOpenedBy? openedBy = jsonConvert.convert<
      TaskDetailResultOpenedBy>(json['opened_by']);
  if (openedBy != null) {
    taskDetailResult.openedBy = openedBy;
  }
  final String? userInput = jsonConvert.convert<String>(json['user_input']);
  if (userInput != null) {
    taskDetailResult.userInput = userInput;
  }
  final String? sysCreatedOn = jsonConvert.convert<String>(
      json['sys_created_on']);
  if (sysCreatedOn != null) {
    taskDetailResult.sysCreatedOn = sysCreatedOn;
  }
  final TaskDetailResultContact? contact = jsonConvert.convert<
      TaskDetailResultContact>(json['contact']);
  if (contact != null) {
    taskDetailResult.contact = contact;
  }
  final TaskDetailResultSysDomain? sysDomain = jsonConvert.convert<
      TaskDetailResultSysDomain>(json['sys_domain']);
  if (sysDomain != null) {
    taskDetailResult.sysDomain = sysDomain;
  }
  final String? uReturnRequestType = jsonConvert.convert<String>(
      json['u_return_request_type']);
  if (uReturnRequestType != null) {
    taskDetailResult.uReturnRequestType = uReturnRequestType;
  }
  final String? routeReason = jsonConvert.convert<String>(json['route_reason']);
  if (routeReason != null) {
    taskDetailResult.routeReason = routeReason;
  }
  final String? uUpdatesFromRestUser = jsonConvert.convert<String>(
      json['u_updates_from_rest_user']);
  if (uUpdatesFromRestUser != null) {
    taskDetailResult.uUpdatesFromRestUser = uUpdatesFromRestUser;
  }
  final String? closedAt = jsonConvert.convert<String>(json['closed_at']);
  if (closedAt != null) {
    taskDetailResult.closedAt = closedAt;
  }
  final String? uCustomerSatisfaction = jsonConvert.convert<String>(
      json['u_customer_satisfaction']);
  if (uCustomerSatisfaction != null) {
    taskDetailResult.uCustomerSatisfaction = uCustomerSatisfaction;
  }
  final String? businessService = jsonConvert.convert<String>(
      json['business_service']);
  if (businessService != null) {
    taskDetailResult.businessService = businessService;
  }
  final String? expectedStart = jsonConvert.convert<String>(
      json['expected_start']);
  if (expectedStart != null) {
    taskDetailResult.expectedStart = expectedStart;
  }
  final String? uDepartureTimeSystem = jsonConvert.convert<String>(
      json['u_departure_time_system']);
  if (uDepartureTimeSystem != null) {
    taskDetailResult.uDepartureTimeSystem = uDepartureTimeSystem;
  }
  final TaskDetailResultUParent? uParent = jsonConvert.convert<
      TaskDetailResultUParent>(json['u_parent']);
  if (uParent != null) {
    taskDetailResult.uParent = uParent;
  }
  final String? openedAt = jsonConvert.convert<String>(json['opened_at']);
  if (openedAt != null) {
    taskDetailResult.openedAt = openedAt;
  }
  final String? uWorkStartedSystem = jsonConvert.convert<String>(
      json['u_work_started_system']);
  if (uWorkStartedSystem != null) {
    taskDetailResult.uWorkStartedSystem = uWorkStartedSystem;
  }
  final String? workEnd = jsonConvert.convert<String>(json['work_end']);
  if (workEnd != null) {
    taskDetailResult.workEnd = workEnd;
  }
  final String? workNotes = jsonConvert.convert<String>(json['work_notes']);
  if (workNotes != null) {
    taskDetailResult.workNotes = workNotes;
  }
  final String? uCasePriority = jsonConvert.convert<String>(
      json['u_case_priority']);
  if (uCasePriority != null) {
    taskDetailResult.uCasePriority = uCasePriority;
  }
  final TaskDetailResultAssignmentGroup? assignmentGroup = jsonConvert.convert<
      TaskDetailResultAssignmentGroup>(json['assignment_group']);
  if (assignmentGroup != null) {
    taskDetailResult.assignmentGroup = assignmentGroup;
  }
  final String? uRespondedTime = jsonConvert.convert<String>(
      json['u_responded_time']);
  if (uRespondedTime != null) {
    taskDetailResult.uRespondedTime = uRespondedTime;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    taskDetailResult.description = description;
  }
  final String? calendarDuration = jsonConvert.convert<String>(
      json['calendar_duration']);
  if (calendarDuration != null) {
    taskDetailResult.calendarDuration = calendarDuration;
  }
  final String? closeNotes = jsonConvert.convert<String>(json['close_notes']);
  if (closeNotes != null) {
    taskDetailResult.closeNotes = closeNotes;
  }
  final String? sysId = jsonConvert.convert<String>(json['sys_id']);
  if (sysId != null) {
    taskDetailResult.sysId = sysId;
  }
  final String? contactType = jsonConvert.convert<String>(json['contact_type']);
  if (contactType != null) {
    taskDetailResult.contactType = contactType;
  }
  final String? urgency = jsonConvert.convert<String>(json['urgency']);
  if (urgency != null) {
    taskDetailResult.urgency = urgency;
  }
  final String? uPreferredScheduleByCustomer = jsonConvert.convert<String>(
      json['u_preferred_schedule_by_customer']);
  if (uPreferredScheduleByCustomer != null) {
    taskDetailResult.uPreferredScheduleByCustomer =
        uPreferredScheduleByCustomer;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    taskDetailResult.company = company;
  }
  final String? uInternalWatchlistForCcCaseTask = jsonConvert.convert<String>(
      json['u_internal_watchlist_for_cc_case_task']);
  if (uInternalWatchlistForCcCaseTask != null) {
    taskDetailResult.uInternalWatchlistForCcCaseTask =
        uInternalWatchlistForCcCaseTask;
  }
  final String? uTravelStartTimeSystem = jsonConvert.convert<String>(
      json['u_travel_start_time_system']);
  if (uTravelStartTimeSystem != null) {
    taskDetailResult.uTravelStartTimeSystem = uTravelStartTimeSystem;
  }
  final String? activityDue = jsonConvert.convert<String>(json['activity_due']);
  if (activityDue != null) {
    taskDetailResult.activityDue = activityDue;
  }
  final String? consumer = jsonConvert.convert<String>(json['consumer']);
  if (consumer != null) {
    taskDetailResult.consumer = consumer;
  }
  final TaskDetailResultParentCase? parentCase = jsonConvert.convert<
      TaskDetailResultParentCase>(json['parent_case']);
  if (parentCase != null) {
    taskDetailResult.parentCase = parentCase;
  }
  final String? actionStatus = jsonConvert.convert<String>(
      json['action_status']);
  if (actionStatus != null) {
    taskDetailResult.actionStatus = actionStatus;
  }
  final String? uNextActionScheduledStart = jsonConvert.convert<String>(
      json['u_next_action_scheduled_start']);
  if (uNextActionScheduledStart != null) {
    taskDetailResult.uNextActionScheduledStart = uNextActionScheduledStart;
  }
  final String? comments = jsonConvert.convert<String>(json['comments']);
  if (comments != null) {
    taskDetailResult.comments = comments;
  }
  final String? uSalesforceRecordId = jsonConvert.convert<String>(
      json['u_salesforce_record_id']);
  if (uSalesforceRecordId != null) {
    taskDetailResult.uSalesforceRecordId = uSalesforceRecordId;
  }
  final String? uVendorWatchlistForCc = jsonConvert.convert<String>(
      json['u_vendor_watchlist_for_cc']);
  if (uVendorWatchlistForCc != null) {
    taskDetailResult.uVendorWatchlistForCc = uVendorWatchlistForCc;
  }
  final String? approval = jsonConvert.convert<String>(json['approval']);
  if (approval != null) {
    taskDetailResult.approval = approval;
  }
  final String? dueDate = jsonConvert.convert<String>(json['due_date']);
  if (dueDate != null) {
    taskDetailResult.dueDate = dueDate;
  }
  final String? sysModCount = jsonConvert.convert<String>(
      json['sys_mod_count']);
  if (sysModCount != null) {
    taskDetailResult.sysModCount = sysModCount;
  }
  final String? uNextActionPersonEmail = jsonConvert.convert<String>(
      json['u_next_action_person_email']);
  if (uNextActionPersonEmail != null) {
    taskDetailResult.uNextActionPersonEmail = uNextActionPersonEmail;
  }
  final String? sysTags = jsonConvert.convert<String>(json['sys_tags']);
  if (sysTags != null) {
    taskDetailResult.sysTags = sysTags;
  }
  final String? uResolutionCode = jsonConvert.convert<String>(
      json['u_resolution_code']);
  if (uResolutionCode != null) {
    taskDetailResult.uResolutionCode = uResolutionCode;
  }
  final String? uWorkCompleted = jsonConvert.convert<String>(
      json['u_work_completed']);
  if (uWorkCompleted != null) {
    taskDetailResult.uWorkCompleted = uWorkCompleted;
  }
  final String? service = jsonConvert.convert<String>(json['service']);
  if (service != null) {
    taskDetailResult.service = service;
  }
  final String? uCaseServiceType = jsonConvert.convert<String>(
      json['u_case_service_type']);
  if (uCaseServiceType != null) {
    taskDetailResult.uCaseServiceType = uCaseServiceType;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    taskDetailResult.location = location;
  }
  final String? uCustomerWatchlistForCc = jsonConvert.convert<String>(
      json['u_customer_watchlist_for_cc']);
  if (uCustomerWatchlistForCc != null) {
    taskDetailResult.uCustomerWatchlistForCc = uCustomerWatchlistForCc;
  }
  final TaskDetailResultAccount? account = jsonConvert.convert<
      TaskDetailResultAccount>(json['account']);
  if (account != null) {
    taskDetailResult.account = account;
  }
  final String? uDepartureTime = jsonConvert.convert<String>(
      json['u_departure_time']);
  if (uDepartureTime != null) {
    taskDetailResult.uDepartureTime = uDepartureTime;
  }
  final String? uEtaProvidedVendorToTig = jsonConvert.convert<String>(
      json['u_eta_provided_vendor_to_tig']);
  if (uEtaProvidedVendorToTig != null) {
    taskDetailResult.uEtaProvidedVendorToTig = uEtaProvidedVendorToTig;
  }
  return taskDetailResult;
}

Map<String, dynamic> $TaskDetailResultToJson(TaskDetailResult entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['parent'] = entity.parent?.toJson();
  data['u_eta_system_time'] = entity.uEtaSystemTime;
  data['watch_list'] = entity.watchList;
  data['upon_reject'] = entity.uponReject;
  data['sys_updated_on'] = entity.sysUpdatedOn;
  data['approval_history'] = entity.approvalHistory;
  data['skills'] = entity.skills;
  data['u_case_account'] = entity.uCaseAccount?.toJson();
  data['number'] = entity.number;
  data['state'] = entity.state;
  data['sys_created_by'] = entity.sysCreatedBy;
  data['knowledge'] = entity.knowledge;
  data['order'] = entity.order;
  data['cmdb_ci'] = entity.cmdbCi;
  data['delivery_plan'] = entity.deliveryPlan;
  data['contract'] = entity.contract;
  data['impact'] = entity.impact;
  data['active'] = entity.active;
  data['work_notes_list'] = entity.workNotesList;
  data['priority'] = entity.priority;
  data['sys_domain_path'] = entity.sysDomainPath;
  data['u_vendor_watchlist'] = entity.uVendorWatchlist;
  data['u_vendor_comments'] = entity.uVendorComments;
  data['business_duration'] = entity.businessDuration;
  data['group_list'] = entity.groupList;
  data['u_total_time_worked'] = entity.uTotalTimeWorked;
  data['approval_set'] = entity.approvalSet;
  data['needs_attention'] = entity.needsAttention;
  data['universal_request'] = entity.universalRequest;
  data['short_description'] = entity.shortDescription;
  data['correlation_display'] = entity.correlationDisplay;
  data['delivery_task'] = entity.deliveryTask;
  data['work_start'] = entity.workStart;
  data['associated_table'] = entity.associatedTable;
  data['additional_assignee_list'] = entity.additionalAssigneeList;
  data['u_dispatch_ot_number'] = entity.uDispatchOtNumber;
  data['u_parent_case_type'] = entity.uParentCaseType;
  data['u_arrival_time_system'] = entity.uArrivalTimeSystem;
  data['u_total_overtime_worked'] = entity.uTotalOvertimeWorked;
  data['service_offering'] = entity.serviceOffering;
  data['sys_class_name'] = entity.sysClassName;
  data['closed_by'] = entity.closedBy?.toJson();
  data['follow_up'] = entity.followUp;
  data['u_updates_from_vendor'] = entity.uUpdatesFromVendor;
  data['reassignment_count'] = entity.reassignmentCount;
  data['u_work_started'] = entity.uWorkStarted;
  data['assigned_to'] = entity.assignedTo?.toJson();
  data['u_mark_unread'] = entity.uMarkUnread;
  data['sla_due'] = entity.slaDue;
  data['u_sla_breached'] = entity.uSlaBreached;
  data['associated_record'] = entity.associatedRecord;
  data['comments_and_work_notes'] = entity.commentsAndWorkNotes;
  data['u_is_it_tig_served_site'] = entity.uIsItTigServedSite;
  data['u_arrival_time'] = entity.uArrivalTime;
  data['u_work_completed_system'] = entity.uWorkCompletedSystem;
  data['escalation'] = entity.escalation;
  data['upon_approval'] = entity.uponApproval;
  data['correlation_id'] = entity.correlationId;
  data['visible_to_customer'] = entity.visibleToCustomer;
  data['made_sla'] = entity.madeSla;
  data['u_internal_watchlist_case_task'] = entity.uInternalWatchlistCaseTask;
  data['u_difference_departure_arrival_time'] =
      entity.uDifferenceDepartureArrivalTime;
  data['u_part_code'] = entity.uPartCode;
  data['u_check_calendar'] = entity.uCheckCalendar;
  data['u_preferred_schedule_by_customer_system'] =
      entity.uPreferredScheduleByCustomerSystem;
  data['u_internal_watchlist_for_cc'] = entity.uInternalWatchlistForCc;
  data['u_scheduled_data_by_vendor'] = entity.uScheduledDataByVendor;
  data['task_effective_number'] = entity.taskEffectiveNumber;
  data['u_travel_start_time'] = entity.uTravelStartTime;
  data['sys_updated_by'] = entity.sysUpdatedBy;
  data['u_resolution_notes'] = entity.uResolutionNotes;
  data['opened_by'] = entity.openedBy?.toJson();
  data['user_input'] = entity.userInput;
  data['sys_created_on'] = entity.sysCreatedOn;
  data['contact'] = entity.contact?.toJson();
  data['sys_domain'] = entity.sysDomain?.toJson();
  data['u_return_request_type'] = entity.uReturnRequestType;
  data['route_reason'] = entity.routeReason;
  data['u_updates_from_rest_user'] = entity.uUpdatesFromRestUser;
  data['closed_at'] = entity.closedAt;
  data['u_customer_satisfaction'] = entity.uCustomerSatisfaction;
  data['business_service'] = entity.businessService;
  data['expected_start'] = entity.expectedStart;
  data['u_departure_time_system'] = entity.uDepartureTimeSystem;
  data['u_parent'] = entity.uParent?.toJson();
  data['opened_at'] = entity.openedAt;
  data['u_work_started_system'] = entity.uWorkStartedSystem;
  data['work_end'] = entity.workEnd;
  data['work_notes'] = entity.workNotes;
  data['u_case_priority'] = entity.uCasePriority;
  data['assignment_group'] = entity.assignmentGroup?.toJson();
  data['u_responded_time'] = entity.uRespondedTime;
  data['description'] = entity.description;
  data['calendar_duration'] = entity.calendarDuration;
  data['close_notes'] = entity.closeNotes;
  data['sys_id'] = entity.sysId;
  data['contact_type'] = entity.contactType;
  data['urgency'] = entity.urgency;
  data['u_preferred_schedule_by_customer'] =
      entity.uPreferredScheduleByCustomer;
  data['company'] = entity.company;
  data['u_internal_watchlist_for_cc_case_task'] =
      entity.uInternalWatchlistForCcCaseTask;
  data['u_travel_start_time_system'] = entity.uTravelStartTimeSystem;
  data['activity_due'] = entity.activityDue;
  data['consumer'] = entity.consumer;
  data['parent_case'] = entity.parentCase?.toJson();
  data['action_status'] = entity.actionStatus;
  data['u_next_action_scheduled_start'] = entity.uNextActionScheduledStart;
  data['comments'] = entity.comments;
  data['u_salesforce_record_id'] = entity.uSalesforceRecordId;
  data['u_vendor_watchlist_for_cc'] = entity.uVendorWatchlistForCc;
  data['approval'] = entity.approval;
  data['due_date'] = entity.dueDate;
  data['sys_mod_count'] = entity.sysModCount;
  data['u_next_action_person_email'] = entity.uNextActionPersonEmail;
  data['sys_tags'] = entity.sysTags;
  data['u_resolution_code'] = entity.uResolutionCode;
  data['u_work_completed'] = entity.uWorkCompleted;
  data['service'] = entity.service;
  data['u_case_service_type'] = entity.uCaseServiceType;
  data['location'] = entity.location;
  data['u_customer_watchlist_for_cc'] = entity.uCustomerWatchlistForCc;
  data['account'] = entity.account?.toJson();
  data['u_departure_time'] = entity.uDepartureTime;
  data['u_eta_provided_vendor_to_tig'] = entity.uEtaProvidedVendorToTig;
  return data;
}

extension TaskDetailResultExtension on TaskDetailResult {
  TaskDetailResult copyWith({
    TaskDetailResultParent? parent,
    String? uEtaSystemTime,
    String? watchList,
    String? uponReject,
    String? sysUpdatedOn,
    String? approvalHistory,
    String? skills,
    TaskDetailResultUCaseAccount? uCaseAccount,
    String? number,
    String? state,
    String? sysCreatedBy,
    String? knowledge,
    String? order,
    String? cmdbCi,
    String? deliveryPlan,
    String? contract,
    String? impact,
    String? active,
    String? workNotesList,
    String? priority,
    String? sysDomainPath,
    String? uVendorWatchlist,
    String? uVendorComments,
    String? businessDuration,
    String? groupList,
    String? uTotalTimeWorked,
    String? approvalSet,
    String? needsAttention,
    String? universalRequest,
    String? shortDescription,
    String? correlationDisplay,
    String? deliveryTask,
    String? workStart,
    String? associatedTable,
    String? additionalAssigneeList,
    String? uDispatchOtNumber,
    String? uParentCaseType,
    String? uArrivalTimeSystem,
    String? uTotalOvertimeWorked,
    String? serviceOffering,
    String? sysClassName,
    TaskDetailResultClosedBy? closedBy,
    String? followUp,
    String? uUpdatesFromVendor,
    String? reassignmentCount,
    String? uWorkStarted,
    TaskDetailResultAssignedTo? assignedTo,
    String? uMarkUnread,
    String? slaDue,
    String? uSlaBreached,
    String? associatedRecord,
    String? commentsAndWorkNotes,
    String? uIsItTigServedSite,
    String? uArrivalTime,
    String? uWorkCompletedSystem,
    String? escalation,
    String? uponApproval,
    String? correlationId,
    String? visibleToCustomer,
    String? madeSla,
    String? uInternalWatchlistCaseTask,
    String? uDifferenceDepartureArrivalTime,
    String? uPartCode,
    String? uCheckCalendar,
    String? uPreferredScheduleByCustomerSystem,
    String? uInternalWatchlistForCc,
    String? uScheduledDataByVendor,
    String? taskEffectiveNumber,
    String? uTravelStartTime,
    String? sysUpdatedBy,
    String? uResolutionNotes,
    TaskDetailResultOpenedBy? openedBy,
    String? userInput,
    String? sysCreatedOn,
    TaskDetailResultContact? contact,
    TaskDetailResultSysDomain? sysDomain,
    String? uReturnRequestType,
    String? routeReason,
    String? uUpdatesFromRestUser,
    String? closedAt,
    String? uCustomerSatisfaction,
    String? businessService,
    String? expectedStart,
    String? uDepartureTimeSystem,
    TaskDetailResultUParent? uParent,
    String? openedAt,
    String? uWorkStartedSystem,
    String? workEnd,
    String? workNotes,
    String? uCasePriority,
    TaskDetailResultAssignmentGroup? assignmentGroup,
    String? uRespondedTime,
    String? description,
    String? calendarDuration,
    String? closeNotes,
    String? sysId,
    String? contactType,
    String? urgency,
    String? uPreferredScheduleByCustomer,
    String? company,
    String? uInternalWatchlistForCcCaseTask,
    String? uTravelStartTimeSystem,
    String? activityDue,
    String? consumer,
    TaskDetailResultParentCase? parentCase,
    String? actionStatus,
    String? uNextActionScheduledStart,
    String? comments,
    String? uSalesforceRecordId,
    String? uVendorWatchlistForCc,
    String? approval,
    String? dueDate,
    String? sysModCount,
    String? uNextActionPersonEmail,
    String? sysTags,
    String? uResolutionCode,
    String? uWorkCompleted,
    String? service,
    String? uCaseServiceType,
    String? location,
    String? uCustomerWatchlistForCc,
    TaskDetailResultAccount? account,
    String? uDepartureTime,
    String? uEtaProvidedVendorToTig,
  }) {
    return TaskDetailResult()
      ..parent = parent ?? this.parent
      ..uEtaSystemTime = uEtaSystemTime ?? this.uEtaSystemTime
      ..watchList = watchList ?? this.watchList
      ..uponReject = uponReject ?? this.uponReject
      ..sysUpdatedOn = sysUpdatedOn ?? this.sysUpdatedOn
      ..approvalHistory = approvalHistory ?? this.approvalHistory
      ..skills = skills ?? this.skills
      ..uCaseAccount = uCaseAccount ?? this.uCaseAccount
      ..number = number ?? this.number
      ..state = state ?? this.state
      ..sysCreatedBy = sysCreatedBy ?? this.sysCreatedBy
      ..knowledge = knowledge ?? this.knowledge
      ..order = order ?? this.order
      ..cmdbCi = cmdbCi ?? this.cmdbCi
      ..deliveryPlan = deliveryPlan ?? this.deliveryPlan
      ..contract = contract ?? this.contract
      ..impact = impact ?? this.impact
      ..active = active ?? this.active
      ..workNotesList = workNotesList ?? this.workNotesList
      ..priority = priority ?? this.priority
      ..sysDomainPath = sysDomainPath ?? this.sysDomainPath
      ..uVendorWatchlist = uVendorWatchlist ?? this.uVendorWatchlist
      ..uVendorComments = uVendorComments ?? this.uVendorComments
      ..businessDuration = businessDuration ?? this.businessDuration
      ..groupList = groupList ?? this.groupList
      ..uTotalTimeWorked = uTotalTimeWorked ?? this.uTotalTimeWorked
      ..approvalSet = approvalSet ?? this.approvalSet
      ..needsAttention = needsAttention ?? this.needsAttention
      ..universalRequest = universalRequest ?? this.universalRequest
      ..shortDescription = shortDescription ?? this.shortDescription
      ..correlationDisplay = correlationDisplay ?? this.correlationDisplay
      ..deliveryTask = deliveryTask ?? this.deliveryTask
      ..workStart = workStart ?? this.workStart
      ..associatedTable = associatedTable ?? this.associatedTable
      ..additionalAssigneeList = additionalAssigneeList ??
          this.additionalAssigneeList
      ..uDispatchOtNumber = uDispatchOtNumber ?? this.uDispatchOtNumber
      ..uParentCaseType = uParentCaseType ?? this.uParentCaseType
      ..uArrivalTimeSystem = uArrivalTimeSystem ?? this.uArrivalTimeSystem
      ..uTotalOvertimeWorked = uTotalOvertimeWorked ?? this.uTotalOvertimeWorked
      ..serviceOffering = serviceOffering ?? this.serviceOffering
      ..sysClassName = sysClassName ?? this.sysClassName
      ..closedBy = closedBy ?? this.closedBy
      ..followUp = followUp ?? this.followUp
      ..uUpdatesFromVendor = uUpdatesFromVendor ?? this.uUpdatesFromVendor
      ..reassignmentCount = reassignmentCount ?? this.reassignmentCount
      ..uWorkStarted = uWorkStarted ?? this.uWorkStarted
      ..assignedTo = assignedTo ?? this.assignedTo
      ..uMarkUnread = uMarkUnread ?? this.uMarkUnread
      ..slaDue = slaDue ?? this.slaDue
      ..uSlaBreached = uSlaBreached ?? this.uSlaBreached
      ..associatedRecord = associatedRecord ?? this.associatedRecord
      ..commentsAndWorkNotes = commentsAndWorkNotes ?? this.commentsAndWorkNotes
      ..uIsItTigServedSite = uIsItTigServedSite ?? this.uIsItTigServedSite
      ..uArrivalTime = uArrivalTime ?? this.uArrivalTime
      ..uWorkCompletedSystem = uWorkCompletedSystem ?? this.uWorkCompletedSystem
      ..escalation = escalation ?? this.escalation
      ..uponApproval = uponApproval ?? this.uponApproval
      ..correlationId = correlationId ?? this.correlationId
      ..visibleToCustomer = visibleToCustomer ?? this.visibleToCustomer
      ..madeSla = madeSla ?? this.madeSla
      ..uInternalWatchlistCaseTask = uInternalWatchlistCaseTask ??
          this.uInternalWatchlistCaseTask
      ..uDifferenceDepartureArrivalTime = uDifferenceDepartureArrivalTime ??
          this.uDifferenceDepartureArrivalTime
      ..uPartCode = uPartCode ?? this.uPartCode
      ..uCheckCalendar = uCheckCalendar ?? this.uCheckCalendar
      ..uPreferredScheduleByCustomerSystem = uPreferredScheduleByCustomerSystem ??
          this.uPreferredScheduleByCustomerSystem
      ..uInternalWatchlistForCc = uInternalWatchlistForCc ??
          this.uInternalWatchlistForCc
      ..uScheduledDataByVendor = uScheduledDataByVendor ??
          this.uScheduledDataByVendor
      ..taskEffectiveNumber = taskEffectiveNumber ?? this.taskEffectiveNumber
      ..uTravelStartTime = uTravelStartTime ?? this.uTravelStartTime
      ..sysUpdatedBy = sysUpdatedBy ?? this.sysUpdatedBy
      ..uResolutionNotes = uResolutionNotes ?? this.uResolutionNotes
      ..openedBy = openedBy ?? this.openedBy
      ..userInput = userInput ?? this.userInput
      ..sysCreatedOn = sysCreatedOn ?? this.sysCreatedOn
      ..contact = contact ?? this.contact
      ..sysDomain = sysDomain ?? this.sysDomain
      ..uReturnRequestType = uReturnRequestType ?? this.uReturnRequestType
      ..routeReason = routeReason ?? this.routeReason
      ..uUpdatesFromRestUser = uUpdatesFromRestUser ?? this.uUpdatesFromRestUser
      ..closedAt = closedAt ?? this.closedAt
      ..uCustomerSatisfaction = uCustomerSatisfaction ??
          this.uCustomerSatisfaction
      ..businessService = businessService ?? this.businessService
      ..expectedStart = expectedStart ?? this.expectedStart
      ..uDepartureTimeSystem = uDepartureTimeSystem ?? this.uDepartureTimeSystem
      ..uParent = uParent ?? this.uParent
      ..openedAt = openedAt ?? this.openedAt
      ..uWorkStartedSystem = uWorkStartedSystem ?? this.uWorkStartedSystem
      ..workEnd = workEnd ?? this.workEnd
      ..workNotes = workNotes ?? this.workNotes
      ..uCasePriority = uCasePriority ?? this.uCasePriority
      ..assignmentGroup = assignmentGroup ?? this.assignmentGroup
      ..uRespondedTime = uRespondedTime ?? this.uRespondedTime
      ..description = description ?? this.description
      ..calendarDuration = calendarDuration ?? this.calendarDuration
      ..closeNotes = closeNotes ?? this.closeNotes
      ..sysId = sysId ?? this.sysId
      ..contactType = contactType ?? this.contactType
      ..urgency = urgency ?? this.urgency
      ..uPreferredScheduleByCustomer = uPreferredScheduleByCustomer ??
          this.uPreferredScheduleByCustomer
      ..company = company ?? this.company
      ..uInternalWatchlistForCcCaseTask = uInternalWatchlistForCcCaseTask ??
          this.uInternalWatchlistForCcCaseTask
      ..uTravelStartTimeSystem = uTravelStartTimeSystem ??
          this.uTravelStartTimeSystem
      ..activityDue = activityDue ?? this.activityDue
      ..consumer = consumer ?? this.consumer
      ..parentCase = parentCase ?? this.parentCase
      ..actionStatus = actionStatus ?? this.actionStatus
      ..uNextActionScheduledStart = uNextActionScheduledStart ??
          this.uNextActionScheduledStart
      ..comments = comments ?? this.comments
      ..uSalesforceRecordId = uSalesforceRecordId ?? this.uSalesforceRecordId
      ..uVendorWatchlistForCc = uVendorWatchlistForCc ??
          this.uVendorWatchlistForCc
      ..approval = approval ?? this.approval
      ..dueDate = dueDate ?? this.dueDate
      ..sysModCount = sysModCount ?? this.sysModCount
      ..uNextActionPersonEmail = uNextActionPersonEmail ??
          this.uNextActionPersonEmail
      ..sysTags = sysTags ?? this.sysTags
      ..uResolutionCode = uResolutionCode ?? this.uResolutionCode
      ..uWorkCompleted = uWorkCompleted ?? this.uWorkCompleted
      ..service = service ?? this.service
      ..uCaseServiceType = uCaseServiceType ?? this.uCaseServiceType
      ..location = location ?? this.location
      ..uCustomerWatchlistForCc = uCustomerWatchlistForCc ??
          this.uCustomerWatchlistForCc
      ..account = account ?? this.account
      ..uDepartureTime = uDepartureTime ?? this.uDepartureTime
      ..uEtaProvidedVendorToTig = uEtaProvidedVendorToTig ??
          this.uEtaProvidedVendorToTig;
  }
}

TaskDetailResultParent $TaskDetailResultParentFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultParent taskDetailResultParent = TaskDetailResultParent();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultParent.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultParent.value = value;
  }
  return taskDetailResultParent;
}

Map<String, dynamic> $TaskDetailResultParentToJson(
    TaskDetailResultParent entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultParentExtension on TaskDetailResultParent {
  TaskDetailResultParent copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultParent()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}

TaskDetailResultUCaseAccount $TaskDetailResultUCaseAccountFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultUCaseAccount taskDetailResultUCaseAccount = TaskDetailResultUCaseAccount();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultUCaseAccount.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultUCaseAccount.value = value;
  }
  return taskDetailResultUCaseAccount;
}

Map<String, dynamic> $TaskDetailResultUCaseAccountToJson(
    TaskDetailResultUCaseAccount entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultUCaseAccountExtension on TaskDetailResultUCaseAccount {
  TaskDetailResultUCaseAccount copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultUCaseAccount()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}

TaskDetailResultClosedBy $TaskDetailResultClosedByFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultClosedBy taskDetailResultClosedBy = TaskDetailResultClosedBy();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultClosedBy.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultClosedBy.value = value;
  }
  return taskDetailResultClosedBy;
}

Map<String, dynamic> $TaskDetailResultClosedByToJson(
    TaskDetailResultClosedBy entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultClosedByExtension on TaskDetailResultClosedBy {
  TaskDetailResultClosedBy copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultClosedBy()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}

TaskDetailResultAssignedTo $TaskDetailResultAssignedToFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultAssignedTo taskDetailResultAssignedTo = TaskDetailResultAssignedTo();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultAssignedTo.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultAssignedTo.value = value;
  }
  return taskDetailResultAssignedTo;
}

Map<String, dynamic> $TaskDetailResultAssignedToToJson(
    TaskDetailResultAssignedTo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultAssignedToExtension on TaskDetailResultAssignedTo {
  TaskDetailResultAssignedTo copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultAssignedTo()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}

TaskDetailResultOpenedBy $TaskDetailResultOpenedByFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultOpenedBy taskDetailResultOpenedBy = TaskDetailResultOpenedBy();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultOpenedBy.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultOpenedBy.value = value;
  }
  return taskDetailResultOpenedBy;
}

Map<String, dynamic> $TaskDetailResultOpenedByToJson(
    TaskDetailResultOpenedBy entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultOpenedByExtension on TaskDetailResultOpenedBy {
  TaskDetailResultOpenedBy copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultOpenedBy()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}

TaskDetailResultContact $TaskDetailResultContactFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultContact taskDetailResultContact = TaskDetailResultContact();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultContact.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultContact.value = value;
  }
  return taskDetailResultContact;
}

Map<String, dynamic> $TaskDetailResultContactToJson(
    TaskDetailResultContact entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultContactExtension on TaskDetailResultContact {
  TaskDetailResultContact copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultContact()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}

TaskDetailResultSysDomain $TaskDetailResultSysDomainFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultSysDomain taskDetailResultSysDomain = TaskDetailResultSysDomain();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultSysDomain.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultSysDomain.value = value;
  }
  return taskDetailResultSysDomain;
}

Map<String, dynamic> $TaskDetailResultSysDomainToJson(
    TaskDetailResultSysDomain entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultSysDomainExtension on TaskDetailResultSysDomain {
  TaskDetailResultSysDomain copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultSysDomain()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}

TaskDetailResultUParent $TaskDetailResultUParentFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultUParent taskDetailResultUParent = TaskDetailResultUParent();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultUParent.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultUParent.value = value;
  }
  return taskDetailResultUParent;
}

Map<String, dynamic> $TaskDetailResultUParentToJson(
    TaskDetailResultUParent entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultUParentExtension on TaskDetailResultUParent {
  TaskDetailResultUParent copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultUParent()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}

TaskDetailResultAssignmentGroup $TaskDetailResultAssignmentGroupFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultAssignmentGroup taskDetailResultAssignmentGroup = TaskDetailResultAssignmentGroup();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultAssignmentGroup.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultAssignmentGroup.value = value;
  }
  return taskDetailResultAssignmentGroup;
}

Map<String, dynamic> $TaskDetailResultAssignmentGroupToJson(
    TaskDetailResultAssignmentGroup entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultAssignmentGroupExtension on TaskDetailResultAssignmentGroup {
  TaskDetailResultAssignmentGroup copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultAssignmentGroup()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}

TaskDetailResultParentCase $TaskDetailResultParentCaseFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultParentCase taskDetailResultParentCase = TaskDetailResultParentCase();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultParentCase.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultParentCase.value = value;
  }
  return taskDetailResultParentCase;
}

Map<String, dynamic> $TaskDetailResultParentCaseToJson(
    TaskDetailResultParentCase entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultParentCaseExtension on TaskDetailResultParentCase {
  TaskDetailResultParentCase copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultParentCase()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}

TaskDetailResultAccount $TaskDetailResultAccountFromJson(
    Map<String, dynamic> json) {
  final TaskDetailResultAccount taskDetailResultAccount = TaskDetailResultAccount();
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    taskDetailResultAccount.link = link;
  }
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    taskDetailResultAccount.value = value;
  }
  return taskDetailResultAccount;
}

Map<String, dynamic> $TaskDetailResultAccountToJson(
    TaskDetailResultAccount entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['link'] = entity.link;
  data['value'] = entity.value;
  return data;
}

extension TaskDetailResultAccountExtension on TaskDetailResultAccount {
  TaskDetailResultAccount copyWith({
    String? link,
    String? value,
  }) {
    return TaskDetailResultAccount()
      ..link = link ?? this.link
      ..value = value ?? this.value;
  }
}