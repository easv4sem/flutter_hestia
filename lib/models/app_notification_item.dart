import 'package:flutter/foundation.dart';
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:intl/intl.dart';

class AppNotificationItem extends ChangeNotifier {
  final String title;
  final String subtitle;
  final EnumAppNotificationType type;
  final DateTime now = DateTime.now();
  final String formatted = DateFormat('HH:mm:ss - dd/MM/yyyy').format(DateTime.now());
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
