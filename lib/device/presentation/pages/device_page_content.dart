import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/core/routes.dart';
import 'package:hestia/models/enum_sensor_type.dart';
import 'package:hestia/device/presentation/widgets/info_row_widget.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';
import 'package:hestia/device/presentation/widgets/linechart_widget.dart';
import 'package:hestia/theme/colors.dart';
import 'package:provider/provider.dart';

import 'package:hestia/device/data/provider/temp_line_chart_provider.dart';
import 'package:hestia/device/data/provider/humidity_line_chart_provider.dart';
import 'package:hestia/device/data/provider/air_quality_line_chart_provider.dart';
import 'package:hestia/device/data/provider/soil_line_chart_provider.dart';
import 'package:hestia/device/data/provider/presure_line_chart_provider.dart';

class DevicePageContent extends StatelessWidget {
  final dynamic device;

  const DevicePageContent({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return MainLayoutWidget(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(onPressed: () => context.go(Routes.devices.path) , icon: const Icon(Icons.arrow_back)),
                Text(
                  'Device ID: ${device.mac}',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildDeviceCard(context, device)),
                const SizedBox(width: 16),
                Expanded(child: _buildSensorCard(context, device)),
              ],
            ),
            const SizedBox(height: 16),

            if (_hasSensor(EnumSensorType.bme280)) ...[
              _buildChartCard<TempLineChartProvider>(
                context: context,
                title: "Temperature",
                yAxisTitle: "Temperature (°C)",
                lineColor: Colors.red,
                dataSuffix: " °C",
              ),
              const SizedBox(height: 16),
              _buildChartCard<HumidityLineChartProvider>(
                context: context,
                title: "Humidity",
                yAxisTitle: "Humidity (%)",
                lineColor: Colors.blue,
                dataSuffix: " %",
              ),
              const SizedBox(height: 16),
              _buildChartCard<PresureLineChartProvider>(
                context: context,
                title: "Pressure",
                yAxisTitle: "Pressure (hPa)",
                lineColor: Colors.orange,
                dataSuffix: " hPa",
              ),
            ],

            if (_hasSensor(EnumSensorType.mq135mq2)) ...[
              _buildChartCard<AirQualLineChartProvider>(
                context: context,
                title: "Air Quality",
                yAxisTitle: "AQI",
                lineColor: Colors.green,
                dataSuffix: " AQI",
              ),
              const SizedBox(height: 16),
            ],

            if (_hasSensor(EnumSensorType.soilMoisture)) ...[
              _buildChartCard<SoilLineChartProvider>(
                context: context,
                title: "Soil Moisture",
                yAxisTitle: "Soil Moisture (%)",
                lineColor: Colors.brown,
                dataSuffix: " %",
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  bool _hasSensor(EnumSensorType type) {
    return device.sensors?.any((sensor) => sensor.type == type) ?? false;
  }

  Widget _buildDeviceCard(BuildContext context, dynamic device) {
    return _infoCard(context, "Device Information", [
      InfoRowWidget(icon: Icons.wifi, label: "IP", value: device.ip ?? "N/A"),
      InfoRowWidget(
        icon: Icons.device_hub,
        label: "MAC",
        value: device.mac ?? "N/A",
      ),
      InfoRowWidget(
        icon: Icons.device_unknown,
        label: "Name",
        value: device.displayName ?? "N/A",
      ),
      InfoRowWidget(
        icon: Icons.settings,
        label: "Mode",
        value: device.mode?.toString() ?? "N/A",
      ),
      InfoRowWidget(
        icon: Icons.info,
        label: "Firmware",
        value: device.version ?? "N/A",
      ),
      InfoRowWidget(
        icon: Icons.punch_clock,
        label: "Last Heartbeat",
        value: device.lastHeartbeat?.toString() ?? "N/A",
      ),
    ]);
  }

  Widget _buildSensorCard(BuildContext context, dynamic device) {
    final sensors = device.sensors ?? [];

    final List<Widget> children =
        sensors.isEmpty
            ? [const Text("No sensors available.")]
            : sensors
                .map<Widget>(
                  (sensor) => InfoRowWidget(
                    icon: Icons.sensor_door,
                    label: sensor.type?.toString() ?? "Unknown",
                    value: sensor.displayName ?? "N/A",
                  ),
                )
                .toList();

    return _infoCard(context, "Sensors", children);
  }

  Widget _infoCard(BuildContext context, String title, List<Widget> children) {
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
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard<T extends ChangeNotifier>({
    required BuildContext context,
    required String title,
    required String yAxisTitle,
    required String dataSuffix,
    required Color lineColor,
  }) {
    final provider = context.watch<T>() as dynamic;

    return LinechartWidget(
      device: device,
      title: title,
      subtitle: "Data from last 24 hours",
      xAxisTitle: "Time",
      yAxisTitle: yAxisTitle,
      dataSuffix: dataSuffix,
      lineColor: lineColor,
      dataProvider: provider,
    );
  }
}
