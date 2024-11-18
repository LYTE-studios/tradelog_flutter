import 'package:flutter/material.dart';

class TradelyLoadingSpinner extends StatelessWidget {
  final Color? color;

  const TradelyLoadingSpinner({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 14,
        width: 14,
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.onPrimary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
