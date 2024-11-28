// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xbridge/calendar_task_view/presentation/screen/calendar_task_view.dart';
import 'package:xbridge/common/app_scaffold.dart';
import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/network/api_provider.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/dashboard/controller/dashboard_block.dart';
import 'package:xbridge/dashboard/data/repositories/dashboard.repositories.dart';
import 'package:xbridge/dashboard/presentation/screen/dashboard.dart';
import 'package:xbridge/fe_task_list/controller/fe_list_block.dart';
import 'package:xbridge/fe_task_list/controller/fe_list_event.dart';
import 'package:xbridge/fe_task_list/data/fe_task_list_repositories.dart';
import 'package:xbridge/fe_task_list/presentation/screen/fe_task_list.dart';
import 'package:xbridge/log_list/controller/log_list_block.dart';
import 'package:xbridge/log_list/data/log_list_repositories.dart';
import 'package:xbridge/log_list/presentation/screen/log_list.dart';
import 'package:xbridge/my_team/controller/my_team_block.dart';
import 'package:xbridge/my_team/controller/my_team_event.dart';
import 'package:xbridge/my_team/data/my_team_repositories.dart';
import 'package:xbridge/my_team/presentation/screen/my_team_listing.dart';
import 'package:xbridge/setting/controller/settings_block.dart';
import 'package:xbridge/setting/data/settings_repositories.dart';
import 'package:xbridge/setting/presentation/screen/settings_listing.dart';
import 'package:xbridge/task_details/data/models/task_detail_entity.dart';
import 'package:xbridge/unassigned_visits/controller/unassigned_task_bloc.dart';
import 'package:xbridge/unassigned_visits/data/unassigned_task_repositories.dart';
import 'package:xbridge/unassigned_visits/presentation/screen/unassigned_visit.dart';

import '../../dashboard/controller/dashboard_event.dart';
import '../theme/styles.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({super.key, this.selectedIndex = 2});
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBlock(
        repository: DashboardRepositoryImpl(
          provider: GetIt.I.get<APIProvider>(),
        ),
      ),
      child: TabBarState(index: selectedIndex),
    );
  }
}

class TabBarState extends StatefulWidget {
  const TabBarState({super.key, required this.index});
  final int index;
  @override
  State<TabBarState> createState() => _TabBarStateState();
}

class _TabBarStateState extends State<TabBarState> {
  // int _selectedIndex = 2;
  late APIProvider provider;

  late List<Widget> _widgetOptions;
  //online msg show bool

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  _TabBarStateState() {
    provider = GetIt.I.get<APIProvider>();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        tabBarIndex.value = widget.index;
      });
      await Future.delayed(const Duration(milliseconds: 700));
      initConnectivity();
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    });

    _widgetOptions = <Widget>[
      userType == UserType.fe
          ? BlocProvider(
              create: (_) => FieldEngineerTaskListBlock(
                repository: FieldEngineerTaskListImpl(
                  provider: GetIt.I.get<APIProvider>(),
                ),
              )..add(LoadFieldEngineerTaskListEvent()),
              child: AppScaffold(
                shouldShowBottomNav: true,
                title: 'Calendar',
                isPopUp: false,
                shouldShowAppBar: true,
                shouldShowBackIcon: true,
                screenIndex: 0,
                child: const CalendarTaskView(),
              ),
            )
          : BlocProvider(
              create: (_) => MyTeamBlock(
                repository: MyTeamRepositoryImpl(
                  provider: GetIt.I.get<APIProvider>(),
                ),
              )..add(
                  const MyTeamFetchDataEvent(),
                ),
              child: AppScaffold(
                shouldShowBottomNav: true,
                title: 'My Team',
                isPopUp: false,
                shouldShowAppBar: true,
                shouldShowBackIcon: true,
                screenIndex: 0,
                child: const MyTeamListing(),

                // child: const ServiceCall(),
              ),
            ),
      userType == UserType.fe
          ? BlocProvider(
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
                shouldShowBottomNav: true,
                title: 'Tasks',
                isPopUp: false,
                shouldShowAppBar: true,
                shouldShowBackIcon: true,
                screenIndex: 1,
                child: const FieldEngineerTaskList(),
              ),
            )
          : BlocProvider(
              create: (_) => UnassignedTaskBloc(
                repository: UnassignedTasksRepositoryImpl(
                  provider: GetIt.I.get<APIProvider>(),
                ),
              )..add(LoadUnassignedTaskEvent()),
              child: AppScaffold(
                shouldShowBottomNav: true,
                title: 'New Tasks',
                isPopUp: false,
                shouldShowAppBar: true,
                shouldShowBackIcon: true,
                screenIndex: 1,
                child: const UnAssignedVisits(),
              ),
            ),
      AppScaffold(
        shouldShowBottomNav: true,
        title: '',
        isPopUp: true,
        shouldShowAppBar: false,
        shouldShowBackIcon: false,
        child: const Dashboard(),
      ),
      BlocProvider(
        create: (_) => LogListBlock(repository: LogListRepositoryImpl()),
        child: AppScaffold(
          shouldShowBottomNav: true,
          title: 'Logs',
          isPopUp: false,
          shouldShowAppBar: true,
          shouldShowBackIcon: true,
          child: const LogList(),

          // child: const ServiceCall(),
        ),
      ),
      BlocProvider(
        create: (_) => SettingsBlock(repository: SettingsRepositoryImpl()),
        child: AppScaffold(
          shouldShowBottomNav: true,
          title: 'Settings',
          isPopUp: false,
          shouldShowAppBar: true,
          shouldShowBackIcon: true,
          screenIndex: 4,
          child: const SettingsListing(),

          // child: const ServiceCall(),
        ),
      ),
    ];

    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    try {
      await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Couldn\'t check connectivity status $e');
      }
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }
  }

  Flushbar _offlineFlushbar = Flushbar(); // Define a Flushbar instance variable initialized to null

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); // Initialize SharedPreferences

    bool isInternetAvailable = result != ConnectivityResult.none;

    setState(() {
      if (!isInternetAvailable) {
        // Show offline message
        _showOfflineMessage();
      } else {
        // Dismiss offline Flushbar if it was shown
        _offlineFlushbar.dismiss().then((_) {
          _showOnlineMessage();
          prefs.setBool(
            '_onlineMessageShown',
            true,
          );
        });

        // Check if online message was previously shown
        bool onlineMessageShown =
            prefs.getBool('_onlineMessageShown') ?? false; // Retrieve the flag
        if (!onlineMessageShown) {
          // Show online message
          _showOnlineMessage();
          prefs.setBool(
            '_onlineMessageShown',
            true,
          ); // Save the flag when online and showing the message
        }
      }
    });

    if (isInternetAvailable) {
      // Your existing code for handling online status
      getUnsyncAPIData().then((objAPIList) {
        if (objAPIList != null) {
          if (objAPIList.isNotEmpty) {
            objAPIList.forEach((element) async {
              if ((element.apiName ?? "").contains(APIConstant.updateTaskAPI)) {
                try {
                  final response = await provider.putMethod(
                    element.apiName ?? "",
                    data: jsonEncode(element.parameters),
                  );
                  final data = TaskDetailEntity.fromJson(response);
                  if (data.result != null) {
                    removeUnSyncedAPI(element);
                  } else {
                    deleteTableByKeyFromDatabase(
                      Constants.tblManagerUnAssignedTaskList,
                      inCompleteTaskStatus,
                    );
                  }
                  if (kDebugMode) {
                    print(
                      "--------------------------------------------------",
                    );
                    print(
                      "Resposne : ${element.apiMethod} :: ${data.toJson()}",
                    );
                  }
                } catch (e) {
                  deleteTableByKeyFromDatabase(
                    Constants.tblManagerUnAssignedTaskList,
                    inCompleteTaskStatus,
                  );
                }
              }
            });
          }
        }
      });
    }
  }

  void _showOfflineMessage() {
    _offlineFlushbar = Flushbar(
      messageText: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off,
              color: Colors.white,
              size: 13,
            ),
            const SizedBox(width: 3), // Adding space between icon and text
            Text(
              'You are offline',
              style: Styles.textStyledarkWhite10dpRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ), // Provide a message
      backgroundColor: Colors.grey.shade700,
      flushbarStyle: FlushbarStyle.FLOATING,
      // barBlur: 10,
      blockBackgroundInteraction: false,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      isDismissible: false,
      shouldIconPulse: true,
      flushbarPosition: FlushbarPosition.TOP,
    )..show(context);
  }

  void _showOnlineMessage() {
    _offlineFlushbar = Flushbar(
      messageText: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud,
              color: Colors.white,
              size: 13,
            ),
            const SizedBox(width: 3), // Adding space between icon and text
            Text(
              'You are online',
              style: Styles.textStyledarkWhite10dpRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ), // Provide a message
      backgroundColor: Colors.green,
      flushbarStyle: FlushbarStyle.FLOATING,
      barBlur: 10,
      blockBackgroundInteraction: true,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      isDismissible: false,
      shouldIconPulse: false,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 3),
    )..show(context);
  }

  Future<void> _onItemTapped(int index) async {
    setState(() {
      tabBarIndex.value = index;
    });
    if (index == 2) {
      final result = await _connectivity.checkConnectivity();
      if (mounted) {
        if (result != ConnectivityResult.none) {
          await deleteTableFromDatabase(Constants.tblMyDashboard);
        }
        if (mounted) {
          BlocProvider.of<DashboardBlock>(context).add(
            DashboardFetchDataEvent(
              skipLoading: result != ConnectivityResult.none,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: tabBarIndex,
      builder: (__, value, _) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: _widgetOptions.elementAt(value),
              ),
              Row(
                children: [0, 1, 2, 3, 4]
                    .map(
                      (e) => Expanded(
                        child: Container(
                          height: 2.h,
                          margin: EdgeInsets.symmetric(horizontal: 9.w),
                          color: e == value ? AppColors.red : Colors.transparent,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              userType == UserType.fe
                  ? BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppImage.icNavCalendar,
                        color: value == 0 ? AppColors.red : AppColors.iconDisable,
                        height: 23.h,
                        width: 23.w,
                      ),
                      label: '',
                    )
                  : BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppImage.icNavGroup,
                        color: value == 0 ? AppColors.red : AppColors.iconDisable,
                        height: 32.h,
                        width: 32.w,
                      ),
                      label: '',
                    ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImage.icNavTasks,
                  color: value == 1 ? AppColors.red : AppColors.iconDisable,
                  height: 23.h,
                  width: 23.w,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImage.icNavHome,
                  color: value == 2 ? AppColors.red : AppColors.iconDisable,
                  height: 23.h,
                  width: 23.w,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImage.icNavBell,
                  color: value == 3 ? AppColors.red : AppColors.iconDisable,
                  height: 23.h,
                  width: 23.w,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImage.icNavSetting,
                  color: value == 4 ? AppColors.red : AppColors.iconDisable,
                  height: 23.h,
                  width: 23.w,
                ),
                label: '',
              ),
            ],
            selectedFontSize: 0,
            currentIndex: value,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
