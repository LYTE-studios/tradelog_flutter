import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseContainer extends StatelessWidget {
  final Widget? child;

  final double? height;

  final double? width;

  final EdgeInsets? padding;

  final double? borderRadius;

  const BaseContainer({
    super.key,
    this.child,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // clipRRect is specifically for the data_list, the list items can have a different color.
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        borderRadius ?? BorderRadii.large,
      ),
      child: Container(
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
      ),
    );
  }
}
