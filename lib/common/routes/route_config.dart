import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:xbridge/calendar_task_view/presentation/screen/calendar_task_view.dart';
import 'package:xbridge/chat_list/controller/bloc/chat_list_bloc.dart';
import 'package:xbridge/chat_list/presentation/widget/chat_list_state.dart';
import 'package:xbridge/common/app_scaffold.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/routes/tab_bar.dart';
import 'package:xbridge/common/utils/shared_pref_helper.dart';
import 'package:xbridge/diagnostic/controller/bloc/diagnostic_bloc.dart';
import 'package:xbridge/diagnostic/presentation/screen/diagnostic.dart';
import 'package:xbridge/fe_task_list/controller/fe_list_block.dart';
import 'package:xbridge/fe_task_list/data/fe_task_list_repositories.dart';
import 'package:xbridge/fe_task_list/presentation/screen/fe_task_list.dart';
import 'package:xbridge/fieldengineer/controller/field_engineer_bloc.dart';
import 'package:xbridge/fieldengineer/data/field_engineer_repositories.dart';
import 'package:xbridge/fieldengineer/presentation/screen/field_engineer.dart';
import 'package:xbridge/location_update/presentation/screen/geolocator_widget.dart';
import 'package:xbridge/log_list/controller/log_list_block.dart';
import 'package:xbridge/log_list/data/log_list_repositories.dart';
import 'package:xbridge/my_team/controller/my_team_block.dart';
import 'package:xbridge/my_team/controller/my_team_event.dart';
import 'package:xbridge/my_team/data/my_team_repositories.dart';
import 'package:xbridge/my_team/presentation/screen/my_team_listing.dart';
import 'package:xbridge/service_call_report/controller/service_call_report_block.dart';
import 'package:xbridge/service_call_report/data/model/csr_model.dart';
import 'package:xbridge/service_call_report/data/service_call_report_repositories.dart';
import 'package:xbridge/service_call_report/presentation/screen/service_call.dart';
import 'package:xbridge/sign_screen/controller/sign_in_block.dart';
import 'package:xbridge/sign_screen/controller/sign_in_event.dart';
import 'package:xbridge/sign_screen/data/repositories/sign_in_repositories.dart';
import 'package:xbridge/sign_screen/presentation/screen/sign_in.dart';
import 'package:xbridge/splash_screen.dart';
import 'package:xbridge/task_details/controller/taskdetails_block.dart';
import 'package:xbridge/task_details/data/repositories/task_details_repositories.dart';
import 'package:xbridge/task_details/presentation/screen/task_details.dart';
import 'package:xbridge/unassigned_visits/controller/unassigned_task_bloc.dart';
import 'package:xbridge/unassigned_visits/presentation/screen/unassigned_visit.dart';
import 'package:xbridge/video_call/presentation/screens/video_call_page.dart';
import 'package:xbridge/work_note/controller/work_note_block.dart';
import 'package:xbridge/work_note/data/work_note_repositories.dart';
import 'package:xbridge/work_note/presentation/screen/work_notes.dart';

import '../../chat_page/presentation/screen/chat_page.dart';
import '../../diagnostic/data/repositories/diagnostic_repository.dart';
import '../../fe_task_list/controller/fe_list_event.dart';
import '../../log_list/presentation/screen/log_list.dart';
import '../../reconfirm_task/controller/reconfirm_task_bloc.dart';
import '../../reconfirm_task/presentation/screen/reconfirm_task.dart';
import '../../sd_agent/presentation/screen/sd_agent.dart';
import '../../service_call_report/presentation/screen/csr_pdf_page.dart';
import '../../setting/controller/settings_block.dart';
import '../../setting/data/settings_repositories.dart';
import '../../setting/presentation/screen/settings_listing.dart';
import '../../task_details/controller/taskdetails_event.dart';
import '../../unassigned_visits/data/model/unassigned_task_entity.dart';
import '../../unassigned_visits/data/unassigned_task_repositories.dart';
import '../../video_call/controller/video_call_bloc.dart';
import '../../video_call/data/repositories/video_call_repository.dart';
import '../network/api_provider.dart';

/// Class for defining the application router and its routes.
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  /// The main router configuration.
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/",
    errorBuilder: (context, state) => const Text("NO Route Found"),
    // redirect: (context, state) {
    //   // return '/';
    //   if (userName == "") {
    //     return '/${RouteConstants.signInRoute}';
    //   }
    //   return null;
    // },
    routes: [
      // Route for the splash screen.

      GoRoute(
        path: '/',
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      // Route for the main application shell.

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(child: child);
        },
        routes: [
          // Route for the home tab.
          GoRoute(
            path: '/${RouteConstants.tabBar}',
            parentNavigatorKey: _shellNavigatorKey,
            name: RouteConstants.tabBar,
            builder: (context, state) {
              int index = 2;
              if (state.extra != null && state.extra is Map<String, dynamic>) {
                final data = state.extra as Map<String, dynamic>;
                index = int.parse(data['index'] ?? "2");
              }

              return AppTabBar(
                selectedIndex: index,
              );
            },

            // name: RouteConstants.dashboard,
            // builder: (context, state) {
            //   return AppScaffold(
            //     shouldShowBottomNav: true,
            //     title: '',
            //     isPopUp: true,
            //     shouldShowAppBar: false,
            //     shouldShowBackIcon: false,
            //     child: const Dashboard(),
            //   );
            // },

            // Routes for the home tab.

            routes: [
              // add classes which are childrens of Home tab.

              GoRoute(
                path: RouteConstants.fieldEngineerSettings,
                name: RouteConstants.fieldEngineerSettings,
                pageBuilder: (context, state) {
                  Widget page = BlocProvider(
                    create: (_) => SettingsBlock(repository: SettingsRepositoryImpl()),
                    child: AppScaffold(
                      shouldShowBottomNav: false,
                      title: 'Settings',
                      isPopUp: false,
                      shouldShowAppBar: true,
                      shouldShowBackIcon: true,
                      screenIndex: 4,
                      child: const SettingsListing(),

                      // child: const ServiceCall(),
                    ),
                  );
                  // return NoTransitionPage(child: page);
                  return addSlideAnimation(page, state, context);
                },
              ),
              // Route for the calendar task view.

              GoRoute(
                path: RouteConstants.calendarTaskViewList,
                name: RouteConstants.calendarTaskViewList,
                pageBuilder: (context, state) {
                  Widget page = BlocProvider(
                    create: (_) => FieldEngineerTaskListBlock(
                      repository: FieldEngineerTaskListImpl(
                        provider: GetIt.I.get<APIProvider>(),
                      ),
                    )..add(LoadFieldEngineerTaskListEvent()),
                    child: AppScaffold(
                      shouldShowBottomNav: false,
                      title: 'Calendar',
                      isPopUp: false,
                      shouldShowAppBar: true,
                      shouldShowBackIcon: true,
                      screenIndex: 0,
                      child: const CalendarTaskView(),
                    ),
                  );
                  return addSlideAnimation(page, state, context);
                },
              ),
              // Route for the My Team page.

              GoRoute(
                path: RouteConstants.myTeam,
                name: RouteConstants.myTeam,
                pageBuilder: (context, state) {
                  Widget page = BlocProvider(
                    create: (_) => MyTeamBlock(
                      repository: MyTeamRepositoryImpl(
                        provider: GetIt.I.get<APIProvider>(),
                      ),
                    )..add(
                        const MyTeamFetchDataEvent(),
                      ),
                    child: AppScaffold(
                      shouldShowBottomNav: false,
                      title: 'My Team',
                      isPopUp: false,
                      shouldShowAppBar: true,
                      shouldShowBackIcon: true,
                      screenIndex: 0,
                      child: const MyTeamListing(),

                      // child: const ServiceCall(),
                    ),
                  );
                  return addSlideAnimation(page, state, context);
                },
                // Routes for the My Team page.

                routes: [
                  // Route for the Field Engineer details.

                  GoRoute(
                    path: RouteConstants.fieldEngineer,
                    name: RouteConstants.fieldEngineer,
                    pageBuilder: (context, state) {
                      String id = state.uri.queryParameters['id'] ?? '';
                      String index = state.uri.queryParameters['index'] ?? "1";
                      Widget page = MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (_) => FieldEngineerBloc(
                              repository: FieldEngineerRepositoryImpl(
                                provider: GetIt.I.get<APIProvider>(),
                              ),
                            )..add(LoadFieldEngineerEvent(id: id)),
                          ),
                          BlocProvider(
                            create: (_) => UnassignedTaskBloc(
                              repository: UnassignedTasksRepositoryImpl(
                                provider: GetIt.I.get<APIProvider>(),
                              ),
                            ),
                          ),
                        ],
                        child: AppScaffold(
                          shouldShowBottomNav: false,
                          title: 'Task-Field Engineer',
                          isPopUp: false,
                          shouldShowAppBar: true,
                          shouldShowBackIcon: true,
                          child: FieldEngineer(
                            userID: id,
                            selectedButtonIndex: int.parse(index),
                            // uName: uName,
                          ),
                        ),
                      );
                      return addSlideAnimation(page, state, context);
                    },
                  ),
                ],
              ),
              // Route for displaying the list of tasks assigned to the field engineer.

              GoRoute(
                path: RouteConstants.fieldEngineerTask,
                name: RouteConstants.fieldEngineerTask,
                pageBuilder: (context, state) {
                  Widget page = BlocProvider(
                    create: (_) => FieldEngineerTaskListBlock(
                      repository: FieldEngineerTaskListImpl(
                        provider: GetIt.I.get<APIProvider>(),
                      ),
                    )..add(
                        LoadFieldEngineerTaskListByIDEvent(
                          id: openNewTaskStatus,
                        ),
                      ),
                    child: AppScaffold(
                      shouldShowBottomNav: false,
                      title: 'Tasks',
                      isPopUp: false,
                      shouldShowAppBar: true,
                      shouldShowBackIcon: true,
                      screenIndex: 1,
                      child: const FieldEngineerTaskList(),
                    ),
                  );
                  return addSlideAnimation(page, state, context);
                },
              ),
              // Route for reconfirming a task by the field engineer.

              GoRoute(
                path: RouteConstants.reConfirmTask,
                name: RouteConstants.reConfirmTask,
                pageBuilder: (context, state) {
                  final data = state.extra as Map<String, dynamic>;
                  Widget page = BlocProvider(
                    create: (_) => ReconfirmTaskBloc(
                      FieldEngineerTaskListImpl(
                        provider: GetIt.I.get<APIProvider>(),
                      ),
                    ),
                    child: ReConfirmTask(
                      data: data,
                    ),
                  );
                  return addSlideAnimation(page, state, context);
                },
              ),
              // Route for displaying the details of a task.

              GoRoute(
                path: RouteConstants.taskDetails,
                name: RouteConstants.taskDetails,
                pageBuilder: (context, state) {
                  String? id = state.uri.queryParameters['id'];
                  String openFEDetails = state.uri.queryParameters['openFEDetails'] ?? 'false';
                  String showScheduleBtn = state.uri.queryParameters['showScheduleBtn'] ?? 'false';
                  Widget page = BlocProvider(
                    create: (_) => TaskDetailsBloc(
                      repository: TaskDetailsRepositoryImpl(
                        provider: GetIt.I.get<APIProvider>(),
                      ),
                    )..add(
                        TaskDetailsFetchDataEvent(
                          id: id ?? '',
                        ),
                      ),
                    child: AppScaffold(
                      shouldShowBottomNav: false,
                      title: 'Task Details',
                      isPopUp: false,
                      shouldShowAppBar: true,
                      shouldShowBackIcon: true,
                      openFEDetails: openFEDetails == "true",
                      child: TaskDetails(
                        id: id ?? '',
                        showScheduleBtn: showScheduleBtn == 'true',
                        selectedButtonIndex: int.parse(
                          state.uri.queryParameters['selectedButtonIndex'] ?? '0',
                        ),
                        model: state.extra != null ? (state.extra as UnassignedTaskResult) : null,
                      ),
                    ),
                  );
                  return addSlideAnimation(page, state, context);
                },
              ),
            ],
          ),

          // Route for displaying unassigned visits.
          GoRoute(
            path: '/${RouteConstants.unassignVisit}',
            name: RouteConstants.unassignVisit,
            builder: (context, state) {
              return BlocProvider(
                create: (_) => UnassignedTaskBloc(
                  repository: UnassignedTasksRepositoryImpl(
                    provider: GetIt.I.get<APIProvider>(),
                  ),
                )..add(LoadUnassignedTaskEvent()),
                child: AppScaffold(
                  shouldShowBottomNav: false,
                  title: 'New Tasks',
                  isPopUp: false,
                  shouldShowAppBar: true,
                  shouldShowBackIcon: true,
                  screenIndex: 1,
                  child: const UnAssignedVisits(),
                ),
              );
            },
          ),

          // Route for displaying the diagnostic screen.
          GoRoute(
            path: '/${RouteConstants.diagnostic}',
            name: RouteConstants.diagnostic,
            builder: (context, state) {
              return BlocProvider(
                create: (_) => DiagnosticBloc(
                  repository: DiagnosticImpl(
                    provider: GetIt.I.get<APIProvider>(),
                  ),
                ),
                child: AppScaffold(
                  shouldShowBottomNav: false,
                  title: 'Contact Support',
                  isPopUp: false,
                  shouldShowAppBar: true,
                  shouldShowBackIcon: true,
                  screenIndex: 1,
                  child: const Diagnostic(),
                ),
              );
            },
          ),

          // Route for displaying the list of logs.
          GoRoute(
            path: '/${RouteConstants.fieldEngineerLogList}',
            parentNavigatorKey: _shellNavigatorKey,
            name: RouteConstants.fieldEngineerLogList,
            pageBuilder: (context, state) {
              Widget page = BlocProvider(
                create: (_) => LogListBlock(repository: LogListRepositoryImpl()),
                child: AppScaffold(
                  shouldShowBottomNav: false,
                  title: 'Logs',
                  isPopUp: false,
                  shouldShowAppBar: true,
                  shouldShowBackIcon: true,
                  child: const LogList(),

                  // child: const ServiceCall(),
                ),
              );
              return addSlideAnimation(page, state, context);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/${RouteConstants.signInRoute}',
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.signInRoute,
        pageBuilder: (context, state) {
          final reset = state.extra;
          late Widget page;
          if (reset != null) {
            print("reset: $reset");
            page = BlocProvider(
              create: (_) => SignInBloc(
                repository: SignInRepositoryImpl(
                  provider: GetIt.I.get<APIProvider>(),
                  prefHelper: GetIt.I.get<SharedPrefHelper>(),
                ),
              )..add(GetAccessTokenEvent()),
              child: AppScaffold(
                shouldShowBottomNav: false,
                title: 'Sign In',
                isPopUp: true,
                shouldShowAppBar: false,
                shouldShowBackIcon: false,
                child: const SignIn(),
              ),
            );
          } else {
            page = AppScaffold(
              shouldShowBottomNav: false,
              title: 'Sign In',
              isPopUp: true,
              shouldShowAppBar: false,
              shouldShowBackIcon: false,
              child: const SignIn(),
            );
          }
          return addSlideAnimation(page, state, context);
        },
      ),
      GoRoute(
        path: '/${RouteConstants.fieldEngineerLocationUpdate}',
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.fieldEngineerLocationUpdate,
        builder: (context, state) {
          return const GeolocatorWidget();
        },
      ),
      GoRoute(
        path: '/${RouteConstants.fieldEngineerWorkNote}',
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.fieldEngineerWorkNote,
        pageBuilder: (context, state) {
          Widget page = BlocProvider(
            create: (_) => WorkNotesBlock(
              repository: WorkNoteImpl(
                provider: GetIt.I.get<APIProvider>(),
              ),
            ),
            child: AppScaffold(
              shouldShowBottomNav: false,
              title: 'Work Notes',
              isPopUp: false,
              shouldShowAppBar: true,
              shouldShowBackIcon: true,
              child: FEWorkNotes(
                model: state.extra as UnassignedTaskResult,
              ),
            ),
          );
          return addSlideAnimation(page, state, context);
        },
      ),
      GoRoute(
        path: '/${RouteConstants.chatListPage}',
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.chatListPage,
        pageBuilder: (context, state) {
          Widget page = BlocProvider(
            create: (_) => ChatListBloc(),
            child: AppScaffold(
              shouldShowBottomNav: false,
              title: 'Chat List',
              isPopUp: false,
              shouldShowAppBar: true,
              shouldShowBackIcon: true,
              child: const ChatList(),
            ),
          );
          return addSlideAnimation(page, state, context);
        },
      ),
      GoRoute(
        path: '/${RouteConstants.sdAgent}',
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.sdAgent,
        pageBuilder: (context, state) {
          String? id = state.uri.queryParameters['id'];
          Widget page = BlocProvider(
            create: (_) => TaskDetailsBloc(
              repository: TaskDetailsRepositoryImpl(
                provider: GetIt.I.get<APIProvider>(),
              ),
            )..add(
                TaskDetailsFetchDataEvent(
                  id: id ?? '',
                ),
              ),
            child: AppScaffold(
              shouldShowBottomNav: true,
              title: 'SD Agent',
              isPopUp: false,
              shouldShowAppBar: true,
              shouldShowBackIcon: false,
              child: const SDAgent(),
            ),
          );
          return addSlideAnimation(page, state, context);
        },
      ),

      GoRoute(
        path: '/${RouteConstants.chatPage}',
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.chatPage,
        pageBuilder: (context, state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          final page = ChatPage(
            groupId: data["groupId"],
            groupName: data["groupName"],
            userName: data["userName"],
            deviceToken: data["deviceToken"],
          );
          return addSlideAnimation(page, state, context);
        },
      ),
      GoRoute(
        path: '/${RouteConstants.serviceCallReport}',
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.serviceCallReport,
        pageBuilder: (context, state) {
          Widget page = BlocProvider(
            create: (_) => ServiceCallReportBlock(
              repository: ServiceCallReportImpl(
                provider: GetIt.I.get<APIProvider>(),
              ),
            ),
            child: AppScaffold(
              shouldShowBottomNav: false,
              title: 'Service Call Report',
              isPopUp: false,
              shouldShowAppBar: true,
              shouldShowBackIcon: true,
              child: ServiceCall(
                model: state.extra as UnassignedTaskResult,
                contractID: state.uri.queryParameters['id'] ?? '',
                street: state.uri.queryParameters['street'] ?? '',
                city: state.uri.queryParameters['city'] ?? '',
                country: state.uri.queryParameters['country'] ?? '',
                account: state.uri.queryParameters['account'] ?? '',
                scheduledDate: state.uri.queryParameters['scheduledDate'] ?? '',
                taskNumber: state.uri.queryParameters['taskNumber'] ?? '',
                workCompleted: state.uri.queryParameters['workCompleted'] ?? '',
                departureTime: state.uri.queryParameters['departureTime'] ?? '',

                ///   departureTime: state.uri.queryParameters['departureTime']?? '',

                // result: state.extra as CaseDetailEntity, street: 'test',
              ),
            ),
          );
          return addSlideAnimation(page, state, context);
        },
      ),
      GoRoute(
        path: '/${RouteConstants.serviceCallReportPDF}',
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.serviceCallReportPDF,
        pageBuilder: (context, state) {
          Widget page = AppScaffold(
            shouldShowBottomNav: false,
            title: 'Service Call Report PDF',
            isPopUp: false,
            shouldShowAppBar: true,
            shouldShowBackIcon: true,
            child: CSRPdfPage(
              model: state.extra as CSRModel,
            ),
          );
          return addSlideAnimation(page, state, context);
        },
      ),
      GoRoute(
        path: '/${RouteConstants.videoCall}',
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.videoCall,
        pageBuilder: (context, state) {
          String? id = state.uri.queryParameters['id'];
          Widget page = BlocProvider(
            create: (_) => VideoCallBloc(
              repository: VideoCallRepositoryImpl(
                provider: GetIt.I.get<APIProvider>(),
              ),
            ),
            child: AppScaffold(
              shouldShowBottomNav: false,
              title: 'Video Chat',
              isPopUp: false,
              shouldShowAppBar: true,
              shouldShowBackIcon: true,
              child: VideoCallPage(
                sysID: id,
              ),
            ),
          );
          return addSlideAnimation(page, state, context);
        },
      ),
      // GoRoute(
      //   path: '/${RouteConstants.fieldEngineerLogList}',
      //   parentNavigatorKey: _rootNavigatorKey,
      //   name: RouteConstants.fieldEngineerLogList,
      //   pageBuilder: (context, state) {
      //     Widget page = BlocProvider(
      //       create: (_) => LogListBlock(repository: LogListRepositoryImpl()),
      //       child: AppScaffold(
      //         title: 'Lo',
      //         isPopUp: false,
      //         shouldShowAppBar: true,
      //         shouldShowBackIcon: true,
      //         child: const LogList(),

      //         // child: const ServiceCall(),
      //       ),
      //     );
      //     return addSlideAnimation(page, state, context);
      //   },
      // ),
    ],
  );
}

Page<dynamic> addSlideAnimation(
  Widget page,
  GoRouterState state,
  BuildContext context,
) {
  return CustomTransitionPage(
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var curve = Curves.easeInOut;
      var tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      var curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
