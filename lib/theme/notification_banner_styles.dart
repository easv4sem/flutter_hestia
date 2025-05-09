import 'package:flutter/material.dart';
import 'package:hestia/theme/colors.dart';
import 'package:hestia/theme/icons.dart';

/// Defines the types of notification banners available in the app.
/// Each type maps to a specific color and icon style.
enum NotificationBannerType {
  /// Represents an error notification.
  error,
  /// Represents a warning notification.
  warning,
  /// Represents an informational notification.
  info,
  /// Represents a success notification.
  success,
  /// Represents a fire detection notification.
  fire,
  /// Represents an offline device notification.
  offline
}

class BannerStyles {
  final Map<NotificationBannerType, Color> backgroundColors = {
    NotificationBannerType.error: AppColors.error,
    NotificationBannerType.warning: AppColors.warning,
    NotificationBannerType.info: AppColors.info,
    NotificationBannerType.success: AppColors.success,
    NotificationBannerType.fire: AppColors.fire,
    NotificationBannerType.offline: AppColors.offline,
  };

  final Map<NotificationBannerType, Color> textColors = {
    NotificationBannerType.error: AppColors.textColorDark,
    NotificationBannerType.warning: AppColors.textColorDark,
    NotificationBannerType.info: AppColors.textColorLight,
    NotificationBannerType.success: AppColors.textColorLight,
    NotificationBannerType.fire: AppColors.textColorLight,
    NotificationBannerType.offline: AppColors.textColorDark,
  };

  final Map<NotificationBannerType, IconData> icons = {
    NotificationBannerType.error: AppIcons.error,
    NotificationBannerType.warning: AppIcons.warning,
    NotificationBannerType.info: AppIcons.info,
    NotificationBannerType.success: AppIcons.success,
    NotificationBannerType.fire: AppIcons.fire,
    NotificationBannerType.offline: AppIcons.offline,
  };

  final Map<NotificationBannerType, String> messages  = {
    NotificationBannerType.error: "Error! ",
    NotificationBannerType.warning: "Warning! ",
    NotificationBannerType.info: "Information: ",
    NotificationBannerType.success: "Success! ",
    NotificationBannerType.fire: "Fire Detected! ",
    NotificationBannerType.offline: "Device Offline: ",
  };
}