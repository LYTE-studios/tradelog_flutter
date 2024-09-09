import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseContainerExpanded extends StatelessWidget {
  final Widget? child;

  final double? height;

  final double? width;

  final EdgeInsets? padding;

  final double? borderRadius;

  final int flex;

  const BaseContainerExpanded({
    super.key,
    this.child,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: PaddingSizes.extraSmall,
          horizontal: PaddingSizes.xxs,
        ),
        child: BaseContainer(
          height: height ?? double.infinity,
          width: width ?? double.infinity,
          padding: padding,
          borderRadius: borderRadius,
          child: child,
        ),
      ),
    );
  }
}
