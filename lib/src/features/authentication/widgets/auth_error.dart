import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class AuthError extends StatelessWidget {
  final String? error;

  const AuthError({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnimatedSize(
      duration: kThemeAnimationDuration,
      child: error == null
          ? const SizedBox()
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: PaddingSizes.medium,
                ),
                child: Text(
                  error ?? '',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            ),
    );
  }
}
