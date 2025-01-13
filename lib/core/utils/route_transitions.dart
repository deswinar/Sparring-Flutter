import 'package:flutter/material.dart';

class SlideAndFadeTransitionBuilder {
  static Widget build(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child, {
    Offset begin = const Offset(0.0, 1.0),
    Offset end = Offset.zero,
    Curve curve = Curves.easeInOut,
  }) {
    final tween = Tween<Offset>(begin: begin, end: end);
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
