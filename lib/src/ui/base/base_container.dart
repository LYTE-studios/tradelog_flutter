import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_switcher.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseContainer extends StatelessWidget {
  final bool loading;

  final Widget? child;

  final double? height;

  final double? width;

  final EdgeInsets? padding;

  final double? borderRadius;

  final Color? backgroundColor;

  final bool enableBorder;

  final Color? borderColor;

  final double? borderWidth;

  final EdgeInsets? outsidePadding;

  final BoxConstraints? boxConstraints;

  const BaseContainer({
    super.key,
    this.loading = false,
    this.child,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.enableBorder = true,
    this.outsidePadding,
    this.boxConstraints,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outsidePadding ??
          const EdgeInsets.symmetric(
            vertical: PaddingSizes.extraSmall,
            horizontal: PaddingSizes.extraSmall,
          ),
      child: Container(
        constraints: boxConstraints,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            width: borderWidth ?? 1,
            color: !enableBorder
                ? Colors.transparent
                : borderColor ?? Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius ?? BorderRadii.large,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            borderRadius ?? BorderRadii.large,
          ),
          child: TradelyLoadingSwitcher(
            loading: loading,
            child: Padding(
              padding: padding ??
                  const EdgeInsets.all(
                    PaddingSizes.xxl,
                  ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
