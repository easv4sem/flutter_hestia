import 'package:flutter/material.dart';
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:hestia/theme/colors.dart';

class NotificationsSimplerow extends StatelessWidget {

  final String time;
  final EnumAppNotificationType type;      
  final String title;
  final String source;

  const NotificationsSimplerow({
    required this.time,
    required this.type,   
    required this.title,
    required this.source,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            )
          ),
          Expanded(
            child: Text(
              type.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            )
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            )
          ),
          Expanded(
            child: Text(
              source,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            )
          ),
        ],
    
      )
    );
  }
}