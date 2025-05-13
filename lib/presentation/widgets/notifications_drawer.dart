import 'package:flutter/material.dart';

class NotificationsDrawer extends StatelessWidget {
  // This widget will be used to show notifications in a drawer
  // It will be a simple list of notifications with a title and a description
  // The notifications will be fetched from the API and displayed in the drawer
  // The drawer will be opened from the home screen
  // The user can click on a notification to open it / be redirected to the relevant screen
  // The user can also delete a notification by swiping it away (?)
  // The notification will be marked as read by clicking on it
  // The user can also clear all notifications by clicking on a button

  const NotificationsDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 70,
            child: const DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),

              child: Text(
                'Notifications',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification 1'),
            onTap: () {
              // Handle notification tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification 2'),
            subtitle: const Text('This is a description of notification'),

            onTap: () {
              // Handle notification tap
            },
          ),
        ],
      ),
    );
  }
}
