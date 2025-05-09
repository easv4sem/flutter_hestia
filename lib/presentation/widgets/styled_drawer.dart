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
        color: AppColors.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: kToolbarHeight,
              child: Container(
                color: AppColors.primaryColor,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: AppColors.textColorLight,
                    fontSize: 24,
                  ),
                  child: header ?? const Text('PlaceHolder Header'),
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
