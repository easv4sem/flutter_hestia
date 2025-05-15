import 'package:flutter/material.dart';
import 'package:hestia/models/enum_app_notification_type.dart';

/// <--- Change colors here to update the app's theme. --->
/// 
/// This class defines a set of colors used throughout the app.
/// It includes primary colors, text colors, and feedback colors.
/// The colors are defined as static constants for easy access.
/// 
class AppColors {
  // Primary colors
  static const primaryColor = Color.fromARGB(255, 246, 125, 32);
  static const secondaryColor = Color(0xFF4A4A4A);
  static const accentColor = Color.fromARGB(255, 217, 217, 217);
  static const backgroundColor = Colors.white;

  // Text colors
  static const textColorDark = Color(0xFF4A4A4A);
  static const textColorLight = Color.fromARGB(255, 255, 255, 255);

  // Feedback colors
  static const error = Colors.orange;
  static const warning =  Colors.yellow;
  static const info = Colors.blue;
  static const success = Colors.green;
  static const fire = Color(0xFFB71C1C);
  static const offline = Colors.grey; 


  static Color getNotificationColorByType(EnumAppNotificationType type) {
    switch (type) {
      case EnumAppNotificationType.error:
        return error;
      case EnumAppNotificationType.warning:
        return warning;
      case EnumAppNotificationType.info:
        return info;
      case EnumAppNotificationType.success:
        return success;
      case EnumAppNotificationType.fire:
        return fire;
      case EnumAppNotificationType.offline:
        return offline;
      default:
        return Colors.grey;
    }
  }
}