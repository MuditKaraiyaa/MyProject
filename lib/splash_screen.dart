import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:xbridge/sign_screen/controller/sign_in_event.dart';

import 'common/constants/globals.dart';
import 'common/constants/route_constants.dart';
import 'common/routes/route_config.dart';
import 'sign_screen/controller/sign_in_block.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), navigate);

    super.initState();
  }

  void navigate() async {
    bool isLoggedIn = await isUserLoggedIn();
    print(">>>>>>>>>>>$isLoggedIn");

    if (isLoggedIn) {
      BlocProvider.of<SignInBloc>(context).add(GetAccessTokenEvent());

      if (userType == UserType.agent) {
        GoRouter.of(context).pushNamed(RouteConstants.sdAgent);
      } else {
        AppRouter.router.pushReplacement(
          "/${RouteConstants.tabBar}",
        );
      }
    } else {
      GoRouter.of(context).pushReplacement(
        "/${RouteConstants.signInRoute}",
        extra: {
          "reset": true,
        },
      );
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Image.asset(
          'assets/splash_background.png',
          fit: BoxFit.fitWidth,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
