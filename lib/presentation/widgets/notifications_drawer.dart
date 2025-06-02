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
  State<NotificationsDrawer> createState() => _NotificationsDrawerState();
}

class _NotificationsDrawerState extends State<NotificationsDrawer> {
  bool _showClearedMessage = false;

  void _handleClearAll(AppNotificationProvider notifications) {
    notifications.markAllAsRead();
    debugPrint('All notifications cleared');

    setState(() => _showClearedMessage = true);

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _showClearedMessage = false);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<AppNotificationProvider>();
    final sortedUnreadNotifications = List.from(notifications.unreadNotifications)
      ..sort((a, b) => b.date.compareTo(a.date));

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
          onTap: () => _handleClearAll(notifications),
        ),
        if (_showClearedMessage)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              '🎉 All cleared! 🎉',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ...List.generate(sortedUnreadNotifications.length, (index) {
          final item = sortedUnreadNotifications[index];

          if (item.isRead) {
            return const SizedBox.shrink();
          }

          return NotificationTile(
            title: item.title,
            subtitle: item.subtitle,
            icon: getNotificationIcon(item.type),
            tileColor: AppColors.backgroundColor,
            onPressed: () {
              notifications.markAsRead(item);
              item.isRead = true;
              debugPrint('Notification removed: ${item.title} : ${item.isRead}');
            },
          );
        }),
      ],
    );
  }

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
