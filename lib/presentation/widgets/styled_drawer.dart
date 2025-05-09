import 'package:flutter/material.dart';
import 'package:hestia/theme/colors.dart';

/// A custom drawer widget that can be used in the app.
/// It allows for a header and a list of children widgets.
/// Styling is done through the AppColors class.
class StyledDrawer extends StatelessWidget {
  final Widget? header;
  final List<Widget> children;

  const StyledDrawer({
    super.key,
    this.header,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.backgroundColor, // your custom background
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 70,
              child: header != null
                  ? DefaultTextStyle(
                      style: const TextStyle(
                          color: AppColors.textColorLight, fontSize: 24),
                      child: header!,
                    )
                  : const DrawerHeader(
                      decoration: BoxDecoration(color: AppColors.primaryColor),
                      child: Text(
                        'PlaceHolder Header',
                        style: TextStyle(
                            color: AppColors.textColorLight, fontSize: 24),
                      ),
                    ),
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
