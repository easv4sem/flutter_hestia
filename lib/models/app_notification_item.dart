import 'package:flutter/foundation.dart';
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:intl/intl.dart';

class AppNotificationItem extends ChangeNotifier {
  final String title;
  final String subtitle;
  final EnumAppNotificationType type;
  DateTime date;
  final String formatted = DateFormat('HH:mm:ss - dd/MM/yyyy').format(DateTime.now());
  bool isRead;

  AppNotificationItem({
    required this.title,
    required this.subtitle,
    required this.type,
    DateTime? date,
    this.isRead = false,
  }) : date = date ?? DateTime.now();

  set read(bool value) {
    isRead = value;
    notifyListeners();
  }
  
}
