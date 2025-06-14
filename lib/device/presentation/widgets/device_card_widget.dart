import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/core/routes.dart';
import 'package:hestia/device/data/models/device.dart';
import 'package:hestia/device/data/enums/device_state.dart';
import 'package:hestia/theme/colors.dart';

class DeviceCardWidget extends StatelessWidget {
  final Device device;

  const DeviceCardWidget({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(device.displayName),
        tileColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.transparent, width: 2.0),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("details"),
            const SizedBox(height: 4.0),
            Text(
              'Longitude: ${device.longitude}, Latitude: ${device.latitude}',
              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'Last Heartbeat: ${device.lastHeartbeat?.toString().split('.').first}',

              style: const TextStyle(fontSize: 12.0),
            ),
            Text(
              'IP: ${device.ip}, MAC: ${device.mac}, Version: ${device.version}, Port: ${device.port}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: device.mode.color,
          ),
          child: SizedBox(width: 50, height: 50, child: Icon(Icons.device_hub)),
        ),
        trailing: Icon(Icons.arrow_forward, color: device.mode.color),
        onTap: () {
          context.goNamed(Routes.device.name, pathParameters: {
            'deviceId': device.mac.toString()},
          );
        },
      ),
    );
  }
}
