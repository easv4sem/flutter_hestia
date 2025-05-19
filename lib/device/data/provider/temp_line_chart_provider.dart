import 'package:fl_chart/fl_chart.dart';
import 'package:hestia/device/data/provider/abstract_line_chart_data_provider.dart';

class TempLineChartProvider extends AbstractLineChartDataProvider {
  TempLineChartProvider({required this.device});

  final dynamic device;

  @override
  Future<void> loadDataFromSrc() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Example data points for temperature
      unsortedData = [
        FlSpot(0, 20),
        FlSpot(1, 22),
        FlSpot(2, 21),
        FlSpot(3, 23),
        FlSpot(4, 24),
        FlSpot(5, 25),
        FlSpot(6, 26),
        FlSpot(7, 27),
        FlSpot(8, 28),
        FlSpot(9, 29),
        FlSpot(10, 30),
      ];

      sortedData = List.from(unsortedData);
      sortedData.sort((a, b) => a.x.compareTo(b.x));

      isLoading = false;
    } catch (e) {
      print('Error loading temperature data: $e');
    }
  }
}
