import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:xbridge/chat_page/presentation/widget/chat_provider.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/utils/geofence_helper.dart';
import 'package:xbridge/common/utils/shared_pref_helper.dart';
import 'package:xbridge/firebase_options.dart';
import 'package:xbridge/location_update/controller/location_permission_bloc.dart';

import 'chat_page/presentation/widget/auth_provider.dart';
import 'common/constants/constants.dart';
import 'common/network/api_provider.dart';
import 'common/routes/route_config.dart';
import 'common/utils/util.dart';
import 'location_update/data/repository/location_repository.dart';
import 'sign_screen/controller/sign_in_block.dart';
import 'sign_screen/controller/sign_in_event.dart';
import 'sign_screen/data/repositories/sign_in_repositories.dart';

// Main function to start the app
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize Firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Setup dependency injections
  setupInjections();
  // Initialize database
  initDatabase();
  // Retrieve device token for push notifications
  getDeviceToken();

  // Run the app
  runApp(MyApp());
}

// Background message handler for Firebase Cloud Messaging
Future<void> backGroundHandler(RemoteMessage message) async {
  // Print received background message
  print("Background Message received: ${message.notification?.title}");
  // Debug print notification title
  debugPrint(message.notification?.title);
  // Debug print notification body
  debugPrint(message.notification?.body);
  // Debug print data payload
  debugPrint(message.data.toString());
}

// Main application widget
class MyApp extends StatelessWidget {
  // Constructor
  MyApp({super.key});
  // Initialize Firestore instance
  final _firebaseFirestore = FirebaseFirestore.instance;
  // Initialize Firebase storage instance
  final _firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    // MultiProvider for managing multiple providers
    return MultiProvider(
      providers: [
        // Provider for authentication
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            firebaseAuth: FirebaseAuth.instance,
            prefs: GetIt.I.get<SharedPrefHelper>(),
            firebaseFirestore: _firebaseFirestore,
          ),
        ),
        // Provider for chat functionality
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            firebaseFirestore: _firebaseFirestore,
            firebaseStorage: _firebaseStorage,
          ),
        ),
        // BlocProvider for location permission management
        BlocProvider<LocationPermissionBloc>(
          create: (_) => LocationPermissionBloc(
            prefHelper: GetIt.I.get<SharedPrefHelper>(),
            repository: LocationRepositoryImpl(
              provider: GetIt.I.get<APIProvider>(),
            ),
          ),
        ),
        // BlocProvider for sign-in functionality
        BlocProvider(
          create: (_) => SignInBloc(
            repository: SignInRepositoryImpl(
              provider: GetIt.I.get<APIProvider>(),
              prefHelper: GetIt.I.get<SharedPrefHelper>(),
            ),
          )..add(GetAccessTokenEvent()), // Add initial event
        ),
      ],
      // Wrap app with foreground task handler
      child: WillStartForegroundTask(
        onWillStart: () async {
          // Condition for starting foreground task
          return GetIt.I.get<GeoFenceHelper>().geofenceService.isRunningService;
        },
        // Android notification options
        androidNotificationOptions: AndroidNotificationOptions(
          channelId: 'geofence_service_notification_channel',
          channelName: 'Geofence Service Notification',
          channelDescription:
              'This notification appears when the geofence service is running in the background.',
          channelImportance: NotificationChannelImportance.LOW,
          priority: NotificationPriority.LOW,
          isSticky: false,
        ),
        // iOS notification options
        iosNotificationOptions: const IOSNotificationOptions(),
        // Foreground task options
        foregroundTaskOptions: const ForegroundTaskOptions(),
        // Notification title
        notificationTitle: 'Location Service is running',
        // Notification text
        notificationText: 'Tap to return to the app',
        // Initialize ScreenUtil
        child: ScreenUtilInit(
          designSize: getDeviceSize(context),
          splitScreenMode: true,
          // MaterialApp with router
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            // Initialize EasyLoading
            builder: EasyLoading.init(),
            // App title
            title: Constants.appName,
            // Theme data
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                surfaceTint: Colors.white,
                surface: Colors.white,
                seedColor: AppColors.red,
                onBackground: AppColors.white,
                background: AppColors.white,
                onTertiary: Colors.white,
                tertiaryContainer: const Color.fromARGB(255, 63, 53, 53),
                onSecondaryContainer: Colors.white,
                tertiary: Colors.white,
              ),
            ),
            // Router configuration
            routerConfig: AppRouter.router,
          ),
        ),
      ),
    );
  }
}

var logger= Logger();