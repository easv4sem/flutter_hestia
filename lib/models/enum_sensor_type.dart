enum EnumSensorType {
  camera,
  bme280, // Barometer
  mq135mq2, // Air Quality sensor
  soilMoisture, // Soil Moisture sensor
  unknown;

  static EnumSensorType fromString(String? type) {
    return EnumSensorType.values.firstWhere(
      (e) => e.toString().split('.').last == type?.toLowerCase(),
      orElse: () => EnumSensorType.unknown,
    );
  }

  static EnumSensorType fromNumber(int type) {
    return EnumSensorType.values[type];
  }
}

extension EnumSensorTypeExtension on EnumSensorType {
  static EnumSensorType fromNumber(int number) => EnumSensorType.values[number];
  int get number => index;
}
