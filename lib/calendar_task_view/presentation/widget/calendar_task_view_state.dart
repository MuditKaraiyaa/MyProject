import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:xbridge/calendar_task_view/presentation/screen/calendar_task_view.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/fe_task_list/controller/fe_list_event.dart';

import '../../../common/constants/constants.dart';
import '../../../common/widgets/loader.dart';
import '../../../fe_task_list/controller/fe_list_block.dart';
import '../../../fe_task_list/controller/fe_list_state.dart';
import '../../../unassigned_visits/data/model/unassigned_task_entity.dart';

class CalendarTaskViewState extends State<CalendarTaskView> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  late RefreshController _refreshController;
  final _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // late final ValueNotifier<List<Event>> _selectedEvents;
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (mounted) {
      setState(() {
        _connectionStatus = result;
      });
    }
  }

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _refreshController = RefreshController();
    _selectedDay = _focusedDay;
    context
        .read<FieldEngineerTaskListBlock>()
        .add(LoadFieldEngineerTaskListEvent());
    super.initState();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status : $e');

      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  void dispose() {
    // _selectedEvents.dispose();
    _connectivitySubscription.cancel();
    _refreshController.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  // List<Event> _getEventsForRange(DateTime start, DateTime end) {
  //   // Implementation example
  //   final days = daysInRange(start, end);
  //
  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return initialUI();
  }

  _onRefresh() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: 'Please connect to internet');
      return;
    }
    if (kDebugMode) {
      print("onRefresh");
    }
    _refreshController.refreshCompleted();
    if (mounted) {
      await deleteTableFromDatabase(Constants.tblFETaskList).then((value) {
        context
            .read<FieldEngineerTaskListBlock>()
            .add(LoadFieldEngineerTaskListEvent());
      });
    }
  }

  _onLoading(BuildContext context) {
    if (kDebugMode) {
      print("onLoading");
    }
  }

  SafeArea initialUI() {
    return SafeArea(
      child:
          BlocBuilder<FieldEngineerTaskListBlock, FieldEngineerTaskListState>(
        builder: (_, state) {
          print("state: $state");
          if (state is FieldEngineerTaskLoadedState) {
            return const Loader();
          } else if (state is FieldEngineerTaskListLoadingState) {
            return const Loader();
          } else if (state is FieldEngineerAllTaskLoadedState) {
            return Container(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
              ),
              child: SmartRefresher(
                onRefresh: _onRefresh,
                onLoading: () {
                  _onLoading(context);
                },
                enablePullDown: _connectionStatus != ConnectivityResult.none,
                controller: _refreshController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 2,
                        shadowColor: AppColors.black,
                        surfaceTintColor: Colors.white,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          child: TableCalendar<UnassignedTaskResult>(
                            firstDay: DateTime(
                              kToday.year - 100,
                              kToday.month,
                              kToday.day,
                            ),
                            lastDay: DateTime(
                              kToday.year + 100,
                              kToday.month,
                              kToday.day,
                            ),
                            focusedDay: _focusedDay,
                            headerStyle: HeaderStyle(
                              leftChevronVisible: false,
                              rightChevronVisible: false,
                              formatButtonVisible: false,
                              titleTextStyle:
                                  Styles.textStyledarkRed18dpRegular,
                            ),
                            daysOfWeekVisible: false,
                            headerVisible: true,
                            eventLoader: (DateTime date) {
                              return state.getTasksByDate(
                                    date: date.onlyDate,
                                  ) ??
                                  [];
                            },
                            weekNumbersVisible: false,
                            calendarFormat: CalendarFormat.month,
                            selectedDayPredicate: (day) {
                              // Use `selectedDayPredicate` to determine which day is currently selected.
                              // If this returns true, then `day` will be marked as selected.

                              // Using `isSameDay` is recommended to disregard
                              // the time-part of compared DateTime objects.
                              return isSameDay(_selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              if (!isSameDay(_selectedDay, selectedDay)) {
                                // Call `setState()` when updating the selected day
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                                // _selectedEvents.value = _getEventsForDay(selectedDay);
                              }
                            },
                            onPageChanged: (focusedDay) {
                              // No need to call `setState()` here
                              _focusedDay = focusedDay;
                            },
                            calendarBuilders: CalendarBuilders(
                              markerBuilder: (context, day, events) {
                                if (events.isNotEmpty) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: events.map((e) {
                                      int index = events.indexOf(e);
                                      if (index < 3) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 1,
                                          ),
                                          child: Image.asset(
                                            index >= 2
                                                ? AppImage.icPlus
                                                : AppImage.icDot,
                                            height: 8,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }).toList(),
                                  );
                                }
                                return null;
                              },
                              selectedBuilder: (context, day1, day2) {
                                return Container(
                                  height: 36,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.red,
                                    ),
                                  ),
                                  child: Text(
                                    day1.day.toString(),
                                  ),
                                );
                              },
                              todayBuilder: (context, day1, day2) {
                                return Container(
                                  height: 36,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    day1.day.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                            calendarStyle: CalendarStyle(
                              todayDecoration: BoxDecoration(
                                color: AppColors.red,
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.red,
                                ),
                              ),
                              selectedTextStyle:
                                  TextStyle(color: AppColors.black),
                            ),
                          ),
                        ),
                      ),
                      8.verticalSpace,
                      _buildTaskList(state: state),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is FieldEngineerTaskErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Error!!'),
            );
          }
        },
      ),
    );
  }

  Widget _buildTaskList({required FieldEngineerTaskListState state}) {
    if (state is FieldEngineerAllTaskLoadedState) {
      getJson(state.data);
      List<UnassignedTaskResult> taskList =
          state.data[_selectedDay.onlyDate] ?? [];
      if (taskList.isNotEmpty) {
        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: taskList.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 30),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              UnassignedTaskResult task = taskList[index];
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                shadowColor: Colors.grey,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onTap: () async {
                    await GoRouter.of(context).pushNamed(
                      RouteConstants.taskDetails,
                      queryParameters: {
                        'id': task.sysId,
                      },
                      extra: task,
                    );
                    _onRefresh();
                  },
                  title: Text(
                    '${task.parent?.displayValue ?? ''} - ${task.number}',
                    style: Styles.textStyledarkBlack13dpBold,
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      border: task.state?.toLowerCase() == 'closed'
                          ? null
                          : Border.all(),
                      borderRadius: BorderRadius.circular(5.0),
                      color: task.state?.toLowerCase() == 'closed'
                          ? AppColors.btnDisable
                          : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(5.h),
                    child: Text(
                      task.state ?? '',
                      style: Styles.textStyledarkBlack8dpBold,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Nothing planned.\n Enjoy your day!',
              style: TextStyle(
                color: AppColors.noData,
                fontSize: 13,
              ),
            ),
          ],
        );
      }
    }
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        Text(
          'Nothing planned.Enjoy your day!',
          style: TextStyle(
            color: AppColors.noData,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

// void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
//   setState(() {
//     _selectedDay = null;
//     _focusedDay = focusedDay;
//     _rangeStart = start;
//     _rangeEnd = end;
//     _rangeSelectionMode = RangeSelectionMode.toggledOn;
//   });
//
//   // `start` or `end` could be null
//   if (start != null && end != null) {
//     _selectedEvents.value = _getEventsForRange(start, end);
//   } else if (start != null) {
//     _selectedEvents.value = _getEventsForDay(start);
//   } else if (end != null) {
//     _selectedEvents.value = _getEventsForDay(end);
//   }
// }
}
