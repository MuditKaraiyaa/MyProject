// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/common/widgets/task_card.dart';
import 'package:xbridge/fieldengineer/controller/field_engineer_bloc.dart';
import 'package:xbridge/fieldengineer/presentation/screen/field_engineer.dart';
import 'package:xbridge/unassigned_visits/controller/unassigned_task_bloc.dart';

import '../../../common/constants/constants.dart';
import '../../../common/constants/globals.dart';
import '../../../common/widgets/loader.dart';
import '../../../unassigned_visits/data/model/unassigned_task_entity.dart';
import '../../data/model/field_engineer_detail_entity.dart';

class FieldEngineerPageState extends State<FieldEngineer> {
  FieldEngineerPageState();

  int selectedButtonIndex = 1; // Default selected button index
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        final state = context.read<FieldEngineerBloc>().state;
        if (state is FieldEngineerLoadedState) {
          selectedButtonIndex = widget.selectedButtonIndex;
          context.read<UnassignedTaskBloc>().add(
                LoadFieldEngineerTaskByIDEvent(
                  id: widget.selectedButtonIndex,
                  userName: state.response.first.userName,
                ),
              );

          deleteTableFromDatabase(Constants.tblManagerTaskFEUserDetails).then(
            (value) => {
              context.read<FieldEngineerBloc>().add(
                    LoadFieldEngineerEvent(id: widget.userID),
                  ),
            },
          );
          deleteTableFromDatabase(Constants.tblManagerTaskList).then(
            (value) => {
              context.read<UnassignedTaskBloc>().add(
                    LoadFieldEngineerTaskByIDEvent(
                      id: getStatusIDFromSelectedTab(),
                      userName: state.response.first.userName,
                    ),
                  ),
            },
          );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  _onRefresh() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: 'Please connect to internet');
      return;
    }
    _refreshController.refreshCompleted();
    deleteTableFromDatabase(Constants.tblManagerTaskFEUserDetails).then(
      (value) => {
        context.read<FieldEngineerBloc>().add(
              LoadFieldEngineerEvent(id: widget.userID),
            ),
      },
    );
    deleteTableFromDatabase(Constants.tblManagerTaskList).then(
      (value) {
        {
          final state = context.read<FieldEngineerBloc>().state;
          if (state is FieldEngineerLoadedState) {
            context.read<UnassignedTaskBloc>().add(
                  LoadFieldEngineerTaskByIDEvent(
                    id: getStatusIDFromSelectedTab(),
                    userName: state.response.first.userName,
                  ),
                );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      onRefresh: _onRefresh,
      controller: _refreshController,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: AppColors.white),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    top: 15.h,
                    bottom: 15.h,
                    left: 15.w,
                  ),
                  decoration: BoxDecoration(color: AppColors.gray),
                  child: Text(
                    "User Information",
                    style: Styles.textStyledarkBlack15dpRegular,
                  ),
                ),
                const SizedBox(height: 15),
                BlocBuilder<FieldEngineerBloc, FieldEngineerState>(
                  builder: (context, state) {
                    if (state is FieldEngineerLoadingState) {
                      return const Loader();
                    } else if (state is FieldEngineerLoadedState) {
                      FieldEngineerDetailResult model = state.response.first;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                profileWidget(),
                                SizedBox(
                                  width: 25.w,
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      userInformationWidget(
                                        "Name",
                                        model.name == '' ? 'NA' : model.name ?? "",
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      userInformationWidget(
                                        "Role",
                                        model.uTypeOfUser == '' ? 'NA' : model.uTypeOfUser ?? '',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FittedBox(
                            child: Padding(
                              // padding: constraints.maxWidth < 600
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              // : EdgeInsets.symmetric(
                              //     vertical: 20, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildTextButton(
                                    "New",
                                    () {
                                      context.read<UnassignedTaskBloc>().add(
                                            LoadFieldEngineerTaskByIDEvent(
                                              id: getStatusIDFromSelectedTab(),
                                              userName: model.userName,
                                            ),
                                          );
                                    },
                                    1,
                                  ),
                                  10.horizontalSpace,
                                  buildTextButton(
                                    "Accepted",
                                    () {
                                      context.read<UnassignedTaskBloc>().add(
                                            LoadFieldEngineerTaskByIDEvent(
                                              id: getStatusIDFromSelectedTab(),
                                              userName: model.userName,
                                            ),
                                          );
                                    },
                                    2,
                                  ),
                                  10.horizontalSpace,
                                  buildTextButton(
                                    "Resolved",
                                    () {
                                      context.read<UnassignedTaskBloc>().add(
                                            LoadFieldEngineerTaskByIDEvent(
                                              id: getStatusIDFromSelectedTab(),
                                              userName: model.userName,
                                            ),
                                          );
                                    },
                                    3,
                                  ),
                                  10.horizontalSpace,
                                  buildTextButton(
                                    "Incomplete",
                                    () {
                                      context.read<UnassignedTaskBloc>().add(
                                            LoadFieldEngineerTaskByIDEvent(
                                              id: getStatusIDFromSelectedTab(),
                                              userName: model.userName,
                                            ),
                                          );
                                    },
                                    4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          BlocBuilder<UnassignedTaskBloc, UnassignedTaskState>(
                            builder: (context, state) {
                              if (state is FieldEngineerTaskLoadingState) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 150.0),
                                    child: Loader(),
                                  ),
                                );
                              } else if (state is FieldEngineerTaskLoadedState) {
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
                                } else {
                                  return GroupedListView<UnassignedTaskResult, String>(
                                    elements: state.response,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, data) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 12,
                                        ),
                                        child: TaskCard(
                                          model: data,
                                          isButtonVisible: false,
                                          onCardPress: () async =>
                                              await onCardPress(data, context, model),
                                        ),
                                      );
                                    },
                                    groupHeaderBuilder: (element) {
                                      final title = element.uPreferredScheduleByCustomerSystem !=
                                                  null &&
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
                                                  : DateFormat("MMMM dd, yyyy")
                                                      .format(DateTime.parse(title)),
                                              style: Styles.textStyledarkBlack14dpBold,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    order: GroupedListOrder.ASC,
                                    groupBy: (element) {
                                      final data = element.uPreferredScheduleByCustomerSystem !=
                                                  null &&
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
                              } else if (state is FieldEngineerTaskErrorState) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 250.0),
                                  child: Center(
                                    child: Text(state.message),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      );
                    } else if (state is FieldEngineerErrorState) {
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onCardPress(
    UnassignedTaskResult data,
    BuildContext context,
    FieldEngineerDetailResult model,
  ) async {
    taskNumber = data.number ?? "";
    currentTaskStatus = selectedButtonIndex;
    await GoRouter.of(context).pushNamed(
      RouteConstants.taskDetails,
      queryParameters: {
        'id': data.sysId,
        'showScheduleBtn': (userType == UserType.fe).toString(),
      },
      extra: data,
    );
    await deleteTableFromDatabase(
      Constants.tblManagerTaskList,
    );
    if (mounted) {
      context.read<UnassignedTaskBloc>().add(
            LoadFieldEngineerTaskByIDEvent(
              id: getStatusIDFromSelectedTab(),
              userName: model.userName,
              softReload: true,
            ),
          );
    }
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
        return cancelledTaskStatus;
    }
    return openNewTaskStatus;
  }

  Widget userInformationWidget(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: Styles.textStyledarkBlack13dpRegular,
        ),
        Flexible(
          child: Text(
            value,
            style: Styles.textStyledarkBlack13dpRegular,
          ),
        ),
      ],
    );
  }

  Widget profileWidget() {
    return Container(
      // padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
          ),
        ],
        border: Border.all(color: AppColors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(80.r),
        ),
      ),
      child: Column(
        children: [
          Image(
            image: AssetImage(AppImage.myTeamProfile),
            height: 80.h,
            width: 80.w,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  Text buildTextUserInfo(String t) {
    return Text(
      t,
      style: const TextStyle(
        color: Color(0xFF000000),
        fontWeight: FontWeight.bold,
      ),
    );
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
        // Adjust the height as needed

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
