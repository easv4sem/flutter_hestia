import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/core/routes.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        child: Text("HESTIA"),
        onTap: () => context.go(Routes.home.path),
      ),
      backgroundColor: Colors.white,
      elevation: 4.0,
      shadowColor: Colors.black,
      actions: [
        IconButton(
          icon: const Icon(Icons.dark_mode_outlined, color: Colors.black),
          onPressed: () {
            // Implement theme toggle functionality here
          },
          tooltip: "Toggle Theme",
        ),
        IconButton(
          icon: const Icon(Icons.chat_outlined, color: Colors.black),
          onPressed: () {
            // Implement logo action here
          },
          tooltip: "Notifications",
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
