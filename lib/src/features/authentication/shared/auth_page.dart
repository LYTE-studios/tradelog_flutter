import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  final Widget child;

  const AuthPage({
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
              child: Container(),
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 430,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
