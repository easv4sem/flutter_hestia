import 'package:flutter/material.dart';
import 'package:hestia/styles/notification_banner_styles.dart';

/// A helper class to display a notification banner at the top of the screen.
///
/// Provides a consistent UI for alert, warning, info, success, fire, and offline messages
/// using the [MaterialBanner] widget with optional actions.
class ShowNotificationBanner {
  /// Displays a [MaterialBanner] with styles defined by [NotificationBannerType].
  ///
  /// - [context]: The build context to find the nearest [ScaffoldMessenger].
  /// - [type]: The type of banner (e.g., `error`, `warning`, `info`, `success`, `fire`, `offline`).
  ///   This determines the icon, color, and default prefix message.
  /// - [message]: The main message text shown in the banner.
  ///   This is appended after the banner type’s predefined prefix.
  /// - [actionLabel]: Label for the action button (default: `' '`).
  /// - [onAction]: Optional callback when the action button is pressed.
  ///   If not provided, the default action just hides the banner.
  /// 
  ///  Example usage:
  ///
  /// ```dart
  /// ShowNotificationBanner.showNotificationTop(
  ///   context,
  ///   type: NotificationBannerType.warning,
  ///   message: 'This is just a demo warning!',
  ///   actionLabel: 'UNDO',
  ///   onAction: () {
  ///     ScaffoldMessenger.of(context).showSnackBar(
  ///       const SnackBar(content: Text('Undo pressed')),
  ///     );
  ///   },
  /// );
  /// ```
  static void showNotificationTop(
    BuildContext context, {
    required NotificationBannerType type,
    required String message,
    String actionLabel = '',
    VoidCallback? onAction,
  }) {
    final styles = BannerStyles();

    // Clear any existing banner before showing a new one.
    ScaffoldMessenger.of(context).clearMaterialBanners();

    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: styles.backgroundColors[type],
        content: Row(
          children: [
            Icon(styles.icons[type], color: styles.textColors[type]),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                styles.messages[type]! + message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: styles.textColors[type],
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Always hide the banner first
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

              // Then trigger optional action
              if (onAction != null) onAction();
            },
            child: Row(
              children: [
                Icon(Icons.check_circle_outline,
                    color: styles.textColors[type], size: 20),
                const SizedBox(width: 4),
                Text(actionLabel, style: TextStyle(color: styles.textColors[type])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
