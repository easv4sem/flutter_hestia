import 'package:flutter/material.dart';
import 'package:hestia/presentation/widgets/device_page_content.dart';
import 'package:hestia/providers/device_provider_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:hestia/models/device_provider.dart';

class DevicePage extends StatelessWidget {
  final dynamic deviceId;

  const DevicePage({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DeviceProvider>();

    if (deviceId == null) {
      return const Center(child: Text('Device ID is null'));
    }

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final device = provider.getDeviceByMac(deviceId);
    if (device == null) {
      return const Center(child: Text('Device not found'));
    }

    return DeviceProviderWrapper(
      device: device,
      child: DevicePageContent(device: device),
    );
  }
}
