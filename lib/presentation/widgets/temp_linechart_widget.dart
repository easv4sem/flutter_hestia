import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hestia/models/device.dart';
import 'package:hestia/presentation/widgets/info_row_widget.dart';
import 'package:hestia/theme/colors.dart';

class TempLinechartWidget extends StatefulWidget {
  final Device device;
  final String title;
  final String subtitle;
  final String xAxisTitle;
  final String yAxisTitle;
  final Color lineColor;
  final String dataSuffix; // Fx "°C", "%", "hPa"

  const TempLinechartWidget({
    super.key,
    required this.device,
    required this.title,
    required this.subtitle,
    this.xAxisTitle = 'Time (hours)',
    this.yAxisTitle = 'Value',
    this.lineColor = Colors.red,
    this.dataSuffix = '',
  });

  @override
  State<TempLinechartWidget> createState() => _TempLinechartWidgetState();
}

class _TempLinechartWidgetState extends State<TempLinechartWidget> with TickerProviderStateMixin {
  bool toggled = false;
  bool showMax = true;
  bool showMin = true;
  bool showAvg = true;

  // Dummy data, senere kan du erstatte med device.data baseret på valgt periode
  final List<FlSpot> dataSpots = [
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

  @override
  Widget build(BuildContext context) {
    final double avgValue =
        dataSpots.map((e) => e.y).reduce((a, b) => a + b) / dataSpots.length;
    final double maxValue =
        dataSpots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final double minValue =
        dataSpots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final double currentValue = dataSpots.last.y;

    // Beregn højde baseret på indhold: minimum 120, max 600, eller baseret på toggle og skærmstørrelse
    final double screenHeight = MediaQuery.of(context).size.height;
    final double calculatedHeight = toggled ? (screenHeight * 0.5).clamp(300, 600) : 120;

    return SizedBox(
      height: calculatedHeight,
      width: double.infinity,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
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
                // Header med titel og toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title,
                        style: Theme.of(context).textTheme.headlineSmall),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          toggled = !toggled;
                        });
                      },
                      child: Text(toggled ? 'Hide Graph' : 'Show Graph'),
                    ),
                  ],
                ),
                Text(
                  widget.subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                if (toggled)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Graf
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: double.infinity,
                            child: LineChart(
                              LineChartData(
                                minY: 0,
                                maxY: (maxValue * 1.2),
                                minX: 0,
                                maxX: dataSpots.length.toDouble() - 1,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: dataSpots,
                                    isCurved: true,
                                    barWidth: 2,
                                    color: widget.lineColor,
                                    dotData: FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: widget.lineColor.withOpacity(0.3),
                                    ),
                                  ),
                                ],
                                extraLinesData: ExtraLinesData(
                                  horizontalLines: [
                                    if (showAvg)
                                      HorizontalLine(
                                        y: avgValue,
                                        label: HorizontalLineLabel(
                                          show: true,
                                          alignment: Alignment.bottomRight,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          labelResolver: (_) =>
                                              'Average${widget.dataSuffix}',
                                        ),
                                        color: Colors.blue,
                                        strokeWidth: 1,
                                        dashArray: [20, 10],
                                      ),
                                    if (showMax)
                                      HorizontalLine(
                                        y: maxValue,
                                        label: HorizontalLineLabel(
                                          show: true,
                                          alignment: Alignment.topRight,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          labelResolver: (_) =>
                                              'Max${widget.dataSuffix}',
                                        ),
                                        color: Colors.red,
                                        strokeWidth: 1,
                                        dashArray: [20, 10],
                                      ),
                                    if (showMin)
                                      HorizontalLine(
                                        y: minValue,
                                        label: HorizontalLineLabel(
                                          show: true,
                                          alignment: Alignment.bottomRight,
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          labelResolver: (_) =>
                                              'Min${widget.dataSuffix}',
                                        ),
                                        color: Colors.green,
                                        strokeWidth: 1,
                                        dashArray: [20, 10],
                                      ),
                                  ],
                                ),
                                titlesData: FlTitlesData(
                                  bottomTitles: AxisTitles(
                                    axisNameWidget: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        widget.xAxisTitle,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 2,
                                      reservedSize: 40,
                                      getTitlesWidget: (value, meta) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            '${value.toInt()}h',
                                            style: const TextStyle(fontSize: 10),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    axisNameWidget: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Text(
                                          widget.yAxisTitle,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 40,
                                    ),
                                  ),
                                  rightTitles:
                                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  topTitles:
                                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                ),
                                gridData: FlGridData(show: true),
                                borderData: FlBorderData(show: true),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRowWithToggle(
                                icon: Icons.thermostat,
                                label: "Max ${widget.title}",
                                value: "${maxValue.toStringAsFixed(1)}${widget.dataSuffix}",
                                toggled: showMax,
                                onChanged: (v) {
                                  setState(() {
                                    showMax = v;
                                  });
                                },
                                toggleColor: Colors.red,
                              ),
                              _buildInfoRowWithToggle(
                                icon: Icons.thermostat,
                                label: "Min ${widget.title}",
                                value: "${minValue.toStringAsFixed(1)}${widget.dataSuffix}",
                                toggled: showMin,
                                onChanged: (v) {
                                  setState(() {
                                    showMin = v;
                                  });
                                },
                                toggleColor: Colors.green,
                              ),
                              _buildInfoRowWithToggle(
                                icon: Icons.thermostat,
                                label: "Average ${widget.title}",
                                value: "${avgValue.toStringAsFixed(1)}${widget.dataSuffix}",
                                toggled: showAvg,
                                onChanged: (v) {
                                  setState(() {
                                    showAvg = v;
                                  });
                                },
                                toggleColor: Colors.blue,
                              ),
                              InfoRowWidget(
                                icon: Icons.thermostat,
                                label: "Current ${widget.title}",
                                value: "${currentValue.toStringAsFixed(1)}${widget.dataSuffix}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRowWithToggle({
    required IconData icon,
    required String label,
    required String value,
    required bool toggled,
    required ValueChanged<bool> onChanged,
    required Color toggleColor,
  }) {
    return Row(
      children: [
        Expanded(
          child: InfoRowWidget(
            icon: icon,
            label: label,
            value: value,
          ),
        ),
        Switch(
          value: toggled,
          onChanged: onChanged,
          activeColor: toggleColor,
        ),
      ],
    );
  }
}
