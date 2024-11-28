import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/common/widgets/loader.dart';
import 'package:xbridge/my_team/controller/my_team_block.dart';
import 'package:xbridge/my_team/controller/my_team_event.dart';
import 'package:xbridge/my_team/presentation/screen/my_team_listing.dart';

import '../../../common/constants/app_colors.dart';
import '../../../main.dart';
import '../../controller/my_team_state.dart';
import '../../data/model/my_team_entity.dart';

class MyTeamListingStateState extends State<MyTeamListing> {
  late MyTeamBlock _myTeamBlock;
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _myTeamBlock = BlocProvider.of<MyTeamBlock>(context);
    _myTeamBlock.add(const MyTeamFetchDataEvent());
    _refreshController = RefreshController();
  }

  Future<void> _refresh() async {
    _myTeamBlock.add(const MyTeamFetchDataEvent());
    _refreshController.refreshCompleted();
    logger.i('Refreshing');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTeamBlock, MyTeamState>(
      builder: (context, state) {
        if (state is MyTeamLoadingState) {
          return const Loader();
        } else if (state is MyTeamLoadedState) {
          // Condition added if result is 0 then no team but check if data isNotEmpty.
          if (state.response.result!.isEmpty) {
            return const Center(
              child: Text("No Team"),
            );
          }
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: _refresh,
            child: setInitialUI(state.response),
          );
        } else if (state is MyTeamErrorState) {
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

  Widget profileWidget() {
    return Container(
      padding: EdgeInsets.all(10.h),
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
          Radius.circular(50.r),
        ),
      ),
      child: Column(
        children: [
          Image(
            image: AssetImage(AppImage.myTeamProfile),
            height: 45.h,
            width: 45.w,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  Widget myTeamWidget(Result result) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(
          RouteConstants.fieldEngineer,
          queryParameters: {
            'id': result.user?.link?.split("sys_user/")[1],
            'userName': result.user?.displayValue,
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.verticalSpace,
            profileWidget(),
            Text(
              result.user?.displayValue ?? "",
              textAlign: TextAlign.center,
              style: Styles.textStyledarkBlack12dpRegular,
            ),
          ],
        ),
      ),
    );
  }

  GridView setInitialUI(MyTeamEntity result) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: result.result?.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 160.h,
      ),
      itemBuilder: (context, index) {
        return myTeamWidget(result.result![index]);
      },
    );
  }
}
