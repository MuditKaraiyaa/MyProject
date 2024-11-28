import 'dart:convert';

import 'package:xbridge/generated/json/base/json_field.dart';
import 'package:xbridge/generated/json/unassigned_task_entity.g.dart';

export 'package:xbridge/generated/json/unassigned_task_entity.g.dart';

@JsonSerializable()
class UnassignedTaskEntity {
  List<UnassignedTaskResult>? result;

  UnassignedTaskEntity();

  factory UnassignedTaskEntity.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskEntityFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResult {
  UnassignedTaskResultParent? parent;
  @JSONField(name: "u_eta_system_time")
  String? uEtaSystemTime;
  @JSONField(name: "watch_list")
  String? watchList;
  @JSONField(name: "upon_reject")
  String? uponReject;
  @JSONField(name: "sys_updated_on")
  String? sysUpdatedOn;
  @JSONField(name: "approval_history")
  String? approvalHistory;
  String? skills;
  @JSONField(name: "u_case_account")
  UnassignedTaskResultUCaseAccount? uCaseAccount;
  String? number;
  String? state;
  @JSONField(name: "sys_created_by")
  String? sysCreatedBy;
  String? knowledge;
  String? order;
  @JSONField(name: "cmdb_ci")
  String? cmdbCi;
  @JSONField(name: "delivery_plan")
  String? deliveryPlan;
  String? contract;
  String? impact;
  String? active;
  @JSONField(name: "work_notes_list")
  String? workNotesList;
  String? priority;
  @JSONField(name: "sys_domain_path")
  String? sysDomainPath;
  @JSONField(name: "u_vendor_watchlist")
  String? uVendorWatchlist;
  @JSONField(name: "u_vendor_comments")
  String? uVendorComments;
  @JSONField(name: "business_duration")
  String? businessDuration;
  @JSONField(name: "group_list")
  String? groupList;
  @JSONField(name: "u_total_time_worked")
  String? uTotalTimeWorked;
  @JSONField(name: "approval_set")
  String? approvalSet;
  @JSONField(name: "needs_attention")
  String? needsAttention;
  @JSONField(name: "universal_request")
  String? universalRequest;
  @JSONField(name: "short_description")
  String? shortDescription;
  @JSONField(name: "correlation_display")
  String? correlationDisplay;
  @JSONField(name: "delivery_task")
  String? deliveryTask;
  @JSONField(name: "work_start")
  String? workStart;
  @JSONField(name: "associated_table")
  String? associatedTable;
  @JSONField(name: "additional_assignee_list")
  String? additionalAssigneeList;
  @JSONField(name: "u_dispatch_ot_number")
  String? uDispatchOtNumber;
  @JSONField(name: "u_parent_case_type")
  String? uParentCaseType;
  @JSONField(name: "u_arrival_time_system")
  String? uArrivalTimeSystem;
  @JSONField(name: "u_total_overtime_worked")
  String? uTotalOvertimeWorked;
  @JSONField(name: "service_offering")
  String? serviceOffering;
  @JSONField(name: "sys_class_name")
  String? sysClassName;
  @JSONField(name: "closed_by")
  dynamic closedBy;
  @JSONField(name: "follow_up")
  String? followUp;
  @JSONField(name: "u_updates_from_vendor")
  String? uUpdatesFromVendor;
  @JSONField(name: "reassignment_count")
  String? reassignmentCount;
  @JSONField(name: "u_work_started")
  String? uWorkStarted;
  @JSONField(name: "assigned_to")
  UnassignedTaskResultAssignedTo? assignedTo;
  @JSONField(name: "u_mark_unread")
  String? uMarkUnread;
  @JSONField(name: "sla_due")
  String? slaDue;
  @JSONField(name: "u_sla_breached")
  dynamic uSlaBreached;
  @JSONField(name: "associated_record")
  String? associatedRecord;
  @JSONField(name: "comments_and_work_notes")
  String? commentsAndWorkNotes;
  @JSONField(name: "u_is_it_tig_served_site")
  String? uIsItTigServedSite;
  @JSONField(name: "u_arrival_time")
  String? uArrivalTime;
  @JSONField(name: "u_work_completed_system")
  String? uWorkCompletedSystem;
  String? escalation;
  @JSONField(name: "upon_approval")
  String? uponApproval;
  @JSONField(name: "correlation_id")
  String? correlationId;
  @JSONField(name: "visible_to_customer")
  String? visibleToCustomer;
  @JSONField(name: "made_sla")
  String? madeSla;
  @JSONField(name: "u_internal_watchlist_case_task")
  String? uInternalWatchlistCaseTask;
  @JSONField(name: "u_difference_departure_arrival_time")
  String? uDifferenceDepartureArrivalTime;
  @JSONField(name: "u_part_code")
  String? uPartCode;
  @JSONField(name: "u_check_calendar")
  String? uCheckCalendar;
  @JSONField(name: "u_preferred_schedule_by_customer_system")
  String? uPreferredScheduleByCustomerSystem;
  @JSONField(name: "u_internal_watchlist_for_cc")
  String? uInternalWatchlistForCc;
  @JSONField(name: "u_scheduled_data_by_vendor")
  String? uScheduledDataByVendor;
  @JSONField(name: "task_effective_number")
  String? taskEffectiveNumber;
  @JSONField(name: "u_travel_start_time")
  String? uTravelStartTime;
  @JSONField(name: "sys_updated_by")
  String? sysUpdatedBy;
  @JSONField(name: "u_resolution_notes")
  String? uResolutionNotes;
  @JSONField(name: "opened_by")
  UnassignedTaskResultOpenedBy? openedBy;
  @JSONField(name: "user_input")
  String? userInput;
  @JSONField(name: "sys_created_on")
  String? sysCreatedOn;
  UnassignedTaskResultContact? contact;
  @JSONField(name: "sys_domain")
  UnassignedTaskResultSysDomain? sysDomain;
  @JSONField(name: "u_return_request_type")
  dynamic uReturnRequestType;
  @JSONField(name: "route_reason")
  String? routeReason;
  @JSONField(name: "u_updates_from_rest_user")
  String? uUpdatesFromRestUser;
  @JSONField(name: "closed_at")
  String? closedAt;
  @JSONField(name: "u_customer_satisfaction")
  String? uCustomerSatisfaction;
  @JSONField(name: "business_service")
  String? businessService;
  @JSONField(name: "expected_start")
  String? expectedStart;
  @JSONField(name: "u_departure_time_system")
  String? uDepartureTimeSystem;
  @JSONField(name: "u_parent")
  UnassignedTaskResultUParent? uParent;
  @JSONField(name: "opened_at")
  String? openedAt;
  @JSONField(name: "u_work_started_system")
  String? uWorkStartedSystem;
  @JSONField(name: "work_end")
  String? workEnd;
  @JSONField(name: "work_notes")
  String? workNotes;
  @JSONField(name: "u_case_priority")
  String? uCasePriority;
  @JSONField(name: "assignment_group")
  UnassignedTaskResultAssignmentGroup? assignmentGroup;
  @JSONField(name: "u_responded_time")
  String? uRespondedTime;
  String? description;
  @JSONField(name: "calendar_duration")
  String? calendarDuration;
  @JSONField(name: "close_notes")
  String? closeNotes;
  @JSONField(name: "sys_id")
  String? sysId;
  @JSONField(name: "contact_type")
  dynamic contactType;
  String? urgency;
  @JSONField(name: "u_preferred_schedule_by_customer")
  String? uPreferredScheduleByCustomer;
  String? company;
  @JSONField(name: "u_internal_watchlist_for_cc_case_task")
  String? uInternalWatchlistForCcCaseTask;
  @JSONField(name: "u_travel_start_time_system")
  String? uTravelStartTimeSystem;
  @JSONField(name: "activity_due")
  String? activityDue;
  String? consumer;
  @JSONField(name: "parent_case")
  UnassignedTaskResultParentCase? parentCase;
  @JSONField(name: "action_status")
  String? actionStatus;
  @JSONField(name: "u_next_action_scheduled_start")
  String? uNextActionScheduledStart;
  String? comments;
  @JSONField(name: "u_salesforce_record_id")
  String? uSalesforceRecordId;
  @JSONField(name: "u_vendor_watchlist_for_cc")
  String? uVendorWatchlistForCc;
  String? approval;
  @JSONField(name: "due_date")
  String? dueDate;
  @JSONField(name: "sys_mod_count")
  String? sysModCount;
  @JSONField(name: "u_next_action_person_email")
  String? uNextActionPersonEmail;
  @JSONField(name: "sys_tags")
  String? sysTags;
  @JSONField(name: "u_resolution_code")
  String? uResolutionCode;
  @JSONField(name: "u_work_completed")
  String? uWorkCompleted;
  String? service;
  @JSONField(name: "u_case_service_type")
  String? uCaseServiceType;
  String? location;
  @JSONField(name: "u_customer_watchlist_for_cc")
  String? uCustomerWatchlistForCc;
  UnassignedTaskResultAccount? account;
  @JSONField(name: "u_departure_time")
  String? uDepartureTime;
  @JSONField(name: "u_eta_provided_vendor_to_tig")
  String? uEtaProvidedVendorToTig;
  @JSONField(name: "u_city")
  String? uCity;
  @JSONField(name: "u_country")
  String? uCountry;

  UnassignedTaskResult();

  factory UnassignedTaskResult.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskResultFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultParent {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultParent();

  factory UnassignedTaskResultParent.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskResultParentFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultParentToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultUCaseAccount {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultUCaseAccount();

  factory UnassignedTaskResultUCaseAccount.fromJson(
    Map<String, dynamic> json,
  ) =>
      $UnassignedTaskResultUCaseAccountFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultUCaseAccountToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultClosedBy {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultClosedBy();

  factory UnassignedTaskResultClosedBy.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskResultClosedByFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultClosedByToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultAssignedTo {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultAssignedTo();

  factory UnassignedTaskResultAssignedTo.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskResultAssignedToFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultAssignedToToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultOpenedBy {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultOpenedBy();

  factory UnassignedTaskResultOpenedBy.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskResultOpenedByFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultOpenedByToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultContact {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultContact();

  factory UnassignedTaskResultContact.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskResultContactFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultContactToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultSysDomain {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultSysDomain();

  factory UnassignedTaskResultSysDomain.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskResultSysDomainFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultSysDomainToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultUParent {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultUParent();

  factory UnassignedTaskResultUParent.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskResultUParentFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultUParentToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultAssignmentGroup {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultAssignmentGroup();

  factory UnassignedTaskResultAssignmentGroup.fromJson(
    Map<String, dynamic> json,
  ) =>
      $UnassignedTaskResultAssignmentGroupFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultAssignmentGroupToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultParentCase {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultParentCase();

  factory UnassignedTaskResultParentCase.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskResultParentCaseFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultParentCaseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UnassignedTaskResultAccount {
  @JSONField(name: "display_value")
  String? displayValue;
  String? link;

  UnassignedTaskResultAccount();

  factory UnassignedTaskResultAccount.fromJson(Map<String, dynamic> json) =>
      $UnassignedTaskResultAccountFromJson(json);

  Map<String, dynamic> toJson() => $UnassignedTaskResultAccountToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
