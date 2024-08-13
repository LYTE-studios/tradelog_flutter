import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/authentication/shared/image_carousel.dart';

class AuthScreen extends StatelessWidget {
  final Widget child;

  const AuthScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const ImageCarousel(),
            ),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
