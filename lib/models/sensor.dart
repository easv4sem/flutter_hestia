import 'enum_sensor_type.dart';

class Sensor {
  final String uniqueIdentifier;
  final String? displayName;
  final String? serialNumber;
  final DateTime? lastChangeDate;
  final EnumSensorType? type;

  Sensor({
    required this.uniqueIdentifier,
    this.displayName,
    this.serialNumber,
    this.lastChangeDate,
    this.type,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) {
    final typeString =
        json['Type'] as String? ??
        EnumSensorType.unknown.toString().split('.').last;

    return Sensor(
      uniqueIdentifier: json['UniqueIdentifier'] as String,
      displayName: json['DisplayName'] as String?,
      serialNumber: json['SerialNumber'] as String?,
      lastChangeDate:
          json['LastChangeDate'] != null
              ? DateTime.parse(json['LastChangeDate'] as String)
              : null,
      type: EnumSensorType.values.firstWhere(
        (e) => e.toString().split('.').last == typeString,
        orElse: () => EnumSensorType.unknown,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UniqueIdentifier': uniqueIdentifier,
      'DisplayName': displayName,
      'SerialNumber': serialNumber,
      'LastChangeDate': lastChangeDate?.toIso8601String(),
      'Type': type.toString().split('.').last,
    };
  }
}
