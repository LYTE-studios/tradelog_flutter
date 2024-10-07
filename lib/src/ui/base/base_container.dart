import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseContainer extends StatelessWidget {
  final Widget? child;

  final double? height;

  final double? width;

  final EdgeInsets? padding;

  final double? borderRadius;

  final Color? backgroundColor;

  final bool enableBorder;

  final EdgeInsets? outsidePadding;

  final BoxConstraints? boxConstraints;

  const BaseContainer({
    super.key,
    this.child,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.enableBorder = true,
    this.outsidePadding,
    this.boxConstraints,
  });

  @override
  Widget build(BuildContext context) {
    // clipRRect is specifically for the data_list, the list items can have a different color.
    return Padding(
      padding: outsidePadding ??
          const EdgeInsets.symmetric(
            vertical: PaddingSizes.extraSmall,
            horizontal: PaddingSizes.xxs,
          ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          borderRadius ?? BorderRadii.large,
        ),
        child: Container(
          constraints: boxConstraints,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: enableBorder
                ? Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.outline,
                  )
                : null,
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
      ),
    );
  }
}
