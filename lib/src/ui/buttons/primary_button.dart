import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;

  final double height;

  final double? width;

  final String? text;

  final EdgeInsets? padding;

  final MainAxisAlignment? align;

  final double? borderRadii;

  final String? prefixIcon;

  final EdgeInsets? prefixIconPadding;

  final Color? color;

  /// expand button to parent widget, overwritten by width.
  final bool expand;

  const PrimaryButton({
    super.key,
    required this.onTap,
    this.text,
    required this.height,
    this.width,
    this.padding,
    this.align,
    this.borderRadii,
    this.prefixIcon,
    this.prefixIconPadding,
    this.color,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClearInkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadii ?? BorderRadii.small,
          ),
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: PaddingSizes.large,
              ),
          child: Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: align ?? MainAxisAlignment.center,
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: prefixIconPadding ??
                      const EdgeInsets.only(
                        right: PaddingSizes.small,
                      ),
                  child: SvgIcon(
                    prefixIcon!,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              Text(text ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
