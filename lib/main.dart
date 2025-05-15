import 'package:flutter/material.dart';
import 'package:hestia/core/router.dart';
import 'package:hestia/core/app_constants.dart';
import 'package:hestia/models/app_notification.dart';
import 'package:provider/provider.dart';
import 'dart:async';

final StreamController<String> notificationController =
    StreamController<String>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppNotification>.value(
          value: AppNotification.instance,
        ),
      ],
      child: const MyApp(),
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
