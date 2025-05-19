import 'package:flutter/material.dart';
import 'package:hestia/models/app_notification_provider.dart';
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';
import 'package:hestia/presentation/widgets/notifications__pie_chart.dart';
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

    final sortedNotifications = List.from(notifications.notifications)
      ..sort((a, b) => b.date.compareTo(a.date)); // newest first

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
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CounterSimplecolumn(
                              title: 'Total Notifications',
                              count: notifications.notifications.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  NotificationsPieChart(
                    notifications: notifications.notifications,
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
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),

                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Time',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColorDark,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Type",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColorDark,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Title",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColorDark,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Source",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColorDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final item = sortedNotifications[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: AppColors.accentColor),
                                  bottom: BorderSide(
                                    color: AppColors.accentColor,
                                  ),
                                ),
                                color:
                                    item.isRead
                                        ? AppColors.getNotificationColorByType(
                                          item.type,
                                        ).withValues(alpha: 0.6)
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
  const StatsNotificationCount({super.key, required this.notifications});

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
              CounterSimplecolumn(
                title: 'Total Today',
                count: widget.notifications.todayCount,
              ),
              VerticalDivider(
                color: AppColors.accentColor,
                thickness: 1,
                width: 20,
              ),
              CounterSimplecolumn(
                title: 'Total 7 Days',
                count: widget.notifications.last7DaysCount,
              ),
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
