import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:hestia/theme/colors.dart';

class NotificationsPieChart extends StatelessWidget {
  const NotificationsPieChart({super.key, required this.notifications});

  final List notifications;

  @override
  Widget build(BuildContext context) {
    final Map<EnumAppNotificationType, int> typeCounts = {};
    for (var notif in notifications) {
      typeCounts[notif.type] = (typeCounts[notif.type] ?? 0) + 1;
    }
    final total = notifications.length;
    final List<PieChartSectionData> pieSections =
        total > 0
            ? typeCounts.entries.map((entry) {
              final percentage = ((entry.value / total) * 100).toStringAsFixed(
                0,
              );
              return PieChartSectionData(
                color: AppColors.getNotificationColorByType(
                  entry.key,
                ).withValues(alpha: 0.7),
                title: '${entry.key.name}\n$percentage%',
                value: entry.value.toDouble(),
                radius: 80,
                titleStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColorDark,
                ),
              );
            }).toList()
            : [];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notifications by Type'.toUpperCase(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentColor,
                ),
              ),
              SizedBox(
                height: 200,
                width: 200,
                child:
                    pieSections.isEmpty
                        ? const Center(child: Text('No data'))
                        : PieChart(
                          PieChartData(
                            sections: pieSections,
                            centerSpaceRadius: 20,
                            sectionsSpace: 4,
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
