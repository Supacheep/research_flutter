import 'package:flutter/material.dart';
import 'dimensions.dart';

class ResposiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;

  ResposiveLayout({required this.mobileBody, required this.tabletBody});

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    print('currentWidth: $currentWidth');
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidth) {
          return mobileBody;
        } else {
          return tabletBody;
        }
      },
    );
  }
}
