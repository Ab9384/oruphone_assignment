import 'package:flutter/material.dart';

import 'custom_child_scrollview.dart';

class CustomChildScrollViewHorizontal extends StatelessWidget {
  final Widget child;
  const CustomChildScrollViewHorizontal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StretchingOverscrollIndicator(
        axisDirection: AxisDirection.right,
        child: ScrollConfiguration(
            behavior: NoScrollBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: child,
            )));
  }
}
