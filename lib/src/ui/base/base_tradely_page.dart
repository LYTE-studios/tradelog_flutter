import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseTradelyPage extends StatelessWidget {
  final Widget? child;

  final Widget? header;

  const BaseTradelyPage({
    super.key,
    this.child,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: PaddingSizes.large,
        right: PaddingSizes.large,
        bottom: PaddingSizes.large,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: PaddingSizes.xxl,
              left: PaddingSizes.large,
            ),
            child: header ?? const SizedBox.shrink(),
          ),
          Expanded(child: child ?? const SizedBox.shrink()),
        ],
      ),
    );
  }
}
