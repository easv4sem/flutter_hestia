import 'package:flutter/material.dart';
import 'package:hestia/presentation/widgets/main_drawer.dart';
import 'app_bar_widget.dart';

class MainLayoutWidget extends StatelessWidget {
  final Widget body;

  const MainLayoutWidget({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(),
      drawer: MainDrawer(),
      body: body,
    );
  }
}
