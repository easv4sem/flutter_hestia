import 'package:flutter/material.dart';
import 'package:hestia/models/app_notification_provider.dart';
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:hestia/theme/colors.dart';
import 'package:hestia/theme/icons.dart';
import 'package:hestia/presentation/widgets/notification_tile.dart';
import 'package:hestia/presentation/widgets/styled_drawer.dart';
import 'package:provider/provider.dart';

class NotificationsDrawer extends StatefulWidget {
  const NotificationsDrawer({super.key});

  @override
  _NotificationsDrawerState createState() => _NotificationsDrawerState();
}

class _NotificationsDrawerState extends State<NotificationsDrawer> {
  // Simulate fetching notifications

  @override
  void initState() {
    super.initState();
  }

  @override
Widget build(BuildContext context) {
  final notifications = context.watch<AppNotificationProvider>();

  // Sort unread notifications by newest first
  final sortedUnreadNotifications = List.from(notifications.unreadNotifications)
    ..sort((a, b) => b.date.compareTo(a.date)); // Use `now` timestamp

  return StyledDrawer(
    header: const Text(
      'Notifications',
      style: TextStyle(color: Colors.white, fontSize: 24),
    ),
    children: [
      ListTile(
        title: const Text(
          'Clear All',
          style: TextStyle(color: AppColors.textColorDark),
        ),
        onTap: () {
          notifications.markAllAsRead();
          debugPrint('All notifications cleared');
        },
      ),

      ...List.generate(sortedUnreadNotifications.length, (index) {
        final item = sortedUnreadNotifications[index];

        if (item.isRead) {
          return const SizedBox.shrink(); // Skip read notifications
        }

        return NotificationTile(
          title: item.title,
          subtitle: item.subtitle,
          icon: getNotificationIcon(item.type),
          tileColor: AppColors.backgroundColor,
          onPressed: () {
            notifications.markAsRead(item);
            item.isRead = true;
            debugPrint(
              'Notification removed: ${item.title} : ${item.isRead}',
            );
          },
        );
      }),
    ],
  );
}


/// Function to get the icon based on notification type
/// This function maps the EnumAppNotificationType to the corresponding icon.
/// It defaults to a HELP icon if the type is not recognized.
  IconData getNotificationIcon(EnumAppNotificationType type) {
    switch (type) {
      case EnumAppNotificationType.error:
        return AppIcons.error;
      case EnumAppNotificationType.warning:
        return AppIcons.warning;
      case EnumAppNotificationType.info:
        return AppIcons.info;
      case EnumAppNotificationType.success:
        return AppIcons.success;
      case EnumAppNotificationType.fire:
        return AppIcons.fire;
      case EnumAppNotificationType.offline:
        return AppIcons.offline;
      case EnumAppNotificationType.notification:
        return AppIcons.notificationBell;
      default:
        return AppIcons.help;
    }
  }
}
