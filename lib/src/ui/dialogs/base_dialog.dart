import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseDialog extends StatelessWidget {
  final Widget child;
  final BoxConstraints? constraints;
  final EdgeInsets? padding;
  final double opacity;
  final bool? enableBlur; // Optional blur control
  final bool showCloseButton; // Optional close button control

  const BaseDialog({
    super.key,
    required this.child,
    this.constraints,
    this.padding,
    required this.opacity,
    this.enableBlur = false, // Default to false if not provided
    this.showCloseButton = true, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Stack(
        children: [
          // Conditionally apply blur if enabled
          if (enableBlur == true)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                color: Colors.black.withOpacity(
                    0), // Transparent container for the blur effect
              ),
            ),
          Container(
            constraints: constraints,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withOpacity(opacity),
              borderRadius: BorderRadius.circular(
                BorderRadii.large,
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: padding ?? EdgeInsets.zero,
                    child: child,
                  ),
                  // Conditionally show the close button
                  if (showCloseButton)
                    Positioned(
                      top: PaddingSizes.xxl,
                      right: PaddingSizes.xxl,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const SvgIcon(
                          TradelyIcons.x,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
