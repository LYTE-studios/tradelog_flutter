import 'package:flutter/material.dart';

class TradelyErrorText extends StatelessWidget {
  final String? error;

  const TradelyErrorText({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: error == null
          ? const SizedBox()
          : Align(
              alignment: Alignment.centerLeft,
              child: Text(
                error ?? '',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
    );
  }
}
