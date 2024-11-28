import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/context_extension.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/fe_task_list/presentation/screen/fe_task_list.dart';

import '../../../common/constants/route_constants.dart';
import '../../../common/widgets/loader.dart';
import '../../../common/widgets/task_card.dart';
import '../../../unassigned_visits/data/model/unassigned_task_entity.dart';
import '../../controller/fe_list_block.dart';
import '../../controller/fe_list_event.dart';
import '../../controller/fe_list_state.dart';

class FieldEngineerTaskListStateState extends State<FieldEngineerTaskList> {
  int selectedButtonIndex = 1;

  late RefreshController _refreshController;
  final TextEditingController _rejectTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
      context.read<FieldEngineerTaskListBlock>().add(
            LoadFieldEngineerTaskListByIDEvent(
              id: openNewTaskStatus,
            ),
          );
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: feTaskListNewTabRefreshIndicator,
      builder: (_, value, __) {
        if (value) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
            await deleteTableFromDatabase(Constants.tblFETaskList);
            if (mounted) {
              context.read<FieldEngineerTaskListBlock>().add(
                    LoadFieldEngineerTaskListByIDEvent(
                      id: getStatusIDFromSelectedTab(),
                    ),
                  );
            }
            feTaskListNewTabRefreshIndicator.value = false;
          });
        }
        return initUI(context);
      },
    );
  }

  void _onRefresh() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: 'Please connect to internet');
      return;
    }

    _refreshController.refreshCompleted();
    await deleteTableFromDatabase(Constants.tblFETaskList);
    if (mounted) {
      context.read<FieldEngineerTaskListBlock>().add(
            LoadFieldEngineerTaskListByIDEvent(
              id: getStatusIDFromSelectedTab(),
            ),
          );
    }
  }

  Widget initUI(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FittedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Row(
                children: [
                  buildTextButton(
                    "New",
                    () async {
                      setState(() {});
                      context.read<FieldEngineerTaskListBlock>().add(
                            LoadFieldEngineerTaskListByIDEvent(
                              id: getStatusIDFromSelectedTab(),
                            ),
                          );
                    },
                    1,
                  ),
                  10.horizontalSpace,
                  buildTextButton(
                    "Accepted",
                    () {
                      context.read<FieldEngineerTaskListBlock>().add(
                            LoadFieldEngineerTaskListByIDEvent(
                              id: getStatusIDFromSelectedTab(),
                            ),
                          );
                    },
                    2,
                  ),
                  10.horizontalSpace,
                  buildTextButton(
                    "Resolved",
                    () async {
                      context.read<FieldEngineerTaskListBlock>().add(
                            LoadFieldEngineerTaskListByIDEvent(
                              id: getStatusIDFromSelectedTab(),
                            ),
                          );
                    },
                    3,
                  ),
                  10.horizontalSpace,
                  buildTextButton(
                    "Incomplete",
                    () {
                      context.read<FieldEngineerTaskListBlock>().add(
                            LoadFieldEngineerTaskListByIDEvent(
                              id: getStatusIDFromSelectedTab(),
                            ),
                          );
                    },
                    4,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<FieldEngineerTaskListBlock, FieldEngineerTaskListState>(
              builder: (context, state) {
                // logger.i(state);
                if (state is FieldEngineerTaskListLoadingState) {
                  return const Loader();
                } else if (state is FieldEngineerTaskLoadedState) {
                  return SmartRefresher(
                    primary: true,
                    enablePullDown: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    onRefresh: _onRefresh,
                    controller: _refreshController,
                    child: SingleChildScrollView(
                      child: Builder(
                        builder: (context) {
                          if (state.response.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .2,
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: AppColors.red,
                                    size: 38,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'No record found!',
                                    style: Styles.textStyledarkBlack13dpRegular,
                                  ),
                                ],
                              ),
                            );
                          }
                          return getListView(state.response);
                        },
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
          ),
        ],
      ),
    );
  }

  Widget getListView(List<UnassignedTaskResult> result) {
    return GroupedListView<UnassignedTaskResult, String>(
      elements: result,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, element) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 8,
          ),
          child: TaskCard(
            model: element,
            onCardPress: () async => await onCardPress(element, context),
            isButtonVisible: selectedButtonIndex == 1,
            onAcceptButtonPress: () => onAcceptPress(context, element),
            onRejectButtonPress: () => showDialogOnRejectPress(context, element),
          ),
        );
      },
      groupHeaderBuilder: (element) {
        final title = element.uPreferredScheduleByCustomerSystem != null &&
                element.uPreferredScheduleByCustomerSystem!.isNotEmpty
            ? element.uPreferredScheduleByCustomerSystem
            : null;

        return Container(
          color: AppColors.geryshade300,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 14),
              Text(
                title == null
                    ? "Preferred schedule unavailable"
                    : DateFormat("MMMM dd, yyyy").format(DateTime.parse(title)),
                style: Styles.textStyledarkBlack14dpBold,
              ),
            ],
          ),
        );
      },
      order: GroupedListOrder.ASC,
      groupBy: (element) {
        final data = element.uPreferredScheduleByCustomerSystem != null &&
                element.uPreferredScheduleByCustomerSystem!.isNotEmpty
            ? element.uPreferredScheduleByCustomerSystem
            : null;
        if (data == null) {
          return "Preferred schedule unavailable";
        }
        return DateFormat("yyyy-MM-dd").format(DateTime.parse(data));
      },
    );
  }

  void onAcceptPress(BuildContext context, UnassignedTaskResult element) {
    context.read<FieldEngineerTaskListBlock>().add(
          LoadFieldEngineerTaskUpdateEvent(
            id: element.sysId ?? '',
            data: {
              // 'state': inProgressAcceptedTaskStatus,
              'u_field_engineer_accepted': 'true',
              'u_vendor_comments': '$firstName $lastName has accepted the task on XBridge Live',
            },
            currentTabStatus: getStatusIDFromSelectedTab(),
          ),
        );
    context.showSuccess(msg: "Task Accepted Successfully");
  }

  Future<void> onCardPress(
    UnassignedTaskResult element,
    BuildContext context,
  ) async {
    currentTaskStatus = selectedButtonIndex;
    taskNumber = element.number ?? "";
    await GoRouter.of(context).pushNamed(
      RouteConstants.taskDetails,
      queryParameters: {
        'id': element.sysId,
        'selectedButtonIndex': selectedButtonIndex.toString(),
        if (selectedButtonIndex == 0) ...{
          "showScheduleBtn": "false",
        },
      },
      extra: element,
    );
    final result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      await deleteTableFromDatabase(Constants.tblFETaskList);
    }
    if (mounted) {
      context.read<FieldEngineerTaskListBlock>().add(
            LoadFieldEngineerTaskListByIDEvent(
              id: getStatusIDFromSelectedTab(),
              softReload: true,
            ),
          );
    }
  }

  Future<dynamic> showDialogOnRejectPress(
    BuildContext context,
    UnassignedTaskResult element,
  ) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: const ContinuousRectangleBorder(),
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            top: 20.h,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.grey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                          side: BorderSide(color: AppColors.grey),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(true);
                      _rejectTaskController.clear();
                      // Navigator.of(context).pop();
                      // GoRouter.of(context).pop(true);
                      // Navigator.of(context).pop(false);
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppColors.primaryButtonBackgroundColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                          side: BorderSide(
                            color: AppColors.primaryButtonBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_rejectTaskController.text.isEmpty) {
                        context.showError(msg: "Please Enter Reason");
                      }
                      if (_rejectTaskController.text.isNotEmpty) {
                        context.read<FieldEngineerTaskListBlock>().add(
                              LoadFieldEngineerTaskUpdateEvent(
                                id: element.sysId ?? '',
                                data: {
                                  'u_field_engineer_accepted': 'false',
                                  'assigned_to': '',
                                  'u_vendor_comments':
                                      '$firstName $lastName has rejected the task on Xbridge Live.\nReason: ${_rejectTaskController.text}',
                                },
                                currentTabStatus: getStatusIDFromSelectedTab(),
                              ),
                            );
                        _rejectTaskController.text = "";
                        context.showSuccess(msg: "Task Rejected Successfully");
                        Navigator.of(context, rootNavigator: true).pop(true);
                      }
                    },
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
          content: SizedBox(
            width: double.maxFinite,
            child: Container(
              decoration: secondaryWidgetDecoration(),
              child: TextFormField(
                controller: _rejectTaskController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                maxLines: 5,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(20.0.h),
                  isDense: true,
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  alignLabelWithHint: false,
                  filled: true,
                  fillColor: AppColors.white,
                  hintText: "Enter Your Reason",
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  int getStatusIDFromSelectedTab() {
    switch (selectedButtonIndex) {
      case 1:
        return openNewTaskStatus;
      case 2:
        return inProgressAcceptedTaskStatus;
      case 3:
        return completeTaskStatus;
      case 4:
        return inCompleteTaskStatus;
    }
    return openNewTaskStatus;
  }

  Widget buildTextButton(
    String txt,
    void Function()? onPressed,
    int buttonIndex,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: selectedButtonIndex == buttonIndex
            ? Styles.textStyledarkBlack12dpBold
            : Styles.textStyledarkWhite10dpRegular,
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        foregroundColor: selectedButtonIndex == buttonIndex ? AppColors.white : AppColors.black,
        minimumSize: Size(90.w, 30.h),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        backgroundColor: selectedButtonIndex == buttonIndex
            ? AppColors.selectedColorButtonBackground
            : AppColors.greyBackground,
      ),
      onPressed: () {
        setState(() {
          selectedButtonIndex = buttonIndex;
        });
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Text(
        txt,
        style: selectedButtonIndex == buttonIndex
            ? Styles.textStyleLightPriority12dpBold
            : Styles.textStyledarkBlack12dpBold,
      ),
    );
  }
}

BoxDecoration secondaryWidgetDecoration() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 0.5,
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
    ],
  );
}
