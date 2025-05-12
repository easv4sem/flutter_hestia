import 'package:flutter/foundation.dart';
import 'package:hestia/models/enum_app_notification_type.dart';

class AppNotificationItem extends ChangeNotifier {
  final String title;
  final String subtitle;
  final EnumAppNotificationType type;
  bool isRead;

  AppNotificationItem({
    required this.title,
    required this.subtitle,
    required this.type,
    this.isRead = false,
  });

  set read(bool value) {
    isRead = value;
    notifyListeners();
  }
  
}
