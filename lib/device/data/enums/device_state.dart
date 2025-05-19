import 'package:flutter/widgets.dart';

enum DeviceState { online, offline, setup, error, alert }

extension DeviceStateExtension on DeviceState {
  String get name {
    switch (this) {
      case DeviceState.online:
        return 'Online';
      case DeviceState.offline:
        return 'Offline';
      case DeviceState.setup:
        return 'Setup';
      case DeviceState.error:
        return 'Error';
      case DeviceState.alert:
        return 'Alert';
    }
  }

  Color get color {
    switch (this) {
      case DeviceState.online:
        return const Color(0xFF4CAF50); // Green
      case DeviceState.offline:
        return const Color(0xFF9E9E9E); // Grey
      case DeviceState.setup:
        return const Color.fromARGB(155, 115, 85, 175); // Blue
      case DeviceState.error:
        return const Color(0xFFF44336); // Red
      case DeviceState.alert:
        return const Color(0xFFFF9800); // Orange
    }
  }
}
