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
        {'title': 'New Notification 4', 'subtitle': 'Description of notification 4', 'icon': AppIcons.notificationBell, 'tileColor': AppColors.info},
        {'title': 'New Notification 5', 'subtitle': 'Description of notification 5', 'icon': AppIcons.fire, 'tileColor': AppColors.fire},
        {'title': 'New Notification 7', 'subtitle': 'Description of notification 7', 'icon': AppIcons.warning, 'tileColor': AppColors.warning},
        {'title': 'New Notification 8', 'subtitle': 'Description of notification 8', 'icon': AppIcons.error, 'tileColor': AppColors.error},
        {'title': 'New Notification 9', 'subtitle': 'Description of notification 9', 'icon': AppIcons.notificationBell, 'tileColor': AppColors.info},
        {'title': 'New Notification 10', 'subtitle': 'Description of notification 10', 'icon': AppIcons.fire, 'tileColor': AppColors.fire},
        {'title': 'New Notification 11', 'subtitle': 'Description of notification 11', 'icon': AppIcons.warning, 'tileColor': AppColors.warning},
        {'title': 'New Notification 12', 'subtitle': 'Description of notification 12', 'icon': AppIcons.error, 'tileColor': AppColors.error},
        {'title': 'New Notification 13', 'subtitle': 'Description of notification 13', 'icon': AppIcons.notificationBell, 'tileColor': AppColors.info},
        {'title': 'New Notification 14', 'subtitle': 'Description of notification 14', 'icon': AppIcons.fire, 'tileColor': AppColors.fire},
        {'title': 'New Notification 15', 'subtitle': 'Description of notification 15', 'icon': AppIcons.warning, 'tileColor': AppColors.warning},
        {'title': 'New Notification 16', 'subtitle': 'Description of notification 16', 'icon': AppIcons.error, 'tileColor': AppColors.error},
        {'title': 'New Notification 17', 'subtitle': 'Description of notification 17', 'icon': AppIcons.notificationBell, 'tileColor': AppColors.info},
        {'title': 'New Notification 18', 'subtitle': 'Description of notification 18', 'icon': AppIcons.fire, 'tileColor': AppColors.fire},
        {'title': 'New Notification 19', 'subtitle': 'Description of notification 19', 'icon': AppIcons.warning, 'tileColor': AppColors.warning},
        {'title': 'New Notification 20', 'subtitle': 'Description of notification 20', 'icon': AppIcons.error, 'tileColor': AppColors.error},
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
