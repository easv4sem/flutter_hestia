import 'package:flutter/material.dart';
import 'package:hestia/auth/auth_service.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthService authService = AuthService();

  void _logout() async {
    final success = await authService.logout();
    if (success) {
      // Handle successful logout (e.g., navigate to login page)
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayoutWidget(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ElevatedButton(onPressed: _logout, child: Text("Logout"))],
        ),
      ),
    );
  }
}
