import 'package:flutter/material.dart';
import 'package:hestia/theme/colors.dart';
import 'package:hestia/theme/icons.dart';
import 'package:hestia/presentation/widgets/notification_tile.dart';
import 'package:hestia/presentation/widgets/styled_drawer.dart';

class NotificationsDrawer extends StatefulWidget {
  const NotificationsDrawer({super.key});

  @override
  _NotificationsDrawerState createState() => _NotificationsDrawerState();
}

class _NotificationsDrawerState extends State<NotificationsDrawer> {
  List<Map<String, dynamic>> notifications = [];

  // Simulate fetching notifications
  Future<void> _fetchNotifications() async {
    await Future.delayed(const Duration(seconds: 0)); // Simulating delay

    setState(() {
      notifications = [
        {'title': 'New Notification 1', 'subtitle': 'Description of notification 1', 'icon': AppIcons.notificationBell, 'tileColor': AppColors.info},
        {'title': 'New Notification 2', 'subtitle': 'Description of notification 2', 'icon': AppIcons.fire, 'tileColor': AppColors.fire},
        {'title': 'New Notification 3', 'subtitle': 'Description of notification 3', 'icon': AppIcons.warning, 'tileColor': AppColors.warning},
        {'title': 'New Notification 6', 'subtitle': 'Description of notification 6', 'icon': AppIcons.error, 'tileColor': AppColors.error},
        // Add more notifications as needed
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return StyledDrawer(
      header: const Text(
        'Notifications',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
      children: List.generate(notifications.length, (index) {
        // Alternate tile colors based on the index dynamically
        //Color tileColor = (index % 2 == 0) ? AppColors.backgroundColor : AppColors.accentColor;

        return NotificationTile(
          title: notifications[index]['title'],
          subtitle: notifications[index]['subtitle'],
          icon: notifications[index]['icon'],
          tileColor: AppColors.backgroundColor, // Assigning color dynamically
        );
      }),
    );
  }
}
