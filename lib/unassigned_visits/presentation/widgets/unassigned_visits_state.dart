import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xbridge/common/constants/constants.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/common/widgets/loader.dart';
import 'package:xbridge/common/widgets/task_card.dart';
import 'package:xbridge/unassigned_visits/controller/unassigned_task_bloc.dart';
import 'package:xbridge/unassigned_visits/presentation/screen/unassigned_visit.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/globals.dart';
import '../../../common/theme/styles.dart';
import '../../data/model/unassigned_task_entity.dart';

class UnAssignedVisitsState extends State<UnAssignedVisits> {
  late RefreshController _refreshController;
  late UnassignedTaskBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController();
    bloc = BlocProvider.of<UnassignedTaskBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      // header: const TwoLevelHeader(),
      onRefresh: _onRefresh,
      onLoading: () {
        _onLoading(context);
      },
      controller: _refreshController,
      child: initUI(context),
    );
  }

  void _onRefresh() async {
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
    deleteTableFromDatabase(Constants.tblManagerUnAssignedTaskList).then(
      (value) => {
        bloc.add(LoadUnassignedTaskEvent()),
        BlocListener<UnassignedTaskBloc, UnassignedTaskState>(
          listener: (context, state) async {
            if (state is UnassignedTaskLoadingState) {
              _refreshController.requestLoading();
            } else if (state is UnassignedTaskLoadedState) {
              _refreshController.loadComplete();
            } else if (state is UnassignedTaskErrorState) {
              _refreshController.loadComplete();
            }
          },
        ),
      },
    );
  }

  _onLoading(BuildContext context) {
    if (kDebugMode) {
      print("onLoading");
    }
  }

  Widget initUI(BuildContext context) {
    return BlocBuilder<UnassignedTaskBloc, UnassignedTaskState>(
      builder: (context, UnassignedTaskState state) {
        if (state is UnassignedTaskLoadingState) {
          return const Loader();
        } else if (state is UnassignedTaskLoadedState) {
          return SafeArea(
            child: Container(
              margin: EdgeInsets.all(20.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (state.response.isEmpty) ...{
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .1,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    } else ...{
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: state.response.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          UnassignedTaskResult model = state.response[index];
                          return Column(
                            children: [
                              //  SizedBox(height: 20.h),
                              // const Text(
                              //   "10-10-2023",
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.w600,
                              //   ),
                              // ),
                              // SizedBox(height: 6.h),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: TaskCard(
                                  model: model,
                                  isButtonVisible: false,
                                  onCardPress: () async {
                                    taskNumber = model.number ?? "";

                                    await GoRouter.of(context).pushNamed(
                                      RouteConstants.taskDetails,
                                      queryParameters: {
                                        'id': model.sysId,
                                        'showScheduleBtn': (userType == UserType.fm).toString(),
                                      },
                                    );
                                    _onRefresh();
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    },
                  ],
                ),
              ),
            ),
          );
        } else if (state is UnassignedTaskErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Error!!'),
          );
        }
      },
    );
  }
}
