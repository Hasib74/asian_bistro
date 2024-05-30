import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:pizza_user_app/src/core/firebase_helper/notification/firebase_notification_service.dart';
import 'package:pizza_user_app/src/core/routing/app_routes.dart';
import 'package:pizza_user_app/src/core/utils/colors/app_colors.dart';
import 'package:pizza_user_app/src/features/auth/repository/device_token_remote_repository.dart';
import 'package:pizza_user_app/src/features/auth/repository/device_token_repository.dart';
import 'package:pizza_user_app/src/features/splash_screen/binding/splash_binding.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBnHCIGAWMso2KdRDUs59mG4_7eHvXYei4",
          appId: "1:278672208239:ios:7abb2f5d644cd58ccab89a",
          messagingSenderId: "278672208239",
          projectId: "chickenbox-e1bbf"));

  DeviceTokenRepository _deviceTokenRepository = DeviceTokenRemoteRepository();
  String? deviceToken = await _deviceTokenRepository.getDeviceToken();
  print("device token is $deviceToken");

  NotificationService.listenNotificationMessage();
  NotificationService.listenForgroundNotificationMessage();
  NotificationService.listenBackgroundNotificationMessage();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.

  //
  // DeviceTokenRepository _deviceTokenRepository = DeviceTokenRemoteRepository();
  // _getToken() async {
  //   String? deviceToken = await _deviceTokenRepository.getDeviceToken();
  //   print("device token is $deviceToken");
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      // statusBarIconBrightness: Brightness.light,
      // statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.primaryColor,
      systemNavigationBarIconBrightness: Brightness.light,

      systemStatusBarContrastEnforced: false,
    ));

    return GetMaterialApp(
      getPages: AppRoutes.appRouets(),
      initialRoute: AppRoutes.INITIAL,
      initialBinding: AppSplashBinding(),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
