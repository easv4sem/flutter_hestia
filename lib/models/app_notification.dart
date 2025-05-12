
import 'package:flutter/material.dart';
import 'package:hestia/models/app_notification_item.dart';

/// This class manages the state of app notifications.
/// It allows adding, removing, and clearing notifications.
/// It uses the ChangeNotifier mixin to notify listeners of changes.
class AppNotification extends ChangeNotifier {

  final List<AppNotificationItem> _notifications = [];
 
  /// Getter to retrieve the list of notifications
  List<AppNotificationItem> get notifications => _notifications;

  /// Getter to retrieve a list of unread notifications
  List <AppNotificationItem> get unreadNotifications =>
      _notifications.where((notification) => !notification.isRead).toList();

  /// Getter to retrieve a count of unread notifications
  int get unreadCount => unreadNotifications.length;

  /// Adds a new notification to the list
   void addNotification(AppNotificationItem appNotification) {
    _notifications.add(appNotification);
    notifyListeners();
  }

  /// Removes a notification from the list
  void removeNotification(AppNotificationItem appNotification) {
    _notifications.remove(appNotification);
    notifyListeners();
  }

  /// Clears all notifications from the list
  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}