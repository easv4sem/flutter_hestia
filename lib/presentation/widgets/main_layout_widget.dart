import 'package:flutter/material.dart';
import 'package:hestia/presentation/widgets/main_drawer.dart';
import 'app_bar_widget.dart';

class MainLayoutWidget extends StatelessWidget {
  final Widget body;
  final String title;

  const MainLayoutWidget({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(title: title),
      drawer: MainDrawer(),
      body: body,
      
    );
  }
}