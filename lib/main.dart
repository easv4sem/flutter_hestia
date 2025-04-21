import 'package:flutter/material.dart';
import 'package:hestia/core/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp.router(routerConfig: AppRouter.router);
  }
}

