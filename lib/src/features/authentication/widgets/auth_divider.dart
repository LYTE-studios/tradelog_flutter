import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.outline,
            thickness: 1,
            endIndent: 10, // spacing between divider and text
          ),
        ),
        Text(
          'OR',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 15,
              ),
        ),
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.outline,
            thickness: 1,
            indent: 10, // spacing between text and divider
          ),
        ),
      ],
    );
  }
}
