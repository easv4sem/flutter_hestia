import 'package:flutter/material.dart';
import 'package:hestia/models/app_notification_item.dart';
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:hestia/service/api_service.dart';

/// This class manages the state of app notifications.
/// It allows adding, removing, and clearing notifications.
/// It uses the ChangeNotifier mixin to notify listeners of changes.
class AppNotificationProvider extends ChangeNotifier {
  /// Singleton instance of AppNotification
  AppNotificationProvider._internal();
  static final AppNotificationProvider _instance =
      AppNotificationProvider._internal();
  static AppNotificationProvider get instance => _instance;

  final List<AppNotificationItem> _notifications = [];
  final List<AppNotificationItem> _unreadNotifications = [];

  bool _isLoading = false;

  /// Getter to check if notifications are currently loading
  bool get isLoading => _isLoading;

  /// Getter to retrieve the list of notifications
  List<AppNotificationItem> get notifications => _notifications;
  List<AppNotificationItem> get unreadNotifications => _unreadNotifications;

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

    print(item.toJson());

    _notifications.add(item);

    setAsRead(item);

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
    return _notifications
        .where(
          (n) =>
              n.date.year == now.year &&
              n.date.month == now.month &&
              n.date.day == now.day,
        )
        .length;
  }

  /// Count of notifications from the last 7 days (including today)
  int get last7DaysCount {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(Duration(days: 6)); // includes today
    return _notifications
        .where(
          (n) =>
              n.date.isAfter(
                DateTime(
                  sevenDaysAgo.year,
                  sevenDaysAgo.month,
                  sevenDaysAgo.day,
                ),
              ) ||
              n.date.isAtSameMomentAs(
                DateTime(
                  sevenDaysAgo.year,
                  sevenDaysAgo.month,
                  sevenDaysAgo.day,
                ),
              ),
        )
        .length;
  }

  Future<void> markAllAsRead() async {
    for (var notification in _unreadNotifications.toList()) {
      markAsRead(notification);
    }
    _unreadNotifications.clear();
    notifyListeners();
  }

  Future<void> setAsRead(AppNotificationItem notification) async {
    try {
      final response = await ApiService().put(
        '/notifications',

        notification.toJson(),
      );

      print(response.data);
      print(response.statusCode);

      if (response.statusCode == 200) {
        notification.isRead = true;
        _unreadNotifications.remove(notification);
        notifyListeners();
      } else {
        throw Exception(
          'Failed to mark notification as read.: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("Error in setAsRead: $e");
    }
  }

  /// Loads notifications from the API
  /// This method fetches notifications from the server and updates the local list.
  /// It handles errors and updates the loading state.
  Future<void> loadNotifications() async {
    setIsLoading(true);

    try {
      final response = await ApiService().get('/notifications');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        _notifications.clear();
        _unreadNotifications.clear();

        for (var item in data) {
          final notification = AppNotificationItem(
            piUniqueIdentifier: item['PiUniqeIdentifier'],
            uniqueId: item['UniqueIdentifier'],
            title: item['Title'],
            subtitle: item['SubTitle'] ?? "No subtitle",
            type: _parseNotificationType(item['Type']),
            isRead: item['IsRead'] ?? false,
            date:  DateTime.parse(item['DateCreated']).toLocal(),
          );
          print(notification.toJson());
          addNotification(notification);
        }
      } else {
        throw Exception(
          'Failed to load notifications.: ${response.statusCode}',
        );
      }
    } catch (e) {
      print("Error loading notifications: $e");
      clearNotifications();
    }
    setIsLoading(false);
  }

  /// Refreshes the notifications by reloading them from the API
  Future<void> refreshNotifications() async {
    await loadNotifications();
  }

  void setIsLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// What the fuck.
  EnumAppNotificationType _parseNotificationType(dynamic value) {
    try {
      int? index;
      if (value is int) {
        index = value;
      } else if (value is String) {
        index = int.tryParse(value);
      }

      if (index != null &&
          index >= 0 &&
          index < EnumAppNotificationType.values.length) {
        return EnumAppNotificationType.values[index];
      }
    } catch (_) {}

    return EnumAppNotificationType.info; // default fallback
  }
}
