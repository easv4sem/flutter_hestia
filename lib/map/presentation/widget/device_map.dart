import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DeviceMap extends StatefulWidget {
  final Future<List<TestDevice>> devicesFuture;

  const DeviceMap({required this.devicesFuture, super.key});

  @override
  State<DeviceMap> createState() => _DeviceMapState();
}

class _DeviceMapState extends State<DeviceMap> {
  late Future<List<TestDevice>> _devicesFuture;

  @override
  void initState() {
    super.initState();
    _devicesFuture = widget.devicesFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Device Locations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: FutureBuilder<List<TestDevice>>(
                future: _devicesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No devices found.'));
                  }

                  final devices = snapshot.data!;
                  return FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(55.6761, 12.5683),
                      initialZoom: 6.2,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      CircleLayer(
                        circles: devices.map((device) {
                          return CircleMarker(
                            point: LatLng(device.lat, device.long),
                            color: device.color.withOpacity(0.6),
                            useRadiusInMeter: false,
                            radius: 10.0,
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestDevice {
  final double lat;
  final double long;
  final Color color;

  TestDevice({required this.lat, required this.long, required this.color});
}
