import 'package:flutter/material.dart';
import 'package:hestia/providers/air_quality_line_chart_provider.dart';
import 'package:hestia/providers/humidity_line_chart_provider.dart';
import 'package:hestia/providers/presure_line_chart_provider.dart';
import 'package:hestia/providers/soil_line_chart_provider.dart';
import 'package:hestia/providers/temp_line_chart_provider.dart';
import 'package:provider/provider.dart';

class DeviceProviderWrapper extends StatelessWidget {
  final dynamic device;
  final Widget child;

  const DeviceProviderWrapper({
    super.key,
    required this.device,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) => TempLineChartProvider(device: device)..loadDataFromSrc(),
        ),
        ChangeNotifierProvider(
          create:
              (_) =>
                  HumidityLineChartProvider(device: device)..loadDataFromSrc(),
        ),
        ChangeNotifierProvider(
          create:
              (_) =>
                  AirQualLineChartProvider(device: device)..loadDataFromSrc(),
        ),
        ChangeNotifierProvider(
          create:
              (_) => SoilLineChartProvider(device: device)..loadDataFromSrc(),
        ),
        ChangeNotifierProvider(
          create:
              (_) =>
                  PresureLineChartProvider(device: device)..loadDataFromSrc(),
        ),
      ],
      child: child,
    );
  }
}
