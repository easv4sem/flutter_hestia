import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hestia/models/device.dart';
import 'package:hestia/presentation/widgets/info_row_widget.dart';
import 'package:hestia/theme/colors.dart';

class TempLinechartWidget extends StatelessWidget {
  final Device device;

  const TempLinechartWidget({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    // Dummy temperaturdata
    final List<FlSpot> temperatureSpots = [
      FlSpot(0, 5),
      FlSpot(1, 10),
      FlSpot(2, 15),
      FlSpot(3, 24),
      FlSpot(4, 22.5),
      FlSpot(5, 23.3),
      FlSpot(6, 17),
      FlSpot(7, 14),
      FlSpot(8, 12),
      FlSpot(9, 0),
      FlSpot(10, 24),
      FlSpot(11, 22.5),
      FlSpot(12, 23.3),
      FlSpot(13, 22.8),
    ];

    final double avgTemperature =
        temperatureSpots.map((e) => e.y).reduce((a, b) => a + b) / temperatureSpots.length;
    final double maxTemperature =
        temperatureSpots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final double minTemperature =
        temperatureSpots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final double currentTemperature = temperatureSpots.last.y;
    final double alertTemperature = 28.0;

    return SizedBox(
      height: 600,
      child: Card(
        shadowColor: Colors.black,
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: AppColors.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Temperature", style: Theme.of(context).textTheme.headlineSmall),
              Text(
                "Temperature data from the last 24 hours",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              InfoRowWidget(
                icon: Icons.thermostat,
                label: "Max Temperature",
                value: "${maxTemperature.toStringAsFixed(1)} °C",
              ),
              InfoRowWidget(
                icon: Icons.thermostat,
                label: "Min Temperature",
                value: "${minTemperature.toStringAsFixed(1)} °C",
              ),
              InfoRowWidget(
                icon: Icons.thermostat,
                label: "Average Temperature",
                value: "${avgTemperature.toStringAsFixed(1)} °C",
              ),
              InfoRowWidget(
                icon: Icons.thermostat,
                label: "Current Temperature",
                value: "${currentTemperature.toStringAsFixed(1)} °C",
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: 50,
                    minX: 0,
                    maxX: temperatureSpots.length.toDouble() - 1,
                    lineBarsData: [
                      LineChartBarData(
                        spots: temperatureSpots,
                        isCurved: true,
                        barWidth: 2,
                        color: Colors.red,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.red.withOpacity(0.3),
                        ),
                      ),
                    ],
                    extraLinesData: ExtraLinesData(
                      horizontalLines: [
                        HorizontalLine(
                          y: avgTemperature,
                          label: HorizontalLineLabel(
                            show: true,
                            alignment: Alignment.bottomRight,
                            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            labelResolver: (_) => 'Average',
                          ),
                          color: Colors.blue,
                          strokeWidth: 1,
                          dashArray: [20, 10],
                        ),
                        HorizontalLine(
                          y: alertTemperature,
                          label: HorizontalLineLabel(
                            show: true,
                            alignment: Alignment.bottomRight,
                            style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            labelResolver: (_) => 'Alert Temperature',
                          ),
                          color: Colors.orange,
                          strokeWidth: 1,
                          dashArray: [20, 10],
                        ),
                      ],
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2,
                          getTitlesWidget: (value, meta) {
                            return Text('${value.toInt()}h', style: const TextStyle(fontSize: 10));
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(show: true),
                    borderData: FlBorderData(show: true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
