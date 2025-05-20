import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/core/routes.dart';
import 'package:hestia/device/data/provider/device_provider.dart';
import 'package:hestia/device/data/provider/device_provider.dart' as context;
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:hestia/theme/colors.dart';
import 'package:provider/provider.dart';

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
    final deviceMac = "10";
    final macAdress =
        Provider.of<DeviceProvider>(context, listen: false).devices
            .where((device) => device.pIUniqueIdentifier == source)
            .firstOrNull
            ?.mac;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textColorDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              type.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textColorDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textColorDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              source,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textColorDark,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, color: AppColors.textColorDark),
            onPressed: () {
              if (macAdress != null) {
                context.goNamed(
                  Routes.device.name,
                  pathParameters: {'deviceId': macAdress.toString()},
                );
              } else {
                // Handle the case when macAdress is null
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Device not found')));
              }
            },
          ),
        ],
      ),
    );
  }
}
