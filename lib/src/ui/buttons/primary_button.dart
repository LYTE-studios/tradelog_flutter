import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_switcher.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class PrimaryButton extends StatefulWidget {
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

  final String? suffixIcon;

  final double? suffixIconSize;

  final EdgeInsets? suffixIconPadding;

  final Color? suffixIconColor;

  final Color? color;

  final TextStyle? textStyle;

  final bool leaveIconUnaltered;

  final bool outlined;

  final Color? borderColor;

  final Widget? prefixChild;
  final Widget? suffixChild;

  /// expand button to parent widget, overwritten by width.
  final bool expand;

  final bool loading;

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
    this.outlined = false,
    this.borderColor,
    this.prefixChild,
    this.loading = false,
    this.suffixIcon,
    this.suffixIconSize,
    this.suffixIconPadding,
    this.suffixIconColor,
    this.suffixChild,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool shouldScaleDown = false;

  @override
  Widget build(BuildContext context) {
    return ClearInkWell(
      onTap: () async {
        widget.onTap.call();

        setState(() {
          shouldScaleDown = true;
        });
        await Future.delayed(const Duration(milliseconds: 50));

        setState(() {
          shouldScaleDown = false;
        });
      },
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        transformAlignment: Alignment.center,
        transform: (shouldScaleDown
            ? (Matrix4.identity()..scale(0.96, 0.96))
            : Matrix4.identity()),
        decoration: BoxDecoration(
          color: widget.color ?? Theme.of(context).colorScheme.primary,
          border: widget.outlined
              ? Border.all(
                  color: widget.borderColor ?? const Color(0xFF2D62FE),
                )
              : null,
          borderRadius: BorderRadius.circular(
            widget.borderRadii ?? BorderRadii.small,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            widget.borderRadii ?? BorderRadii.small,
          ),
          child: Padding(
            padding: widget.padding ??
                const EdgeInsets.symmetric(
                  horizontal: PaddingSizes.extraLarge,
                ),
            child: TradelyLoadingSwitcher(
              loading: widget.loading,
              child: Row(
                mainAxisSize:
                    widget.expand ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: widget.align ?? MainAxisAlignment.center,
                children: [
                  if (widget.prefixIcon != null)
                    Padding(
                      padding: widget.prefixIconPadding ??
                          const EdgeInsets.only(
                            right: PaddingSizes.extraSmall,
                          ),
                      child: SvgIcon(
                        widget.prefixIcon!,
                        size: widget.prefixIconSize ?? 22,
                        color: widget.prefixIconColor ??
                            Theme.of(context).colorScheme.onPrimary,
                        leaveUnaltered: widget.leaveIconUnaltered,
                      ),
                    ),
                  if (widget.prefixChild != null) widget.prefixChild!,
                  if (widget.text != null)
                    Text(
                      widget.text!,
                      style: widget.textStyle ??
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: TextStyles.titleColor,
                                fontSize: 16,
                              ),
                    ),
                  if (widget.suffixIcon != null)
                    Padding(
                      padding: widget.suffixIconPadding ??
                          const EdgeInsets.only(
                            right: PaddingSizes.extraSmall,
                          ),
                      child: SvgIcon(
                        widget.suffixIcon!,
                        size: widget.suffixIconSize ?? 22,
                        color: widget.suffixIconColor ??
                            Theme.of(context).colorScheme.onPrimary,
                        leaveUnaltered: widget.leaveIconUnaltered,
                      ),
                    ),
                  if (widget.suffixChild != null) widget.suffixChild!
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
