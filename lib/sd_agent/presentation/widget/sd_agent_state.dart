import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/theme/eleveated_button_style.dart';
import 'package:xbridge/common/utils/NotificationServices.dart';
import 'package:xbridge/common/utils/geofence_helper.dart';
import 'package:xbridge/sign_screen/controller/sign_in_block.dart';
import 'package:xbridge/sign_screen/controller/sign_in_event.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/route_constants.dart';
import '../../../common/theme/styles.dart';
import '../../../common/utils/util.dart';
import '../screen/sd_agent.dart';

class SDAgentState extends State<SDAgent> {
  final TextEditingController searchController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  Future<void> logoutTapped() async {
    Navigator.of(context).pop(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await NotificationService.clearNotifications();
    // await FirebaseMessaging.instance.deleteToken();

    if (!mounted) return;

    context.read<SignInBloc>().add(LogoutEvent(userSysId));

    await flushDatabase();
    await GetIt.I.get<GeoFenceHelper>().geofenceService.stop();

    if (mounted) {
      GoRouter.of(context).pushReplacementNamed(
        RouteConstants.signInRoute,
        extra: {
          "reset": true,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Show alert dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Logout',
                  style: Styles.textStyledarkBlack16dpRegular,
                ),
                content: Text(
                  'Are you sure you want to logout?',
                  style: Styles.textStyledarkBlack13dpRegular,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      logoutTapped();
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the alert dialog
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: AppColors.red,
        child: const Icon(Icons.power_settings_new, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 120.h,
              ),
              TextFormField(
                controller: searchController,
                cursorColor: AppColors.red,
                // initialValue: email,
                validator: (value) {
                  if (value == "") {
                    return 'Search Task';
                  }
                  return null;
                },

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.red),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Search Task",
                  prefixIcon: const Icon(Icons.search),
                  hintStyle: Styles.textStyledarkBlack14dpRegular,
                ),

                onEditingComplete: () {
                  // Move focus to the next TextFormField
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(
                    RouteConstants.taskDetails,
                    queryParameters: {
                      'id': searchController.text,
                    },
                  );
                },
                style: CustomElevatedButtonStyle.primaryButtonStyle(
                  backgroundColor: AppColors.primaryButtonBackgroundColor,
                ),
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4.sp,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
