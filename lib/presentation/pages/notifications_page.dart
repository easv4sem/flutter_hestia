import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hestia/models/app_notification_provider.dart';
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';
import 'package:hestia/presentation/widgets/notifications_simplerow.dart';
import 'package:hestia/theme/colors.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<AppNotificationProvider>();

    final Map<EnumAppNotificationType, int> typeCounts = {};
    for (var notif in notifications.notifications) {
      typeCounts[notif.type] = (typeCounts[notif.type] ?? 0) + 1;
    }

    final total = notifications.notifications.length;

    final sortedNotifications = List.from(notifications.notifications)
    ..sort((a, b) => b.date.compareTo(a.date)); // newest first

    final List<PieChartSectionData> pieSections = total > 0
        ? typeCounts.entries.map((entry) {
            final percentage = ((entry.value / total) * 100).toStringAsFixed(0);
            return PieChartSectionData(
              color: AppColors.getNotificationColorByType(entry.key).withValues(
                alpha: 0.7,
              ),
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

    return MainLayoutWidget(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Statistics'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 194, 194, 194),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StatsNotificationCount(notifications: notifications),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
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
                              child: pieSections.isEmpty
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
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Notifications'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 194, 194, 194),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (notifications.notifications.isEmpty)
                const Text(
                  'You have no notifications.',
                  style: TextStyle(fontSize: 16),
                )
              else
                Expanded(
                  child: Column(
                    children: [
                      const NotificationsSimplerow(
                        time: 'Time',
                        type: EnumAppNotificationType.type,
                        title: 'Title',
                        source: 'Source',
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final item = sortedNotifications[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: AppColors.accentColor),
                                  bottom: BorderSide(color: AppColors.accentColor),
                                ),
                                color: item.isRead
                                    ? AppColors.getNotificationColorByType(item.type).withValues(
                                        alpha: 0.6,
                                      )
                                    : AppColors.primaryColor.withValues(
                                        alpha: 0.7,
                                      ),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                children: [
                                  const SizedBox(height: 2),
                                  NotificationsSimplerow(
                                    time: item.formatted,
                                    type: item.type,
                                    title: item.title,
                                    source: "${item.subtitle} Placeholder :)",
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: sortedNotifications.length,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


class StatsNotificationCount extends StatefulWidget {
  const StatsNotificationCount({
    super.key,
    required this.notifications,
  });

  final AppNotificationProvider notifications;

  @override
  State<StatsNotificationCount> createState() => _StatsNotificationCountState();
}

class _StatsNotificationCountState extends State<StatsNotificationCount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              CounterSimplecolumn(title: 'Total Today', count: widget.notifications.todayCount),
              VerticalDivider(
                color: AppColors.accentColor,
                thickness: 1,
                width: 20,
              ),
              CounterSimplecolumn(title: 'Total 7 Days', count: widget.notifications.last7DaysCount),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterSimplecolumn extends StatelessWidget {
  const CounterSimplecolumn({
    super.key,
    required this.count,
    required this.title,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.accentColor,
          ),
        ),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
