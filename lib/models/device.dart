import 'package:hestia/models/sensor.dart';

import 'device_state.dart';

class Device {
  final String displayName;
  final String? ip;
  final String? mac;
  final num? longitude;
  final num? latitude;
  final String? version;
  final DateTime? lastHeartbeat;
  final num? port;
  final DeviceState mode;
  final List<Sensor>? sensors;

  Device({
    required this.displayName,
    this.ip,
    this.mac,
    this.longitude,
    this.latitude,
    this.version,
    this.lastHeartbeat,
    this.port,
    this.sensors,
    this.mode = DeviceState.offline,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      displayName: json['PIDisplayName'] as String,
      ip: json['Ip'] as String?,
      port: json['Port'] as num?,
      mac: json['Mac'] as String?,
      longitude: json['Longitude'] as num?,
      latitude: json['Latitude'] as num?,
      version: json['Version'] as String?,
      lastHeartbeat:
          json['LastHeartbeat'] != null
              ? DateTime.tryParse(json['LastHeartbeat'])
              : null,
      mode: _parseDeviceState(json['Mode']),
      sensors:
          (json['Sensors'] as List<dynamic>?)
              ?.map((sensor) => Sensor.fromJson(sensor))
              .toList(),
    );
  }

  get dataProvider => null;

  static DeviceState _parseDeviceState(dynamic value) {
    if (value is int && value >= 0 && value < DeviceState.values.length) {
      return DeviceState.values[value];
    }
    if (value is String) {
      return DeviceState.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase(),
        orElse: () => DeviceState.offline,
      );
    }
    return DeviceState.offline;
  }
}
