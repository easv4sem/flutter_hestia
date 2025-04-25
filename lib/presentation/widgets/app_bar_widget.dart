import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  const MainAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("HESTIA"),
      backgroundColor: Colors.white,   
      elevation: 4.0,   
      shadowColor: Colors.black,
      leading: Center(child: SvgPicture.asset(
        'assets/images/logo.svg',
        width: 30,
        height: 30,
      ),),
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}