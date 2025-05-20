import 'package:flutter/material.dart';
import 'package:hestia/device/data/models/device.dart';
import 'package:hestia/device/data/provider/device_provider.dart';
import 'package:hestia/device/presentation/widgets/device_summary_list.dart';
import 'package:hestia/map/presentation/widget/device_map.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';
import 'package:hestia/presentation/widgets/notifications__pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:hestia/models/app_notification_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<AppNotificationProvider>();
    return MainLayoutWidget(
      body: Center(
        child: Column(
          children: [
            DeviceSummaryList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NotificationsPieChart(
                  notifications: notifications.notifications,
                ),
              ],
            ),
            Expanded(child: DeviceMap(devicesFuture: fetchDevices(context))),
          ],
        ),
      ),
    );
  }

  Future<List<Device>> fetchDevices(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading
    return Provider.of<DeviceProvider>(
      context,
      listen: false,
    ).devices; // Fetch devices from provider
  }
}
