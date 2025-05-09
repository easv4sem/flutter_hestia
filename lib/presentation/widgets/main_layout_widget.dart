import 'package:flutter/material.dart';
import 'package:hestia/presentation/widgets/main_drawer.dart';
import 'package:hestia/presentation/widgets/notifications_drawer.dart';
import 'package:hestia/presentation/widgets/styled_drawer.dart';
import 'package:hestia/theme/colors.dart';
import 'app_bar_widget.dart';

class MainLayoutWidget extends StatelessWidget {
  final Widget body;

  const MainLayoutWidget({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: MainAppBarWidget(),
      drawer: MainDrawer(),
      endDrawer: StyledDrawer(),
      body: body,
    );
  }
}
