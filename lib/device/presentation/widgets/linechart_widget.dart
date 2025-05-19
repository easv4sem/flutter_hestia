import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hestia/device/data/models/device.dart';
import 'package:hestia/device/presentation/widgets/info_row_widget.dart';
import 'package:hestia/device/data/provider/abstract_line_chart_data_provider.dart';
import 'package:hestia/theme/colors.dart';

class LinechartWidget extends StatefulWidget {
  final Device device;
  final String title;
  final String subtitle;
  final String xAxisTitle;
  final String yAxisTitle;
  final Color lineColor;
  final String dataSuffix; // Fx "°C", "%", "hPa"
  final AbstractLineChartDataProvider dataProvider;

  const LinechartWidget({
    super.key,
    required this.device,
    required this.title,
    required this.subtitle,
    this.xAxisTitle = 'Time (hours)',
    this.yAxisTitle = 'Value',
    this.lineColor = Colors.red,
    this.dataSuffix = '',
    required this.dataProvider,
  });

  @override
  State<LinechartWidget> createState() => _LinechartWidgetState();
}

class _LinechartWidgetState extends State<LinechartWidget>
    with TickerProviderStateMixin {
  bool toggled = false;
  bool showMax = false;
  bool showMin = false;
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    final dataProvider = widget.dataProvider;
    if (dataProvider == null) {
      return const Center(child: Text('No data available'));
    }

    final double screenHeight = MediaQuery.of(context).size.height;
    final double calculatedHeight =
        toggled ? (screenHeight * 0.5).clamp(300, 600) : 120;

    return SizedBox(
      height: calculatedHeight,
      width: double.infinity,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Card(
          shadowColor: Colors.black,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: AppColors.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
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
                            child:
                                dataProvider.isLoading
                                    ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                    : LineChart(
                                      LineChartData(
                                        minY: 0,
                                        maxY:
                                            (dataProvider.getMaxValue() * 1.2),
                                        minX: 0,
                                        maxX:
                                            dataProvider.sortedData.length
                                                    .toDouble() -
                                                1 ??
                                            0,
                                        lineBarsData: [
                                          LineChartBarData(
                                            spots: dataProvider.sortedData,
                                            isCurved: true,
                                            barWidth: 2,
                                            color: widget.lineColor,
                                            dotData: FlDotData(show: false),
                                            belowBarData: BarAreaData(
                                              show: true,
                                              color: widget.lineColor
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                        ],
                                        extraLinesData: ExtraLinesData(
                                          horizontalLines: [
                                            if (showAvg)
                                              HorizontalLine(
                                                y:
                                                    dataProvider
                                                        .getAverageValue() ??
                                                    0,
                                                label: HorizontalLineLabel(
                                                  show: true,
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  labelResolver:
                                                      (_) =>
                                                          'Average${widget.dataSuffix}',
                                                ),
                                                color: Colors.blue,
                                                strokeWidth: 1,
                                                dashArray: [20, 10],
                                              ),
                                            if (showMax)
                                              HorizontalLine(
                                                y:
                                                    dataProvider
                                                        .getMaxValue() ??
                                                    0,
                                                label: HorizontalLineLabel(
                                                  show: true,
                                                  alignment: Alignment.topRight,
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  labelResolver:
                                                      (_) =>
                                                          'Max${widget.dataSuffix}',
                                                ),
                                                color: Colors.red,
                                                strokeWidth: 1,
                                                dashArray: [20, 10],
                                              ),
                                            if (showMin)
                                              HorizontalLine(
                                                y:
                                                    dataProvider
                                                        .getMinValue() ??
                                                    0,
                                                label: HorizontalLineLabel(
                                                  show: true,
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  labelResolver:
                                                      (_) =>
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
                                            axisNameWidget: Text(
                                              widget.xAxisTitle,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              interval: 2,
                                              reservedSize: 40,
                                              getTitlesWidget: (value, meta) {
                                                return Text(
                                                  '${value.toInt()}h',
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          leftTitles: AxisTitles(
                                            axisNameWidget: Text(
                                              widget.yAxisTitle,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 40,
                                            ),
                                          ),
                                          rightTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                            ),
                                          ),
                                          topTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                            ),
                                          ),
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
                                value:
                                    "${dataProvider.getMaxValue().toStringAsFixed(1)}${widget.dataSuffix}",
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
                                value:
                                    "${dataProvider.getMinValue().toStringAsFixed(1)}${widget.dataSuffix}",
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
                                value:
                                    "${dataProvider.getAverageValue().toStringAsFixed(1)}${widget.dataSuffix}",
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
                                value:
                                    "${dataProvider.getCurrentValue().toStringAsFixed(1)}${widget.dataSuffix}",
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
        Expanded(child: InfoRowWidget(icon: icon, label: label, value: value)),
        Switch(value: toggled, onChanged: onChanged, activeColor: toggleColor),
      ],
    );
  }
}
