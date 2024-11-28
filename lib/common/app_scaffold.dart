import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/routes/route_config.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/util.dart';

import '../task_details/controller/taskdetails_block.dart';
import '../task_details/controller/taskdetails_state.dart';

class AppScaffold extends StatefulWidget {
  String title;
  Widget? child;
  bool isPopUp;
  bool shouldShowAppBar;
  bool shouldShowBackIcon;
  bool shouldShowBottomNav = true;
  int? screenIndex = 2;
  bool openFEDetails;

  AppScaffold({
    super.key,
    required this.title,
    required this.child,
    required this.isPopUp,
    required this.shouldShowAppBar,
    required this.shouldShowBackIcon,
    required this.shouldShowBottomNav,
    this.screenIndex,
    this.openFEDetails = false,
    required,
  });

  @override
  State<AppScaffold> createState() => _AppScafoldState();
}

// int currentIndex = 2;

class _AppScafoldState extends State<AppScaffold> {
  int currentIndex = 2;

  void logoutUser() async {
    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
    GoRouter.of(context).pushReplacement(RouteConstants.signInRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.red,
        ),
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: !widget.isPopUp
              ? AppBar(
                  foregroundColor: AppColors.red,
                  centerTitle: true,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: AppColors.red,
                  ),
                  leading: widget.shouldShowBottomNav == false
                      ? BackButton(
                          color: Colors.white,
                          onPressed: () {
                            if (widget.openFEDetails) {
                              final state =
                                  context.read<TaskDetailsBloc>().state;
                              if (state is TaskDetailslLoadedState) {
                                GoRouter.of(context).pushReplacementNamed(
                                  RouteConstants.fieldEngineer,
                                  queryParameters: {
                                    'id': state.response.result!.task!
                                        .fieldEngineerSysId!,
                                    'index': "2",
                                  },
                                );
                              }
                            } else {
                              AppRouter.router.pop();
                            }
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 4),
                          child: Image.asset(
                            AppImage.dashboardLogo,
                            scale: 4.h,
                          ),
                        ),
                  //  Padding(
                  //     padding: EdgeInsets.only(left: 16.w),
                  //     child: Image.asset(
                  //       AppImage.dashboardLogo,
                  //       scale: 4,
                  //     ),
                  //   ),
                  title: Text(
                    widget.title,
                    style: Styles.textStyledarkWhite18dpRegular,
                  ),
                  automaticallyImplyLeading: true,
                  elevation: 0,
                  backgroundColor: AppColors.red,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Image.asset(
                        AppImage.dashboardLogoRectangle,
                        width: 67.w,
                        height: 16.h,
                      ),
                    ),
                  ],
                )
              : PreferredSize(
                  preferredSize: const Size(0.0, 0.0),
                  child: Container(),
                ),
          body: widget.child,
        ),
      ),
    );
  }
}
