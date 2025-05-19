import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/core/routes.dart';
import 'package:hestia/presentation/widgets/styled_drawer.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return StyledDrawer(
      header: const  Text(
          'Navigation',
        ),
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            context.go(Routes.home.path);
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications Overview'),
          onTap: () {
            context.go(Routes.notifications.path);
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            context.go(Routes.settings.path);
          },
        ),
        ListTile(
          leading: const Icon(Icons.cookie),
          title: const Text('Cookies'),
          onTap: () {
            context.go(Routes.cookies.path);
          },
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy Policy'),
          onTap: () {
            context.go(Routes.privacy.path);
          },
        ),
        ListTile(
          leading: const Icon(Icons.devices),
          title: const Text('Devices'),
          onTap: () {
            context.go(Routes.devices.path);
          },
        ),
      ],
    );
  }
}
