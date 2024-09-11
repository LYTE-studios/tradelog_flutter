import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;

  final double height;

  final double? width;

  final String? text;

  final EdgeInsets? padding;

  final MainAxisAlignment? align;

  final double? borderRadii;

  final String? prefixIcon;

  final double? prefixIconSize;

  final EdgeInsets? prefixIconPadding;

  final Color? prefixIconColor;

  final Color? color;

  final TextStyle? textStyle;

  final bool leaveIconUnaltered;

  final Border? border;

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
    this.prefixIconSize,
    this.textStyle,
    this.leaveIconUnaltered = false,
    this.prefixIconColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    // keep this here or it breaks the colors
    return Material(
      child: InkWell(
        onTap: onTap,
        // TODO: Remove the double border radii.
        // This is currently a workaround for clipping the InkWell
        borderRadius: BorderRadius.circular(
          borderRadii ?? BorderRadii.small,
        ),
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border,
            color: color ?? Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(
              borderRadii ?? BorderRadii.small,
            ),
          ),
          child: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: PaddingSizes.extraLarge,
                ),
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: align ?? MainAxisAlignment.center,
              children: [
                if (prefixIcon != null)
                  Padding(
                    padding: prefixIconPadding ??
                        const EdgeInsets.only(
                          right: PaddingSizes.extraSmall,
                        ),
                    child: SvgIcon(
                      prefixIcon!,
                      size: prefixIconSize ?? 22,
                      color: prefixIconColor ??
                          Theme.of(context).colorScheme.onPrimary,
                      leaveUnaltered: leaveIconUnaltered,
                    ),
                  ),
                if (text != null)
                  Text(
                    text!,
                    style: textStyle ??
                        Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: TextStyles.titleColor,
                              fontSize: 16,
                            ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
