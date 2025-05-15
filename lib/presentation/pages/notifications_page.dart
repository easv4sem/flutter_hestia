import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hestia/models/app_notification.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';
import 'package:hestia/theme/colors.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {

  const NotificationsPage({super.key});

  @override
Widget build(BuildContext context) {
  final notifications = context.watch<AppNotification>();

  return MainLayoutWidget(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          
            SizedBox(height: 8),
            if(notifications.notifications.isEmpty)
              Text(
              'You have no notifications.',
              style: TextStyle(fontSize: 16),
            ) else
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ...List.generate(notifications.notifications.length, (index) {
                  final item = notifications.notifications[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.accentColor),
                        left: BorderSide(color: Colors.transparent),
                        right: BorderSide(color: Colors.transparent),
                        bottom: BorderSide(color: AppColors.accentColor),
                      ),
                      color: item.isRead ? Colors.white : AppColors.primaryColor.withOpacity(0.1),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      children: [
                        SizedBox(height: 2),
                        ListTile(
                          title: Text(item.title),
                          subtitle: Text(item.subtitle),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                final item = notifications.notifications[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.accentColor),
                      left: BorderSide(color: Colors.transparent),
                      right: BorderSide(color: Colors.transparent),
                      bottom: BorderSide(color: AppColors.accentColor),
                    ),
                    color: item.isRead ? Colors.white : AppColors.primaryColor.withOpacity(0.1),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      SizedBox(height: 2),
                      ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.subtitle),
                      ),
                    ],
                  ),
                );  
              }, 
              itemCount: notifications.notifications.length
            ),
          ],
        ),
      ),
    ),
  );
}

}