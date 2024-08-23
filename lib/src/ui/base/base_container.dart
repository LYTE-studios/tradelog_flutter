import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseContainer extends StatelessWidget {
  final Widget? child;

  final double? height;

  final double? width;

  final EdgeInsets? padding;

  final double? borderRadius;

  final int? flex;

  const BaseContainer({
    super.key,
    this.child,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius ?? BorderRadii.large,
        ),
      ),
      child: Padding(
        padding: padding ??
            const EdgeInsets.all(
              PaddingSizes.xxl,
            ),
        child: child,
      ),
    );
  }
}
