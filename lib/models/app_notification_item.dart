import 'package:flutter/foundation.dart';
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:intl/intl.dart';

class AppNotificationItem extends ChangeNotifier {
  final String uniqueId;
  final String title;
  final String subtitle;
  final EnumAppNotificationType type;
  DateTime date;
  bool isRead;
  String formatted;

  AppNotificationItem({
    required this.uniqueId,
    required this.title,
    required this.subtitle,
    required this.type,
    DateTime? date,
    this.isRead = false,
    String? formatted,
  }) : date = date ?? DateTime.now(),
       formatted =
           formatted ??
           DateFormat('HH:mm:ss - dd/MM/yyyy').format(date ?? DateTime.now());

  set read(bool value) {
    isRead = value;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'notification': {
      'UniqueIdentifier': uniqueId,
      'Title': title,
      'Subtitle': subtitle,
      'Type': type.name,
      'IsRead': isRead,
      'DateCreated': date.toIso8601String()
      }
    };
  }
}
