import 'package:fl_chart/fl_chart.dart';
import 'package:hestia/device/data/provider/abstract_line_chart_data_provider.dart';

class SoilLineChartProvider extends AbstractLineChartDataProvider {
  SoilLineChartProvider({required this.device});

  final dynamic device;

  @override
  Future<void> loadDataFromSrc() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
    unsortedData = [
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

    sortedData = List.from(unsortedData);
    sortedData.sort((a, b) => a.x.compareTo(b.x));

    isLoading = false;
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      // Handle any errors that may occur during data loading
      print('Error loading data: $e');
    }
    // Simulate network delay
    
  }
}
