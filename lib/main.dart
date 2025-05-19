import 'package:flutter/material.dart';
import 'package:hestia/auth/auth_provider.dart';
import 'package:hestia/core/router.dart';
import 'package:hestia/core/app_constants.dart';
import 'package:hestia/models/app_notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:hestia/device/data/provider/device_provider.dart';
import 'dart:async';

final StreamController<String> notificationController =
    StreamController<String>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthState.instance.loadStatus();
  await DeviceProvider.instance.loadDevices();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthState>.value(value: AuthState.instance),
        ChangeNotifierProvider<DeviceProvider>.value(
          value: DeviceProvider.instance,
        ),
        ChangeNotifierProvider<AppNotificationProvider>.value(
          value: AppNotificationProvider.instance,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
    );
  }
}
