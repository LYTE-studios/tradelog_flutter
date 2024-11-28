import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class LinkedAccounts extends StatelessWidget {
  const LinkedAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Linked accounts",
          style: textTheme.titleSmall?.copyWith(
            fontSize: 18.5,
          ),
        ),
        Text(
          "Click to see more",
          style: textTheme.titleMedium?.copyWith(
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: PaddingSizes.extraLarge,
        ),
        // const LinkedAccount(),
        // const LinkedAccount(),
        // const LinkedAccount(),
        // const LinkedAccount(),
        // const LinkedAccount(),
        // const LinkedAccount(),
      ],
    );
  }
}
