import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageBuilderUtils {
  static Widget buildRightSlideAnimation(
    context,
    animation,
    secondaryAnimation,
    child,
  ) {
    late final Animation<Offset> offsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
      ),
    );

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  static Page buildPageWithAnimationBuilder({
    required BuildContext context,
    required Widget child,
    required Widget Function(
      BuildContext,
      Animation<double>,
      Animation<double>,
      Widget,
    ) builder,
  }) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: builder,
      child: child,
    );
  }
}
