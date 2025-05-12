import 'package:hestia/models/enum_app_notification_type.dart';

class AppNotificationItem {
  final String title;
  final String subtitle;
  final EnumAppNotificationType type;
  final bool isRead;

  AppNotificationItem({
    required this.title,
    required this.subtitle,
    required this.type,
    this.isRead = false,
  });
  
}
