import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/core/routes.dart';
import 'package:hestia/device/data/enums/device_state.dart';
import 'package:hestia/device/data/models/device.dart';
import 'package:latlong2/latlong.dart';

class DeviceMap extends StatefulWidget {
  final Future<List<Device>> devicesFuture;

  const DeviceMap({required this.devicesFuture, super.key});

  @override
  State<DeviceMap> createState() => _DeviceMapState();
}

class _DeviceMapState extends State<DeviceMap> {
  late Future<List<Device>> _devicesFuture;
  late final LayerHitNotifier<Device> _hitNotifier;

  @override
  void initState() {
    super.initState();
    _devicesFuture = widget.devicesFuture;
    _hitNotifier = ValueNotifier(null);
  }

  @override
  void dispose() {
    _hitNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
              child: FutureBuilder<List<Device>>(
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
                      onTap: (_, __) {
                        final hitResult = _hitNotifier.value;
                        final device = hitResult?.hitValues.last;

                        if (device != null) {
                          context.goNamed(
                            Routes.device.name,
                            pathParameters: {'deviceId': device.mac.toString()},
                          );
                        }
                      },
                    ),

                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      CircleLayer(
                        hitNotifier: _hitNotifier,
                        circles:
                            devices
                                .where(
                                  (device) =>
                                      device.latitude != null &&
                                      device.longitude != null,
                                )
                                .map(
                                  (device) => CircleMarker(
                                    point: LatLng(
                                      device.latitude!,
                                      device.longitude!,
                                    ),
                                    color: device.mode.color,
                                    useRadiusInMeter: false,
                                    radius: 10.0,
                                    hitValue: device,
                                  ),
                                )
                                .toList(),
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
