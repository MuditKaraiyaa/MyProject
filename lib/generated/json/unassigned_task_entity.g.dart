import 'package:xbridge/generated/json/base/json_convert_content.dart';
import 'package:xbridge/unassigned_visits/data/model/unassigned_task_entity.dart';

UnassignedTaskEntity $UnassignedTaskEntityFromJson(Map<String, dynamic> json) {
  final UnassignedTaskEntity unassignedTaskEntity = UnassignedTaskEntity();
  final List<UnassignedTaskResult>? result = (json['result'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<UnassignedTaskResult>(e) as UnassignedTaskResult)
      .toList();
  if (result != null) {
    unassignedTaskEntity.result = result;
  }
  return unassignedTaskEntity;
}

Map<String, dynamic> $UnassignedTaskEntityToJson(UnassignedTaskEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['result'] = entity.result?.map((v) => v.toJson()).toList();
  return data;
}

extension UnassignedTaskEntityExtension on UnassignedTaskEntity {
  UnassignedTaskEntity copyWith({
    List<UnassignedTaskResult>? result,
  }) {
    return UnassignedTaskEntity()
      ..result = result ?? this.result;
  }
}

UnassignedTaskResult $UnassignedTaskResultFromJson(Map<String, dynamic> json) {
  final UnassignedTaskResult unassignedTaskResult = UnassignedTaskResult();
  final UnassignedTaskResultParent? parent = jsonConvert.convert<
      UnassignedTaskResultParent>(json['parent']);
  if (parent != null) {
    unassignedTaskResult.parent = parent;
  }
  final String? uEtaSystemTime = jsonConvert.convert<String>(
      json['u_eta_system_time']);
  if (uEtaSystemTime != null) {
    unassignedTaskResult.uEtaSystemTime = uEtaSystemTime;
  }
  final String? watchList = jsonConvert.convert<String>(json['watch_list']);
  if (watchList != null) {
    unassignedTaskResult.watchList = watchList;
  }
  final String? uponReject = jsonConvert.convert<String>(json['upon_reject']);
  if (uponReject != null) {
    unassignedTaskResult.uponReject = uponReject;
  }
  final String? sysUpdatedOn = jsonConvert.convert<String>(
      json['sys_updated_on']);
  if (sysUpdatedOn != null) {
    unassignedTaskResult.sysUpdatedOn = sysUpdatedOn;
  }
  final String? approvalHistory = jsonConvert.convert<String>(
      json['approval_history']);
  if (approvalHistory != null) {
    unassignedTaskResult.approvalHistory = approvalHistory;
  }
  final String? skills = jsonConvert.convert<String>(json['skills']);
  if (skills != null) {
    unassignedTaskResult.skills = skills;
  }
  final UnassignedTaskResultUCaseAccount? uCaseAccount = jsonConvert.convert<
      UnassignedTaskResultUCaseAccount>(json['u_case_account']);
  if (uCaseAccount != null) {
    unassignedTaskResult.uCaseAccount = uCaseAccount;
  }
  final String? number = jsonConvert.convert<String>(json['number']);
  if (number != null) {
    unassignedTaskResult.number = number;
  }
  final String? state = jsonConvert.convert<String>(json['state']);
  if (state != null) {
    unassignedTaskResult.state = state;
  }
  final String? sysCreatedBy = jsonConvert.convert<String>(
      json['sys_created_by']);
  if (sysCreatedBy != null) {
    unassignedTaskResult.sysCreatedBy = sysCreatedBy;
  }
  final String? knowledge = jsonConvert.convert<String>(json['knowledge']);
  if (knowledge != null) {
    unassignedTaskResult.knowledge = knowledge;
  }
  final String? order = jsonConvert.convert<String>(json['order']);
  if (order != null) {
    unassignedTaskResult.order = order;
  }
  final String? cmdbCi = jsonConvert.convert<String>(json['cmdb_ci']);
  if (cmdbCi != null) {
    unassignedTaskResult.cmdbCi = cmdbCi;
  }
  final String? deliveryPlan = jsonConvert.convert<String>(
      json['delivery_plan']);
  if (deliveryPlan != null) {
    unassignedTaskResult.deliveryPlan = deliveryPlan;
  }
  final String? contract = jsonConvert.convert<String>(json['contract']);
  if (contract != null) {
    unassignedTaskResult.contract = contract;
  }
  final String? impact = jsonConvert.convert<String>(json['impact']);
  if (impact != null) {
    unassignedTaskResult.impact = impact;
  }
  final String? active = jsonConvert.convert<String>(json['active']);
  if (active != null) {
    unassignedTaskResult.active = active;
  }
  final String? workNotesList = jsonConvert.convert<String>(
      json['work_notes_list']);
  if (workNotesList != null) {
    unassignedTaskResult.workNotesList = workNotesList;
  }
  final String? priority = jsonConvert.convert<String>(json['priority']);
  if (priority != null) {
    unassignedTaskResult.priority = priority;
  }
  final String? sysDomainPath = jsonConvert.convert<String>(
      json['sys_domain_path']);
  if (sysDomainPath != null) {
    unassignedTaskResult.sysDomainPath = sysDomainPath;
  }
  final String? uVendorWatchlist = jsonConvert.convert<String>(
      json['u_vendor_watchlist']);
  if (uVendorWatchlist != null) {
    unassignedTaskResult.uVendorWatchlist = uVendorWatchlist;
  }
  final String? uVendorComments = jsonConvert.convert<String>(
      json['u_vendor_comments']);
  if (uVendorComments != null) {
    unassignedTaskResult.uVendorComments = uVendorComments;
  }
  final String? businessDuration = jsonConvert.convert<String>(
      json['business_duration']);
  if (businessDuration != null) {
    unassignedTaskResult.businessDuration = businessDuration;
  }
  final String? groupList = jsonConvert.convert<String>(json['group_list']);
  if (groupList != null) {
    unassignedTaskResult.groupList = groupList;
  }
  final String? uTotalTimeWorked = jsonConvert.convert<String>(
      json['u_total_time_worked']);
  if (uTotalTimeWorked != null) {
    unassignedTaskResult.uTotalTimeWorked = uTotalTimeWorked;
  }
  final String? approvalSet = jsonConvert.convert<String>(json['approval_set']);
  if (approvalSet != null) {
    unassignedTaskResult.approvalSet = approvalSet;
  }
  final String? needsAttention = jsonConvert.convert<String>(
      json['needs_attention']);
  if (needsAttention != null) {
    unassignedTaskResult.needsAttention = needsAttention;
  }
  final String? universalRequest = jsonConvert.convert<String>(
      json['universal_request']);
  if (universalRequest != null) {
    unassignedTaskResult.universalRequest = universalRequest;
  }
  final String? shortDescription = jsonConvert.convert<String>(
      json['short_description']);
  if (shortDescription != null) {
    unassignedTaskResult.shortDescription = shortDescription;
  }
  final String? correlationDisplay = jsonConvert.convert<String>(
      json['correlation_display']);
  if (correlationDisplay != null) {
    unassignedTaskResult.correlationDisplay = correlationDisplay;
  }
  final String? deliveryTask = jsonConvert.convert<String>(
      json['delivery_task']);
  if (deliveryTask != null) {
    unassignedTaskResult.deliveryTask = deliveryTask;
  }
  final String? workStart = jsonConvert.convert<String>(json['work_start']);
  if (workStart != null) {
    unassignedTaskResult.workStart = workStart;
  }
  final String? associatedTable = jsonConvert.convert<String>(
      json['associated_table']);
  if (associatedTable != null) {
    unassignedTaskResult.associatedTable = associatedTable;
  }
  final String? additionalAssigneeList = jsonConvert.convert<String>(
      json['additional_assignee_list']);
  if (additionalAssigneeList != null) {
    unassignedTaskResult.additionalAssigneeList = additionalAssigneeList;
  }
  final String? uDispatchOtNumber = jsonConvert.convert<String>(
      json['u_dispatch_ot_number']);
  if (uDispatchOtNumber != null) {
    unassignedTaskResult.uDispatchOtNumber = uDispatchOtNumber;
  }
  final String? uParentCaseType = jsonConvert.convert<String>(
      json['u_parent_case_type']);
  if (uParentCaseType != null) {
    unassignedTaskResult.uParentCaseType = uParentCaseType;
  }
  final String? uArrivalTimeSystem = jsonConvert.convert<String>(
      json['u_arrival_time_system']);
  if (uArrivalTimeSystem != null) {
    unassignedTaskResult.uArrivalTimeSystem = uArrivalTimeSystem;
  }
  final String? uTotalOvertimeWorked = jsonConvert.convert<String>(
      json['u_total_overtime_worked']);
  if (uTotalOvertimeWorked != null) {
    unassignedTaskResult.uTotalOvertimeWorked = uTotalOvertimeWorked;
  }
  final String? serviceOffering = jsonConvert.convert<String>(
      json['service_offering']);
  if (serviceOffering != null) {
    unassignedTaskResult.serviceOffering = serviceOffering;
  }
  final String? sysClassName = jsonConvert.convert<String>(
      json['sys_class_name']);
  if (sysClassName != null) {
    unassignedTaskResult.sysClassName = sysClassName;
  }
  final UnassignedTaskResultClosedBy? closedBy = jsonConvert.convert<
      UnassignedTaskResultClosedBy>(json['closed_by']);
  if (closedBy != null) {
    unassignedTaskResult.closedBy = closedBy;
  }
  final String? followUp = jsonConvert.convert<String>(json['follow_up']);
  if (followUp != null) {
    unassignedTaskResult.followUp = followUp;
  }
  final String? uUpdatesFromVendor = jsonConvert.convert<String>(
      json['u_updates_from_vendor']);
  if (uUpdatesFromVendor != null) {
    unassignedTaskResult.uUpdatesFromVendor = uUpdatesFromVendor;
  }
  final String? reassignmentCount = jsonConvert.convert<String>(
      json['reassignment_count']);
  if (reassignmentCount != null) {
    unassignedTaskResult.reassignmentCount = reassignmentCount;
  }
  final String? uWorkStarted = jsonConvert.convert<String>(
      json['u_work_started']);
  if (uWorkStarted != null) {
    unassignedTaskResult.uWorkStarted = uWorkStarted;
  }
  final UnassignedTaskResultAssignedTo? assignedTo = jsonConvert.convert<
      UnassignedTaskResultAssignedTo>(json['assigned_to']);
  if (assignedTo != null) {
    unassignedTaskResult.assignedTo = assignedTo;
  }
  final String? uMarkUnread = jsonConvert.convert<String>(
      json['u_mark_unread']);
  if (uMarkUnread != null) {
    unassignedTaskResult.uMarkUnread = uMarkUnread;
  }
  final String? slaDue = jsonConvert.convert<String>(json['sla_due']);
  if (slaDue != null) {
    unassignedTaskResult.slaDue = slaDue;
  }
  final dynamic uSlaBreached = json['u_sla_breached'];
  if (uSlaBreached != null) {
    unassignedTaskResult.uSlaBreached = uSlaBreached;
  }
  final String? associatedRecord = jsonConvert.convert<String>(
      json['associated_record']);
  if (associatedRecord != null) {
    unassignedTaskResult.associatedRecord = associatedRecord;
  }
  final String? commentsAndWorkNotes = jsonConvert.convert<String>(
      json['comments_and_work_notes']);
  if (commentsAndWorkNotes != null) {
    unassignedTaskResult.commentsAndWorkNotes = commentsAndWorkNotes;
  }
  final String? uIsItTigServedSite = jsonConvert.convert<String>(
      json['u_is_it_tig_served_site']);
  if (uIsItTigServedSite != null) {
    unassignedTaskResult.uIsItTigServedSite = uIsItTigServedSite;
  }
  final String? uArrivalTime = jsonConvert.convert<String>(
      json['u_arrival_time']);
  if (uArrivalTime != null) {
    unassignedTaskResult.uArrivalTime = uArrivalTime;
  }
  final String? uWorkCompletedSystem = jsonConvert.convert<String>(
      json['u_work_completed_system']);
  if (uWorkCompletedSystem != null) {
    unassignedTaskResult.uWorkCompletedSystem = uWorkCompletedSystem;
  }
  final String? escalation = jsonConvert.convert<String>(json['escalation']);
  if (escalation != null) {
    unassignedTaskResult.escalation = escalation;
  }
  final String? uponApproval = jsonConvert.convert<String>(
      json['upon_approval']);
  if (uponApproval != null) {
    unassignedTaskResult.uponApproval = uponApproval;
  }
  final String? correlationId = jsonConvert.convert<String>(
      json['correlation_id']);
  if (correlationId != null) {
    unassignedTaskResult.correlationId = correlationId;
  }
  final String? visibleToCustomer = jsonConvert.convert<String>(
      json['visible_to_customer']);
  if (visibleToCustomer != null) {
    unassignedTaskResult.visibleToCustomer = visibleToCustomer;
  }
  final String? madeSla = jsonConvert.convert<String>(json['made_sla']);
  if (madeSla != null) {
    unassignedTaskResult.madeSla = madeSla;
  }
  final String? uInternalWatchlistCaseTask = jsonConvert.convert<String>(
      json['u_internal_watchlist_case_task']);
  if (uInternalWatchlistCaseTask != null) {
    unassignedTaskResult.uInternalWatchlistCaseTask =
        uInternalWatchlistCaseTask;
  }
  final String? uDifferenceDepartureArrivalTime = jsonConvert.convert<String>(
      json['u_difference_departure_arrival_time']);
  if (uDifferenceDepartureArrivalTime != null) {
    unassignedTaskResult.uDifferenceDepartureArrivalTime =
        uDifferenceDepartureArrivalTime;
  }
  final String? uPartCode = jsonConvert.convert<String>(json['u_part_code']);
  if (uPartCode != null) {
    unassignedTaskResult.uPartCode = uPartCode;
  }
  final String? uCheckCalendar = jsonConvert.convert<String>(
      json['u_check_calendar']);
  if (uCheckCalendar != null) {
    unassignedTaskResult.uCheckCalendar = uCheckCalendar;
  }
  final String? uPreferredScheduleByCustomerSystem = jsonConvert.convert<
      String>(json['u_preferred_schedule_by_customer_system']);
  if (uPreferredScheduleByCustomerSystem != null) {
    unassignedTaskResult.uPreferredScheduleByCustomerSystem =
        uPreferredScheduleByCustomerSystem;
  }
  final String? uInternalWatchlistForCc = jsonConvert.convert<String>(
      json['u_internal_watchlist_for_cc']);
  if (uInternalWatchlistForCc != null) {
    unassignedTaskResult.uInternalWatchlistForCc = uInternalWatchlistForCc;
  }
  final String? uScheduledDataByVendor = jsonConvert.convert<String>(
      json['u_scheduled_data_by_vendor']);
  if (uScheduledDataByVendor != null) {
    unassignedTaskResult.uScheduledDataByVendor = uScheduledDataByVendor;
  }
  final String? taskEffectiveNumber = jsonConvert.convert<String>(
      json['task_effective_number']);
  if (taskEffectiveNumber != null) {
    unassignedTaskResult.taskEffectiveNumber = taskEffectiveNumber;
  }
  final String? uTravelStartTime = jsonConvert.convert<String>(
      json['u_travel_start_time']);
  if (uTravelStartTime != null) {
    unassignedTaskResult.uTravelStartTime = uTravelStartTime;
  }
  final String? sysUpdatedBy = jsonConvert.convert<String>(
      json['sys_updated_by']);
  if (sysUpdatedBy != null) {
    unassignedTaskResult.sysUpdatedBy = sysUpdatedBy;
  }
  final String? uResolutionNotes = jsonConvert.convert<String>(
      json['u_resolution_notes']);
  if (uResolutionNotes != null) {
    unassignedTaskResult.uResolutionNotes = uResolutionNotes;
  }
  final UnassignedTaskResultOpenedBy? openedBy = jsonConvert.convert<
      UnassignedTaskResultOpenedBy>(json['opened_by']);
  if (openedBy != null) {
    unassignedTaskResult.openedBy = openedBy;
  }
  final String? userInput = jsonConvert.convert<String>(json['user_input']);
  if (userInput != null) {
    unassignedTaskResult.userInput = userInput;
  }
  final String? sysCreatedOn = jsonConvert.convert<String>(
      json['sys_created_on']);
  if (sysCreatedOn != null) {
    unassignedTaskResult.sysCreatedOn = sysCreatedOn;
  }
  final UnassignedTaskResultContact? contact = jsonConvert.convert<
      UnassignedTaskResultContact>(json['contact']);
  if (contact != null) {
    unassignedTaskResult.contact = contact;
  }
  final UnassignedTaskResultSysDomain? sysDomain = jsonConvert.convert<
      UnassignedTaskResultSysDomain>(json['sys_domain']);
  if (sysDomain != null) {
    unassignedTaskResult.sysDomain = sysDomain;
  }
  final dynamic uReturnRequestType = json['u_return_request_type'];
  if (uReturnRequestType != null) {
    unassignedTaskResult.uReturnRequestType = uReturnRequestType;
  }
  final String? routeReason = jsonConvert.convert<String>(json['route_reason']);
  if (routeReason != null) {
    unassignedTaskResult.routeReason = routeReason;
  }
  final String? uUpdatesFromRestUser = jsonConvert.convert<String>(
      json['u_updates_from_rest_user']);
  if (uUpdatesFromRestUser != null) {
    unassignedTaskResult.uUpdatesFromRestUser = uUpdatesFromRestUser;
  }
  final String? closedAt = jsonConvert.convert<String>(json['closed_at']);
  if (closedAt != null) {
    unassignedTaskResult.closedAt = closedAt;
  }
  final String? uCustomerSatisfaction = jsonConvert.convert<String>(
      json['u_customer_satisfaction']);
  if (uCustomerSatisfaction != null) {
    unassignedTaskResult.uCustomerSatisfaction = uCustomerSatisfaction;
  }
  final String? businessService = jsonConvert.convert<String>(
      json['business_service']);
  if (businessService != null) {
    unassignedTaskResult.businessService = businessService;
  }
  final String? expectedStart = jsonConvert.convert<String>(
      json['expected_start']);
  if (expectedStart != null) {
    unassignedTaskResult.expectedStart = expectedStart;
  }
  final String? uDepartureTimeSystem = jsonConvert.convert<String>(
      json['u_departure_time_system']);
  if (uDepartureTimeSystem != null) {
    unassignedTaskResult.uDepartureTimeSystem = uDepartureTimeSystem;
  }
  final UnassignedTaskResultUParent? uParent = jsonConvert.convert<
      UnassignedTaskResultUParent>(json['u_parent']);
  if (uParent != null) {
    unassignedTaskResult.uParent = uParent;
  }
  final String? openedAt = jsonConvert.convert<String>(json['opened_at']);
  if (openedAt != null) {
    unassignedTaskResult.openedAt = openedAt;
  }
  final String? uWorkStartedSystem = jsonConvert.convert<String>(
      json['u_work_started_system']);
  if (uWorkStartedSystem != null) {
    unassignedTaskResult.uWorkStartedSystem = uWorkStartedSystem;
  }
  final String? workEnd = jsonConvert.convert<String>(json['work_end']);
  if (workEnd != null) {
    unassignedTaskResult.workEnd = workEnd;
  }
  final String? workNotes = jsonConvert.convert<String>(json['work_notes']);
  if (workNotes != null) {
    unassignedTaskResult.workNotes = workNotes;
  }
  final String? uCasePriority = jsonConvert.convert<String>(
      json['u_case_priority']);
  if (uCasePriority != null) {
    unassignedTaskResult.uCasePriority = uCasePriority;
  }
  final UnassignedTaskResultAssignmentGroup? assignmentGroup = jsonConvert
      .convert<UnassignedTaskResultAssignmentGroup>(json['assignment_group']);
  if (assignmentGroup != null) {
    unassignedTaskResult.assignmentGroup = assignmentGroup;
  }
  final String? uRespondedTime = jsonConvert.convert<String>(
      json['u_responded_time']);
  if (uRespondedTime != null) {
    unassignedTaskResult.uRespondedTime = uRespondedTime;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    unassignedTaskResult.description = description;
  }
  final String? calendarDuration = jsonConvert.convert<String>(
      json['calendar_duration']);
  if (calendarDuration != null) {
    unassignedTaskResult.calendarDuration = calendarDuration;
  }
  final String? closeNotes = jsonConvert.convert<String>(json['close_notes']);
  if (closeNotes != null) {
    unassignedTaskResult.closeNotes = closeNotes;
  }
  final String? sysId = jsonConvert.convert<String>(json['sys_id']);
  if (sysId != null) {
    unassignedTaskResult.sysId = sysId;
  }
  final dynamic contactType = json['contact_type'];
  if (contactType != null) {
    unassignedTaskResult.contactType = contactType;
  }
  final String? urgency = jsonConvert.convert<String>(json['urgency']);
  if (urgency != null) {
    unassignedTaskResult.urgency = urgency;
  }
  final String? uPreferredScheduleByCustomer = jsonConvert.convert<String>(
      json['u_preferred_schedule_by_customer']);
  if (uPreferredScheduleByCustomer != null) {
    unassignedTaskResult.uPreferredScheduleByCustomer =
        uPreferredScheduleByCustomer;
  }
  final String? company = jsonConvert.convert<String>(json['company']);
  if (company != null) {
    unassignedTaskResult.company = company;
  }
  final String? uInternalWatchlistForCcCaseTask = jsonConvert.convert<String>(
      json['u_internal_watchlist_for_cc_case_task']);
  if (uInternalWatchlistForCcCaseTask != null) {
    unassignedTaskResult.uInternalWatchlistForCcCaseTask =
        uInternalWatchlistForCcCaseTask;
  }
  final String? uTravelStartTimeSystem = jsonConvert.convert<String>(
      json['u_travel_start_time_system']);
  if (uTravelStartTimeSystem != null) {
    unassignedTaskResult.uTravelStartTimeSystem = uTravelStartTimeSystem;
  }
  final String? activityDue = jsonConvert.convert<String>(json['activity_due']);
  if (activityDue != null) {
    unassignedTaskResult.activityDue = activityDue;
  }
  final String? consumer = jsonConvert.convert<String>(json['consumer']);
  if (consumer != null) {
    unassignedTaskResult.consumer = consumer;
  }
  final UnassignedTaskResultParentCase? parentCase = jsonConvert.convert<
      UnassignedTaskResultParentCase>(json['parent_case']);
  if (parentCase != null) {
    unassignedTaskResult.parentCase = parentCase;
  }
  final String? actionStatus = jsonConvert.convert<String>(
      json['action_status']);
  if (actionStatus != null) {
    unassignedTaskResult.actionStatus = actionStatus;
  }
  final String? uNextActionScheduledStart = jsonConvert.convert<String>(
      json['u_next_action_scheduled_start']);
  if (uNextActionScheduledStart != null) {
    unassignedTaskResult.uNextActionScheduledStart = uNextActionScheduledStart;
  }
  final String? comments = jsonConvert.convert<String>(json['comments']);
  if (comments != null) {
    unassignedTaskResult.comments = comments;
  }
  final String? uSalesforceRecordId = jsonConvert.convert<String>(
      json['u_salesforce_record_id']);
  if (uSalesforceRecordId != null) {
    unassignedTaskResult.uSalesforceRecordId = uSalesforceRecordId;
  }
  final String? uVendorWatchlistForCc = jsonConvert.convert<String>(
      json['u_vendor_watchlist_for_cc']);
  if (uVendorWatchlistForCc != null) {
    unassignedTaskResult.uVendorWatchlistForCc = uVendorWatchlistForCc;
  }
  final String? approval = jsonConvert.convert<String>(json['approval']);
  if (approval != null) {
    unassignedTaskResult.approval = approval;
  }
  final String? dueDate = jsonConvert.convert<String>(json['due_date']);
  if (dueDate != null) {
    unassignedTaskResult.dueDate = dueDate;
  }
  final String? sysModCount = jsonConvert.convert<String>(
      json['sys_mod_count']);
  if (sysModCount != null) {
    unassignedTaskResult.sysModCount = sysModCount;
  }
  final String? uNextActionPersonEmail = jsonConvert.convert<String>(
      json['u_next_action_person_email']);
  if (uNextActionPersonEmail != null) {
    unassignedTaskResult.uNextActionPersonEmail = uNextActionPersonEmail;
  }
  final String? sysTags = jsonConvert.convert<String>(json['sys_tags']);
  if (sysTags != null) {
    unassignedTaskResult.sysTags = sysTags;
  }
  final String? uResolutionCode = jsonConvert.convert<String>(
      json['u_resolution_code']);
  if (uResolutionCode != null) {
    unassignedTaskResult.uResolutionCode = uResolutionCode;
  }
  final String? uWorkCompleted = jsonConvert.convert<String>(
      json['u_work_completed']);
  if (uWorkCompleted != null) {
    unassignedTaskResult.uWorkCompleted = uWorkCompleted;
  }
  final String? service = jsonConvert.convert<String>(json['service']);
  if (service != null) {
    unassignedTaskResult.service = service;
  }
  final String? uCaseServiceType = jsonConvert.convert<String>(
      json['u_case_service_type']);
  if (uCaseServiceType != null) {
    unassignedTaskResult.uCaseServiceType = uCaseServiceType;
  }
  final String? location = jsonConvert.convert<String>(json['location']);
  if (location != null) {
    unassignedTaskResult.location = location;
  }
  final String? uCustomerWatchlistForCc = jsonConvert.convert<String>(
      json['u_customer_watchlist_for_cc']);
  if (uCustomerWatchlistForCc != null) {
    unassignedTaskResult.uCustomerWatchlistForCc = uCustomerWatchlistForCc;
  }
  final UnassignedTaskResultAccount? account = jsonConvert.convert<
      UnassignedTaskResultAccount>(json['account']);
  if (account != null) {
    unassignedTaskResult.account = account;
  }
  final String? uDepartureTime = jsonConvert.convert<String>(
      json['u_departure_time']);
  if (uDepartureTime != null) {
    unassignedTaskResult.uDepartureTime = uDepartureTime;
  }
  final String? uEtaProvidedVendorToTig = jsonConvert.convert<String>(
      json['u_eta_provided_vendor_to_tig']);
  if (uEtaProvidedVendorToTig != null) {
    unassignedTaskResult.uEtaProvidedVendorToTig = uEtaProvidedVendorToTig;
  }
  final String? uCity = jsonConvert.convert<String>(json['u_city']);
  if (uCity != null) {
    unassignedTaskResult.uCity = uCity;
  }
  final String? uCountry = jsonConvert.convert<String>(json['u_country']);
  if (uCountry != null) {
    unassignedTaskResult.uCountry = uCountry;
  }
  return unassignedTaskResult;
}

Map<String, dynamic> $UnassignedTaskResultToJson(UnassignedTaskResult entity) {
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
  data['u_city'] = entity.uCity;
  data['u_country'] = entity.uCountry;
  return data;
}

extension UnassignedTaskResultExtension on UnassignedTaskResult {
  UnassignedTaskResult copyWith({
    UnassignedTaskResultParent? parent,
    String? uEtaSystemTime,
    String? watchList,
    String? uponReject,
    String? sysUpdatedOn,
    String? approvalHistory,
    String? skills,
    UnassignedTaskResultUCaseAccount? uCaseAccount,
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
    UnassignedTaskResultClosedBy? closedBy,
    String? followUp,
    String? uUpdatesFromVendor,
    String? reassignmentCount,
    String? uWorkStarted,
    UnassignedTaskResultAssignedTo? assignedTo,
    String? uMarkUnread,
    String? slaDue,
    dynamic uSlaBreached,
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
    UnassignedTaskResultOpenedBy? openedBy,
    String? userInput,
    String? sysCreatedOn,
    UnassignedTaskResultContact? contact,
    UnassignedTaskResultSysDomain? sysDomain,
    dynamic uReturnRequestType,
    String? routeReason,
    String? uUpdatesFromRestUser,
    String? closedAt,
    String? uCustomerSatisfaction,
    String? businessService,
    String? expectedStart,
    String? uDepartureTimeSystem,
    UnassignedTaskResultUParent? uParent,
    String? openedAt,
    String? uWorkStartedSystem,
    String? workEnd,
    String? workNotes,
    String? uCasePriority,
    UnassignedTaskResultAssignmentGroup? assignmentGroup,
    String? uRespondedTime,
    String? description,
    String? calendarDuration,
    String? closeNotes,
    String? sysId,
    dynamic contactType,
    String? urgency,
    String? uPreferredScheduleByCustomer,
    String? company,
    String? uInternalWatchlistForCcCaseTask,
    String? uTravelStartTimeSystem,
    String? activityDue,
    String? consumer,
    UnassignedTaskResultParentCase? parentCase,
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
    UnassignedTaskResultAccount? account,
    String? uDepartureTime,
    String? uEtaProvidedVendorToTig,
    String? uCity,
    String? uCountry,
  }) {
    return UnassignedTaskResult()
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
          this.uEtaProvidedVendorToTig
      ..uCity = uCity ?? this.uCity
      ..uCountry = uCountry ?? this.uCountry;
  }
}

UnassignedTaskResultParent $UnassignedTaskResultParentFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultParent unassignedTaskResultParent = UnassignedTaskResultParent();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultParent.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultParent.link = link;
  }
  return unassignedTaskResultParent;
}

Map<String, dynamic> $UnassignedTaskResultParentToJson(
    UnassignedTaskResultParent entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultParentExtension on UnassignedTaskResultParent {
  UnassignedTaskResultParent copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultParent()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}

UnassignedTaskResultUCaseAccount $UnassignedTaskResultUCaseAccountFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultUCaseAccount unassignedTaskResultUCaseAccount = UnassignedTaskResultUCaseAccount();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultUCaseAccount.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultUCaseAccount.link = link;
  }
  return unassignedTaskResultUCaseAccount;
}

Map<String, dynamic> $UnassignedTaskResultUCaseAccountToJson(
    UnassignedTaskResultUCaseAccount entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultUCaseAccountExtension on UnassignedTaskResultUCaseAccount {
  UnassignedTaskResultUCaseAccount copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultUCaseAccount()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}

UnassignedTaskResultClosedBy $UnassignedTaskResultClosedByFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultClosedBy unassignedTaskResultClosedBy = UnassignedTaskResultClosedBy();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultClosedBy.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultClosedBy.link = link;
  }
  return unassignedTaskResultClosedBy;
}

Map<String, dynamic> $UnassignedTaskResultClosedByToJson(
    UnassignedTaskResultClosedBy entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultClosedByExtension on UnassignedTaskResultClosedBy {
  UnassignedTaskResultClosedBy copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultClosedBy()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}

UnassignedTaskResultAssignedTo $UnassignedTaskResultAssignedToFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultAssignedTo unassignedTaskResultAssignedTo = UnassignedTaskResultAssignedTo();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultAssignedTo.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultAssignedTo.link = link;
  }
  return unassignedTaskResultAssignedTo;
}

Map<String, dynamic> $UnassignedTaskResultAssignedToToJson(
    UnassignedTaskResultAssignedTo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultAssignedToExtension on UnassignedTaskResultAssignedTo {
  UnassignedTaskResultAssignedTo copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultAssignedTo()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}

UnassignedTaskResultOpenedBy $UnassignedTaskResultOpenedByFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultOpenedBy unassignedTaskResultOpenedBy = UnassignedTaskResultOpenedBy();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultOpenedBy.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultOpenedBy.link = link;
  }
  return unassignedTaskResultOpenedBy;
}

Map<String, dynamic> $UnassignedTaskResultOpenedByToJson(
    UnassignedTaskResultOpenedBy entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultOpenedByExtension on UnassignedTaskResultOpenedBy {
  UnassignedTaskResultOpenedBy copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultOpenedBy()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}

UnassignedTaskResultContact $UnassignedTaskResultContactFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultContact unassignedTaskResultContact = UnassignedTaskResultContact();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultContact.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultContact.link = link;
  }
  return unassignedTaskResultContact;
}

Map<String, dynamic> $UnassignedTaskResultContactToJson(
    UnassignedTaskResultContact entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultContactExtension on UnassignedTaskResultContact {
  UnassignedTaskResultContact copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultContact()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}

UnassignedTaskResultSysDomain $UnassignedTaskResultSysDomainFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultSysDomain unassignedTaskResultSysDomain = UnassignedTaskResultSysDomain();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultSysDomain.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultSysDomain.link = link;
  }
  return unassignedTaskResultSysDomain;
}

Map<String, dynamic> $UnassignedTaskResultSysDomainToJson(
    UnassignedTaskResultSysDomain entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultSysDomainExtension on UnassignedTaskResultSysDomain {
  UnassignedTaskResultSysDomain copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultSysDomain()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}

UnassignedTaskResultUParent $UnassignedTaskResultUParentFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultUParent unassignedTaskResultUParent = UnassignedTaskResultUParent();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultUParent.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultUParent.link = link;
  }
  return unassignedTaskResultUParent;
}

Map<String, dynamic> $UnassignedTaskResultUParentToJson(
    UnassignedTaskResultUParent entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultUParentExtension on UnassignedTaskResultUParent {
  UnassignedTaskResultUParent copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultUParent()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}

UnassignedTaskResultAssignmentGroup $UnassignedTaskResultAssignmentGroupFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultAssignmentGroup unassignedTaskResultAssignmentGroup = UnassignedTaskResultAssignmentGroup();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultAssignmentGroup.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultAssignmentGroup.link = link;
  }
  return unassignedTaskResultAssignmentGroup;
}

Map<String, dynamic> $UnassignedTaskResultAssignmentGroupToJson(
    UnassignedTaskResultAssignmentGroup entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultAssignmentGroupExtension on UnassignedTaskResultAssignmentGroup {
  UnassignedTaskResultAssignmentGroup copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultAssignmentGroup()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}

UnassignedTaskResultParentCase $UnassignedTaskResultParentCaseFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultParentCase unassignedTaskResultParentCase = UnassignedTaskResultParentCase();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultParentCase.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultParentCase.link = link;
  }
  return unassignedTaskResultParentCase;
}

Map<String, dynamic> $UnassignedTaskResultParentCaseToJson(
    UnassignedTaskResultParentCase entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultParentCaseExtension on UnassignedTaskResultParentCase {
  UnassignedTaskResultParentCase copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultParentCase()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}

UnassignedTaskResultAccount $UnassignedTaskResultAccountFromJson(
    Map<String, dynamic> json) {
  final UnassignedTaskResultAccount unassignedTaskResultAccount = UnassignedTaskResultAccount();
  final String? displayValue = jsonConvert.convert<String>(
      json['display_value']);
  if (displayValue != null) {
    unassignedTaskResultAccount.displayValue = displayValue;
  }
  final String? link = jsonConvert.convert<String>(json['link']);
  if (link != null) {
    unassignedTaskResultAccount.link = link;
  }
  return unassignedTaskResultAccount;
}

Map<String, dynamic> $UnassignedTaskResultAccountToJson(
    UnassignedTaskResultAccount entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['display_value'] = entity.displayValue;
  data['link'] = entity.link;
  return data;
}

extension UnassignedTaskResultAccountExtension on UnassignedTaskResultAccount {
  UnassignedTaskResultAccount copyWith({
    String? displayValue,
    String? link,
  }) {
    return UnassignedTaskResultAccount()
      ..displayValue = displayValue ?? this.displayValue
      ..link = link ?? this.link;
  }
}