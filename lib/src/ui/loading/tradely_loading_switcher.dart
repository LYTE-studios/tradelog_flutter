import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_spinner.dart';

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
      duration: kThemeAnimationDuration,
      child: loading ? const TradelyLoadingSpinner() : child,
    );
  }
}
