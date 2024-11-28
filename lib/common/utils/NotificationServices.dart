import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/constants/route_constants.dart';
import 'package:xbridge/common/routes/route_config.dart';
import 'package:xbridge/common/utils/util.dart';

import '../../unassigned_visits/data/model/unassigned_task_entity.dart';
import '../network/api_provider.dart';

class NotificationService {
  //initialising firebase message plugin
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Background Handler Method
  static Future<void> _firebaseBackgroundNotificationHandler(
      RemoteMessage message) async {
    log("Background Notification --> ${message.data.toString()}");
    await Firebase.initializeApp();
  }

  static clearNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  static void _initLocalNotifications(
    RemoteMessage message,
  ) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@drawable/notification_icon');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {
        // handle interaction when app is active for android
        _handleMessage(message);
      },
    );
  }

  static Future<void> init() async {
    await _requestNotificationPermission();

    ///Background Notification service
    FirebaseMessaging.onBackgroundMessage(
        _firebaseBackgroundNotificationHandler);
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // ignore: use_build_context_synchronously
      _handleMessage(initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _handleMessage(event);
    });
    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;

      if (kDebugMode) {
        if (notification != null) {
          print("notifications title:${notification.title}");
          print("notifications body:${notification.body}");
          print('data:${getJson(message.data)}');
        }
      }
      _initLocalNotifications(message);
      if (Platform.isAndroid) {
        _showNotification(message);
      } else {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    });
    debugPrint("NOTIFICATION INITIATED");
  }

  static Future<void> _requestNotificationPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  // function to show visible notification when app is active
  static Future<void> _showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    //const RawResourceAndroidNotificationSound('jetsons_doorbell'));

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      DateTime.now().millisecondsSinceEpoch.toString(),
      channel.name.toString(),
      channelDescription: channel.description.toString(),
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      sound: channel.sound,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    getJson(message.data, name: "Notification Payload Data");
    getJson(
      message.toMap(),
      name: "Notification Data",
    );
    if (message.data.isNotEmpty && message.data['otherData'] != null) {
      var dataValue = message.data['otherData'];

      var data = json.decode(dataValue);

      var screenName = data["screen"];

      if (screenName == "chat") {
        Future.delayed(Duration.zero, () {
          _flutterLocalNotificationsPlugin.show(
            message.hashCode,
            message.notification!.title.toString(),
            message.notification!.body.toString(),
            notificationDetails,
            payload: jsonEncode(dataValue),
          );
        });
      }
    } else if (message.notification != null) {
      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
          message.hashCode,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
          payload: jsonEncode(message.data),
        );
      });
    } else {
      Fluttertoast.showToast(msg: "No Payload Found in Push Notification!");
    }
  }

  //function to get device token on which we will send the notifications
  static Future<String?> getDeviceToken() async {
    String? token = await _messaging.getToken();

    return token;
  }

  void isTokenRefresh() async {
    _messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  static Future<void> _handleMessage(RemoteMessage message) async {
    if (message.data.containsKey("notification_type")) {
      final type = message.data['notification_type']
          .toString()
          .toLowerCase()
          .replaceAll(" ", "_");

      debugPrint("Type: $type");
      final Map<String, dynamic> payload = jsonDecode(message.data['payload']);
      switch (type) {
        /// FE NOTIFICATION
        case NotificationType.taskAssigned:
          AppRouter.router.pushReplacement(
            "/${RouteConstants.tabBar}",
            extra: {
              "index": "1",
            },
          );
          feTaskListNewTabRefreshIndicator.value = true;
          // showLoading(value: true);
          // final response = await GetIt.I
          //     .get<APIProvider>()
          //     .getMethod(APIConstant.API_Task_Details + payload['sys_id']);
          // if (response != null && userType == UserType.fe) {
          //   final data = UnassignedTaskResult.fromJson(response);
          //   showLoading(value: false);
          //   AppRouter.router.goNamed(
          //     RouteConstants.taskDetails,
          //     queryParameters: {
          //       "id": payload['sys_id'],
          //       "showScheduleBtn": "false",
          //     },
          //     extra: data,
          //   );
          // } else {
          //   showLoading(value: false);
          //   Fluttertoast.showToast(msg: "Please Login As Field Engineer");
          // }
          break;
        case NotificationType.taskAccepted:
          showLoading(value: true);
          final response = await GetIt.I
              .get<APIProvider>()
              .getMethod(APIConstant.API_Task_Details + payload['sys_id']);

          final data = UnassignedTaskResult.fromJson(response);
          showLoading(value: false);
          AppRouter.router.goNamed(
            RouteConstants.taskDetails,
            queryParameters: {
              "id": payload['sys_id'],
              "showScheduleBtn": "false",
            },
            extra: data,
          );

          break;
        case NotificationType.visitConfirmation:
          if (userType == UserType.fe) {
            AppRouter.router.goNamed(
              RouteConstants.reConfirmTask,
              extra: payload,
            );
          } else {
            showLoading(value: false);
            if (userType == UserType.fm) {
              Fluttertoast.showToast(msg: "Please Login As Field Engineer");
            } else {
              Fluttertoast.showToast(
                  msg: "Please Re-direct to manager Task Details");
            }
          }
          break;

        /// FM Notifications
        case NotificationType.arrivalTime:
          showLoading(value: true);
          final response = await GetIt.I
              .get<APIProvider>()
              .getMethod(APIConstant.API_Task_Details + payload['sys_id']);
          if (response != null && userType == UserType.fm) {
            final data = UnassignedTaskResult.fromJson(response);
            showLoading(value: false);
            AppRouter.router.goNamed(
              RouteConstants.taskDetails,
              queryParameters: {
                "id": payload['sys_id'],
                "showScheduleBtn": "false",
              },
              extra: data,
            );
          } else {
            showLoading(value: false);
            Fluttertoast.showToast(msg: "Please Login As Vendor Manager");
          }
          break;
        case NotificationType.travelStartTime:
          showLoading(value: true);
          final response = await GetIt.I
              .get<APIProvider>()
              .getMethod(APIConstant.API_Task_Details + payload['sys_id']);
          if (response != null && userType == UserType.fm) {
            final data = UnassignedTaskResult.fromJson(response);
            showLoading(value: false);
            AppRouter.router.goNamed(
              RouteConstants.taskDetails,
              queryParameters: {
                "id": payload['sys_id'],
                "openFEDetails": "true",
                "showScheduleBtn": "false",
              },
              extra: data,
            );
          } else {
            showLoading(value: false);
            Fluttertoast.showToast(msg: "Please Login As Vendor Manager");
          }
        case NotificationType.newCaseOpened:
          showLoading(value: true);
          final response = await GetIt.I
              .get<APIProvider>()
              .getMethod(APIConstant.API_Task_Details + payload['sys_id']);
          if (response != null && userType == UserType.fm) {
            final data = UnassignedTaskResult.fromJson(response);
            showLoading(value: false);
            AppRouter.router.goNamed(
              RouteConstants.taskDetails,
              queryParameters: {
                "id": payload['sys_id'],
                "showScheduleBtn": "true",
              },
              extra: data,
            );
          } else {
            showLoading(value: false);
            Fluttertoast.showToast(msg: "Please Login As Vendor Manager");
          }
        case NotificationType.taskRejected:
          showLoading(value: true);
          final response = await GetIt.I
              .get<APIProvider>()
              .getMethod(APIConstant.API_Task_Details + payload['sys_id']);
          if (response != null && userType == UserType.fm) {
            final data = UnassignedTaskResult.fromJson(response);
            showLoading(value: false);
            AppRouter.router.goNamed(
              RouteConstants.taskDetails,
              queryParameters: {
                "id": payload['sys_id'],
                "showScheduleBtn": "true",
              },
              extra: data,
            );
          } else {
            showLoading(value: false);
            Fluttertoast.showToast(msg: "Please Login As Vendor Manager");
          }
          break;
        case NotificationType.newVideoCall:
          await launchUrl(
            Uri.parse(payload['url']),
            mode: LaunchMode.externalApplication,
          );
          break;

        default:
      }
    } else {
      debugPrint("tapped on notifications");
      var dataValue = message.data['otherData'];
      var data = json.decode(dataValue);
      getJson(data);
      var screenName = data["screen"];
      if (screenName == "chat") {
        var groupId = data["groupId"];
        var groupName = data["groupName"];
        // var userName = data["userName"];
        List<dynamic> tokens = data["deviceToken"];

        List<String> tokenList = tokens.map((item) => item.toString()).toList();
        // tokenList.removeWhere((element) => element == userDeviceToken);
        if (groupId != currentActiveChatGroupId) {
          AppRouter.router.pushNamed(
            RouteConstants.chatPage,
            extra: {
              "groupId": groupId,
              "groupName": groupName,
              "userName": userName,
              "deviceToken": tokenList,
            },
          );
        }
      }
    }
  }
}

class NotificationType {
  static const taskAssigned = "task_assigned";
  static const arrivalTime = "arrival_time";
  static const travelStartTime = "travel_start_time";
  static const newVideoCall = "new_video_call";
  static const taskRejected = "task_rejected";
  static const taskAccepted = "task_accepted";
  static const newCaseOpened = "new_case_opened";
  static const visitConfirmation = "visit_confirmation";
}
