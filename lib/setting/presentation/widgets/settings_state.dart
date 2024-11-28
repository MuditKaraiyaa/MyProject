// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart' as handler;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/NotificationServices.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/sign_screen/controller/sign_in_block.dart';
import 'package:xbridge/sign_screen/controller/sign_in_event.dart';

import '../../../common/constants/globals.dart';
import '../../../common/utils/geofence_helper.dart';
import '../../../location_update/controller/location_permission_bloc.dart';
import '../../../main.dart';
import '../screen/settings_listing.dart';

class SettingsListingState extends State<SettingsListing> with WidgetsBindingObserver {
  SettingsListingState();

  bool isLocationEnabled = false;

  Future<void> logoutTapped() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await NotificationService.clearNotifications();
    // await FirebaseMessaging.instance.deleteToken();

    if (!mounted) return;

    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }

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

  void showPermissionDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'Location Permission',
            style: Styles.textStyledarkBlack14dpBold,
          ),
          content: Text(
            'Please go to settings and allow location access.',
            style: Styles.textStyledarkBlack14dpRegular,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<LocationPermissionBloc>().add(LocationPermissionExtraEvent());
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openAppSettings();
              },
              child: const Text('Go to Settings'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final granted = await Permission.location.isGranted;
      if (granted) {
        context.read<LocationPermissionBloc>().add(
              LocationPermissionUpdateEvent(status: true),
            );
      } else {
        context.read<LocationPermissionBloc>().add(
              LocationPermissionUpdateEvent(status: false),
            );
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BlocConsumer<LocationPermissionBloc, LocationPermissionState>(
            listener: (context, state) {
              if (state is LocationPermissionError && state.message == 'deniedForever') {
                showPermissionDialog();
              }
            },
            builder: (context, state) {
              bool isSwitchEnabled = state is LocationPermissionCheck && state.isEnable;
              return Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  trailing: CupertinoSwitch(
                    activeColor: AppColors.red,
                    value: isSwitchEnabled,
                    onChanged: (value) async {
                      if (value) {
                        final isPermanentlyOrDenied =
                            await handler.Permission.location.isPermanentlyDenied ||
                                await handler.Permission.location.isDenied;

                        logger.i("IsPermanentlyDenied: $isPermanentlyOrDenied");
                        if (isPermanentlyOrDenied) {
                          showDeniedDialog();
                          return;
                        }
                        var status = await handler.Permission.location.request();

                        if (status.isGranted) {
                          context.read<LocationPermissionBloc>().add(
                                LocationPermissionUpdateEvent(
                                  status: value,
                                ),
                              );
                        }
                      } else {
                        await showDisableDialog();
                      }
                    },
                  ),
                  title: Text(
                    'Location',
                    style: Styles.textStyledarkBlack18dpRegular,
                  ),
                ),
              );
            },
          ),
          InkWell(
            onTap: () {
              if (kDebugMode) {
                print("Password Changed");
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListTile(
                trailing: SvgPicture.asset(
                  'assets/settings/setting_reset_password.svg',
                  height: 30.h,
                ),
                title: Text(
                  'Reset Password',
                  style: Styles.textStyledarkBlack18dpRegular,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => logoutTapped(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListTile(
                trailing: SvgPicture.asset(
                  AppImage.logOut,
                  height: 22.h,
                ),
                title: Text(
                  'Logout',
                  style: Styles.textStyledarkBlack18dpRegular,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showResetSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30.h),
              Text(
                'Your Password Reset successfully.',
                style: Styles.textStyledarkBlack13dpRegular,
              ),
              SizedBox(height: 50.h),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  'OK',
                  style: Styles.textStyledarkWhite13dpRegular,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool?> showDeniedDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Denied"),
        content:
            const Text("The user has denied location access. Please proceed to the app settings."),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Close")),
          TextButton(
            onPressed: () async {
              final res = await Geolocator.openAppSettings();
              if (res) {
                final status = await Permission.location.isDenied;
                if (status) {
                  if (mounted) {
                    Navigator.of(context).pop(true);
                    context.read<LocationPermissionBloc>().add(
                          LocationPermissionUpdateEvent(
                            status: false,
                          ),
                        );
                  }
                  return;
                }
              }
              if (mounted) {
                Navigator.of(context).pop(false);
              }
            },
            child: const Text("Settings"),
          ),
        ],
      ),
    );
  }

  Future<bool?> showDisableDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Disable Location"),
        content:
            const Text("To deactivate location services, please navigate to the app settings."),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Close")),
          TextButton(
            onPressed: () async {
              context.read<LocationPermissionBloc>().add(
                    LocationPermissionUpdateEvent(status: false),
                  );
              final res = await handler.openAppSettings();
              Navigator.of(context).pop(false);
            },
            child: const Text("Settings"),
          ),
        ],
      ),
    );
  }
}
