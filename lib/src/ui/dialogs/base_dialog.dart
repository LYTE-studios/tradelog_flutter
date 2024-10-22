import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';

class BaseDialog extends StatelessWidget {
  final Widget child;

  final BoxConstraints? constraints;

  final EdgeInsets? padding;

  const BaseDialog({
    super.key,
    required this.child,
    this.constraints,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        constraints: constraints,
        padding: padding,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(
            BorderRadii.large,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              const Positioned(
                top: 0,
                right: 0,
                child: CloseButton(),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
