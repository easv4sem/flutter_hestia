import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? tileColor;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onPressed,
    this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.title),
      subtitle: Text(this.subtitle),
      trailing: IconButton(
        icon: Icon(this.icon),
        onPressed: onPressed,
      ),
      tileColor: tileColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
    );
  }
}

