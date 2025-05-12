import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/core/routes.dart';
import 'package:hestia/models/app_notification.dart';
import 'package:hestia/models/app_notification_item.dart';
import 'package:hestia/models/enum_app_notification_type.dart';
import 'package:hestia/presentation/utility/show_notification_banner.dart';
import 'package:hestia/theme/colors.dart';
import 'package:hestia/theme/notification_banner_styles.dart';
import 'package:provider/provider.dart';


class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = context.watch<AppNotification>();
    
    return AppBar(
      title: GestureDetector(
        child: Text("HESTIA"),
        onTap: () => context.go(Routes.home.path),
      ),
      backgroundColor: AppColors.backgroundColor,
      elevation: 4.0,
      shadowColor: AppColors.secondaryColor,
      actions: [
        
        /// Example of a notification banner
        /// This is a simple example of how to show a notification banner
        /// using the ShowNotificationBanner class.
        /// It also increases the notification count.
        /// TODO: remove this example later
        IconButton(
          icon: const Icon(Icons.warning_outlined, color: Colors.black),
          onPressed: () {
            notifications.addNotification(
              AppNotificationItem(
                title: "Example Notification.",
                subtitle: "This is an example notification message.",
                type: EnumAppNotificationType.error,
              )
            );
            ShowNotificationBanner.showNotificationTop(
              context,
              type: NotificationBannerType.error,
              message: "Example Error Message",
            );
          },
          tooltip: "Alert Example",
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              tooltip: "Notifications",
            ),
            if (notifications.unreadNotifications.isNotEmpty)
              Positioned(
                right: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.primaryColor,
                  child: Text(
                    notifications.unreadNotifications.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.dark_mode_outlined, color: Colors.black),
          onPressed: () {
            // Implement theme toggle functionality here
          },
          tooltip: "Toggle Theme",
        ),
        IconButton(
          icon: const Icon(Icons.person_2_rounded, color: Colors.black),
          onPressed: () {
            context.go(Routes.settings.path);
          },
          tooltip: 'Profile',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  get toggleTheme => null;
}
