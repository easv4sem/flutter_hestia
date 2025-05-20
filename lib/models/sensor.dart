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
                
        return Sensor(
            uniqueIdentifier: json['UniqueIdentifier'] as String,
            displayName: json['DisplayName'] as String,
            serialNumber: json['SerialNumber'] as String,
            lastChangeDate: DateTime.parse(json['LastChangeDate'] as String),
            type: EnumSensorType.fromString(json['Type'] as String),
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