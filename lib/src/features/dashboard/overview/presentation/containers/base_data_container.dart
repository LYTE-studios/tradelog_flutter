import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseDataContainer extends StatelessWidget {
  final String title;
  final String toolTip;
  final Widget child;
  final bool isSuffixIcon;
  final bool isPrefixIcon;
  final String? titleImage;
  final VoidCallback? onViewAllTrades;
  final VoidCallback? onRefresh;
  final String? buttonText;
  final Widget? customButtonContent;
  final Widget? additionalHeaderWidget;

  const BaseDataContainer({
    super.key,
    required this.title,
    required this.toolTip,
    required this.child,
    this.isSuffixIcon = false,
    this.isPrefixIcon = true,
    this.titleImage,
    this.onViewAllTrades,
    this.onRefresh,
    this.buttonText,
    this.customButtonContent,
    this.additionalHeaderWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
