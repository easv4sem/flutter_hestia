import 'package:flutter/material.dart';
import 'package:hestia/models/device_provider.dart';
import 'package:hestia/models/device_state.dart';
import 'package:hestia/presentation/widgets/device_summary_card.dart';
import 'package:provider/provider.dart';

class DeviceSummaryList extends StatelessWidget {
  const DeviceSummaryList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DeviceProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: DeviceSummaryCard(
              title: 'Total Devices',
              count: provider.getNumberOfDevices(),
              icon: Icons.devices,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: DeviceSummaryCard(
              title: 'Online Devices',
              count: provider.getNumberOfDevicesByStatus(DeviceState.online),
              icon: Icons.check_circle,
              color: DeviceState.online.color,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: DeviceSummaryCard(
              title: 'Offline Devices',
              count: provider.getNumberOfDevicesByStatus(DeviceState.offline),
              icon: Icons.offline_bolt,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: DeviceSummaryCard(
              title: 'Alert Devices',
              count: provider.getNumberOfDevicesByStatus(DeviceState.alert),
              icon: Icons.warning,
              color: DeviceState.alert.color,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: DeviceSummaryCard(
              title: 'Error Devices',
              count: provider.getNumberOfDevicesByStatus(DeviceState.error),

              icon: Icons.error,
              color: DeviceState.error.color,
            ),
          ),
        ],
      ),
    );
  }
}
