import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hestia/models/device_provider.dart';
import 'package:hestia/presentation/widgets/info_row_widget.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';
import 'package:hestia/presentation/widgets/temp_linechart_widget.dart';
import 'package:hestia/theme/colors.dart';
import 'package:provider/provider.dart';


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

    return MainLayoutWidget(
      body: SingleChildScrollView( // <-- Make the page scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Device ID: $deviceId',
                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: IntrinsicHeight(
                      child: _buildDeviceCard(context, device),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: IntrinsicHeight(
                      child: _buildSensorCard(context, device),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TempLinechartWidget(device: device),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, dynamic device) {
    return Card(
      shadowColor: Colors.black,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Device Information", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            InfoRowWidget(icon: Icons.wifi, label: "IP", value: device.ip ?? "N/A"),
            InfoRowWidget(icon: Icons.device_hub, label: "MAC", value: device.mac ?? "N/A"),
            InfoRowWidget(icon: Icons.device_unknown, label: "Name", value: device.displayName ?? "N/A"),
            InfoRowWidget(icon: Icons.settings, label: "Mode", value: device.mode?.toString() ?? "N/A"),
            InfoRowWidget(icon: Icons.info, label: "Firmware version", value: device.version ?? "N/A"),
            InfoRowWidget(icon: Icons.punch_clock, label: "Last Heartbeat", value: device.lastHeartbeat?.toString() ?? "N/A"),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard(BuildContext context, dynamic device) {
    return Card(
      shadowColor: Colors.black,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sensors", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            if (device.sensors != null && device.sensors!.isNotEmpty)
              ...device.sensors!.map((sensor) => InfoRowWidget(
                    icon: Icons.sensor_door,
                    label: sensor.type?.toString() ?? "Unknown",
                    value: sensor.displayName ?? "N/A",
                  ))
            else
              const Text("No sensors available."),
          ],
        ),
      ),
    );
  }



}
