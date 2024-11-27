import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';

class BaseContainerExpanded extends StatelessWidget {
  final bool loading;

  final Widget? child;

  final double? height;

  final double? width;

  final EdgeInsets? padding;

  final double? borderRadius;

  final int flex;

  final BoxConstraints? boxConstraints;

  const BaseContainerExpanded({
    super.key,
    this.loading = false,
    this.child,
    this.height,
    this.width,
    this.padding,
    this.borderRadius,
    this.flex = 1,
    this.boxConstraints,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: BaseContainer(
        loading: loading,
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        padding: padding,
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}
