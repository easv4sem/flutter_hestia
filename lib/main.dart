import 'package:flutter/material.dart';
import 'package:hestia/core/router.dart';
import 'package:hestia/core/app_constants.dart';
import 'package:hestia/models/app_notification.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      // The main function is the entry point of the application.
      // It initializes the app and sets up the provider for state management.
      // The ChangeNotifierProvider is used to provide the AppNotification class
      ChangeNotifierProvider(
        create: (_) => AppNotification(),
        child: const MyApp(),
      )    
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: Text(AppConstants.appName).data.toString(),
      debugShowCheckedModeBanner: false,
    );
  }
}
