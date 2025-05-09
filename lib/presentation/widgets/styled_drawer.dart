import 'package:flutter/material.dart';

class StyledDrawer extends StatelessWidget {
  final Widget? header;

  const StyledDrawer({super.key, this.header});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 70,
            child: header != null 
                ? DefaultTextStyle(
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    child: header!,
                  )
                : const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Text(
                      'PlaceHolder Header',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
          ),

        ],
      ),
    );
  }

}