import 'package:flutter/material.dart';
import 'package:hestia/auth/auth_provider.dart';
import 'package:hestia/core/router.dart';
import 'package:hestia/core/app_constants.dart';
import 'dart:async';

import 'package:provider/provider.dart';

final StreamController<String> notificationController =
    StreamController<String>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthState.instance.loadStatus(); 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthState>.value(value: AuthState.instance),
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
