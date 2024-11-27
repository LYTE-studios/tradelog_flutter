import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_spinner.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class TradelyLoadingSwitcher extends StatelessWidget {
  final bool loading;

  final Widget child;

  const TradelyLoadingSwitcher({
    super.key,
    this.loading = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchOutCurve: Curves.decelerate,
      switchInCurve: Curves.decelerate,
      child: loading
          ? const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: PaddingSizes.small,
                  horizontal: PaddingSizes.extraSmall,
                ),
                child: TradelyLoadingSpinner(),
              ),
            )
          : child,
    );
  }
}
