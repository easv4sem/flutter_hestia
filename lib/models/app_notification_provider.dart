
import 'package:flutter/material.dart';
import 'package:hestia/models/app_notification_item.dart';

/// This class manages the state of app notifications.
/// It allows adding, removing, and clearing notifications.
/// It uses the ChangeNotifier mixin to notify listeners of changes.
class AppNotificationProvider extends ChangeNotifier {

  /// Singleton instance of AppNotification
  AppNotificationProvider._internal();
  static final AppNotificationProvider _instance = AppNotificationProvider._internal();
  static AppNotificationProvider get instance => _instance;

  final List<AppNotificationItem> _notifications = [];
  final List<AppNotificationItem> _unreadNotifications = [];
 
  /// Getter to retrieve the list of notifications
  List<AppNotificationItem> get notifications => _notifications;
  List <AppNotificationItem> get unreadNotifications => _unreadNotifications;

  /// Adds a new notification to the list
   void addNotification(AppNotificationItem appNotification) {
    _notifications.add(appNotification);
    if (!appNotification.isRead) {
      _unreadNotifications.add(appNotification);
    }
    notifyListeners();
  }

  /// Removes a notification from the list
  void removeNotification(AppNotificationItem appNotification) {
    _notifications.remove(appNotification);
    _unreadNotifications.remove(appNotification);
    notifyListeners();
  }

  void markAsRead(AppNotificationItem appNotification) {
    appNotification.isRead = true;
    AppNotificationItem item = appNotification;

    _notifications.remove(appNotification);
    _notifications.add(item);
    
    _unreadNotifications.remove(appNotification);
    notifyListeners();
  }

  /// Clears all notifications from the list
  void clearNotifications() {
    _notifications.clear();
    _unreadNotifications.clear();
    notifyListeners();
  }

  /// Count of notifications from today
  int get todayCount {
    final now = DateTime.now();
    return _notifications.where((n) =>
      n.date.year == now.year &&
      n.date.month == now.month &&
      n.date.day == now.day
    ).length;
  }

  /// Count of notifications from the last 7 days (including today)
  int get last7DaysCount {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(Duration(days: 6)); // includes today
    return _notifications.where((n) =>
      n.date.isAfter(DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day)) ||
      n.date.isAtSameMomentAs(DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day))
    ).length;
  }
}