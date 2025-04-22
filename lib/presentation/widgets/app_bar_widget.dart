import 'package:flutter/material.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.blue,


      actions: [       
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Implement notifications functionality here
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}