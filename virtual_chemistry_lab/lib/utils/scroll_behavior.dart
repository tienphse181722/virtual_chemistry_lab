import 'package:flutter/material.dart';

/// Custom ScrollBehavior to disable overscroll glow effect
/// This prevents the "stretch" effect when scrolling past the edge
class NoOverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Return child without any overscroll indicator
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // Use ClampingScrollPhysics to prevent bounce/stretch
    return const ClampingScrollPhysics();
  }
}
