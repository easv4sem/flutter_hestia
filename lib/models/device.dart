class Device {
  final String displayName;
  final String? ip;
  final String? mac;
  final num? longitude;
  final num? latitude;
  final String? version;
  final DateTime? lastHeartbeat;
  final num? port;
  final String? mode; // maybe 'Connected', 'OK', etc.

  Device({
    required this.displayName,
    this.ip,
    this.mac,
    this.longitude,
    this.latitude,
    this.version,
    this.lastHeartbeat,
    this.port,
    this.mode,
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
              ? DateTime.parse(json['LastHeartbeat'])
              : null,
      mode: json['mode'] as String?, // map this field from API if exists
    );
  }

  Map<String, dynamic> toDisplayMap() {
    return {
      'name': displayName,
      'details': 'IP: $ip, MAC: $mac, Version: $version, Port: $port',
      'longitude': longitude,
      'latitude': latitude,
      'lasthardbeat': lastHeartbeat,
      'mode': mode ?? 'Unknown',
    };
  }
}
