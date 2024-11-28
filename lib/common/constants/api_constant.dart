import 'globals.dart';

class APIConstant {
  // Base URL for API endpoints
  static String BASE_URL = 'https://totalitglobalitsmdev.service-now.com/';

  // API endpoints
  static String API_Login = "api/titn/verifyuserlogin/verifyUsers?";
  static String API_Task_Details = "api/now/table/sn_customerservice_task/";
  static String taskList =
      'api/now/table/sn_customerservice_task?sysparm_query=assigned_to.user_name=fsmuat.fieldengineer^state=1&sysparm_display_value=true';
  static String API_Users =
      "api/now/table/sys_user_grmember?sysparm_query=user.u_type_of_user=Field Engineer^group.manager.user_name=xbridge.vendormanager&sysparm_display_value=true";
  static String API_Auth_Token = "oauth_token.do";
  static String myTeam =
      'api/now/table/sys_user_grmember?sysparm_query=user.u_type_of_user=Field Engineer^ORDERBYuser^group.name=$vendorName&sysparm_display_value=true';
  static String userDetail = 'api/now/table/sys_user?sysparm_query=sys_id%3D';
  static String taskListManager =
      'api/now/table/sn_customerservice_task?sysparm_query=assignment_group.name=Xbridge Vendor^assigned_toISEMPTY^stateNOT IN10,3,11&sysparm_display_value=true';
  static String taskByStatusManager =
      'api/now/table/sn_customerservice_task?sysparm_display_value=true&sysparm_query=assignment_group.manager.user_name=$userName^ORDERBYDESCsys_created_on^ORDERBYu_preferred_schedule_by_customer^state=';
  static String taskByStatusEngineer =
      'api/now/table/sn_customerservice_task?sysparm_display_value=true&sysparm_query=assigned_to.user_name=$userName^ORDERBYASCsys_created_on^ORDERBYASCu_preferred_schedule_by_customer^state=';
  static String getTaskListEngineer =
      'api/now/table/sn_customerservice_task?sysparm_query=assigned_to.user_name=$userName^ORDERBYDESCu_preferred_schedule_by_customer^ORDERBYDESCsys_created_on&sysparm_display_value=true';
  static String getAcceptedTaskListEngineer =
      'api/now/table/sn_customerservice_task?sysparm_query=assigned_to.user_name=$userName^ORDERBYDESCu_preferred_schedule_by_customer^u_field_engineer_accepted=true^ORDERBYDESCsys_created_on&sysparm_display_value=true';
  static String getNewTaskListEngineer(String username) =>
      'api/now/table/sn_customerservice_task?sysparm_query=assigned_to.user_name=$username^ORDERBYDESCu_preferred_schedule_by_customer^u_field_engineer_accepted=false^ORDERBYDESCsys_created_on&sysparm_display_value=true';
  static String getResolveTaskListEngineer =
      'api/now/table/sn_customerservice_task?sysparm_query=assigned_to.user_name=$userName^ORDERBYDESCu_preferred_schedule_by_customer^ORDERBYDESCsys_created_on&sysparm_display_value=true';
  static String getIncompleteTaskListEngineer =
      'api/now/table/sn_customerservice_task?sysparm_query=assigned_to.user_name=$userName^ORDERBYDESCsys_created_on^ORDERBYDESCu_preferred_schedule_by_customer^state=$completeTaskStatus&sysparm_display_value=true';
  static String csrAttachment = 'api/now/table/ecc_queue';
  static String updateTaskAPI = "api/now/table/sn_customerservice_task/";
  static String updateTaskNewAPI = "api/titn/update_case_task/timings/";
  static String caseDetail = "api/titn/xbridgecasedetails/";
  static String taskEngineerList = "api/titn/xbridge_location_fe_mapping/";

  // Dyte Meeting API endpoints
  static String dyteBaseUrl = "https://api.dyte.io/";
  static String dyteCreateMeeting = "v2/meetings/";
  static String dyteAddParticipant = "v2/meetings/#/participants";

  // Dashboard API endpoints
  static String fieldEngineerDashboardDetails =
      "api/now/table/sn_customerservice_task?sysparm_query=assigned_to.user_name=$userName&sysparm_fields=number,state,u_customer_satisfaction,u_preferred_schedule_by_customer,u_parent.u_service_type";
  static String managerDashboardDetails =
      "api/now/table/sn_customerservice_task?sysparm_fields=number,state,u_customer_satisfaction,u_preferred_schedule_by_customer,u_parent.u_service_type&sysparm_query=assignment_group.name=$vendorName";

  // User details API endpoint
  static String updateUserDetailsApi = "api/now/table/sys_user/";

  // Diagnostic attachment API endpoint
  static String diagnosticAttachment = "api/now/attachment/upload";

  // Task lists API endpoints for different task statuses
  static String getAcceptedTasks =
      'api/now/table/sn_customerservice_task?sysparm_display_value=true&sysparm_query=u_field_engineer_accepted=true^ORDERBYDESCsys_created_on^ORDERBYu_preferred_schedule_by_customer^assigned_to.user_name=';
  static String getNewTasks =
      'api/now/table/sn_customerservice_task?sysparm_display_value=true&sysparm_query=u_field_engineer_accepted=false^ORDERBYDESCsys_created_on^ORDERBYu_preferred_schedule_by_customer^assigned_to.user_name=';
  static String getResolveTasks =
      'api/now/table/sn_customerservice_task?sysparm_display_value=true&sysparm_query=ORDERBYu_preferred_schedule_by_customer^ORDERBYDESCsys_created_on^assigned_to.user_name=';
  static String getIncompleteTasks =
      'api/now/table/sn_customerservice_task?sysparm_display_value=true&sysparm_query=ORDERBYDESCsys_created_on^ORDERBYu_preferred_schedule_by_customer^state=$completeTaskStatus^assigned_to.user_name=';

  // FCM endpoint for sending push notifications
  static String sendPushNotification = "https://fcm.googleapis.com/fcm/send";
}
