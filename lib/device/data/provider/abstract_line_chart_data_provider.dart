import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

abstract class AbstractLineChartDataProvider with ChangeNotifier {
  late List<FlSpot> sortedData = [];
  late List<FlSpot> unsortedData = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  Future<void> loadDataFromSrc();

  Future<List<FlSpot>> getLineChartDataByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return Future.value(
      unsortedData.where((spot) {
        final date = DateTime.fromMillisecondsSinceEpoch(spot.x.toInt());
        return date.isAfter(startDate) && date.isBefore(endDate);
      }).toList(),
    );
  }

  double getAverageValue() {
    if (sortedData.isNotEmpty || sortedData == null) {
      return sortedData.map((spot) => spot.y).reduce((a, b) => a + b) /
          sortedData.length;
    } else {
      return 0;
    }
  }

  double getMaxValue() {
    if (sortedData.isNotEmpty || sortedData == null) {
      return sortedData.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    } else {
      return 0;
    }
  }

  double getMinValue() {
    if (sortedData.isNotEmpty || sortedData == null) {
      return sortedData.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    } else {
      return 0;
    }
  }

  double getCurrentValue() {
    if (sortedData.isNotEmpty || sortedData == null) {
      return sortedData.last.y;
    } else {
      return 0;
    }
  }
}
