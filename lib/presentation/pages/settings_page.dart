import 'package:flutter/material.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayoutWidget(
      title: 'Settings',
      body: const Center(
        child: Text('Settings Page'),
      ),
    );
  }
}