import 'package:flutter/material.dart';

class CustomChildScrollView extends StatelessWidget {
  final Widget child;
  final ScrollController? scrollController;
  const CustomChildScrollView(
      {super.key, required this.child, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return StretchingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        child: ScrollConfiguration(
            behavior: NoScrollBehavior(),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              child: child,
            )));
  }
}

class NoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
