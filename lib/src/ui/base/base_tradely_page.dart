import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseTradelyPage extends StatelessWidget {
  final Widget? child;

  final Widget? header;

  final EdgeInsets? padding;

  const BaseTradelyPage({
    super.key,
    this.child,
    this.header,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding ??
          const EdgeInsets.only(
            left: PaddingSizes.large,
            right: PaddingSizes.large,
            bottom: PaddingSizes.large,
          ),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: PaddingSizes.xxl,
            left: PaddingSizes.large,
          ),
          child: header ?? const SizedBox.shrink(),
        ),
        child ?? const SizedBox.shrink(),
      ],
    );
  }
}
