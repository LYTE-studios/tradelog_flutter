import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class PasswordTextInput extends StatefulWidget {
  final double? height;

  final double? width;

  final TextEditingController tec;

  final String? label;

  final String? hint;

  final bool isError;

  final Widget? suffixIcon;

  final EdgeInsets? contentPadding;

  const PasswordTextInput({
    super.key,
    required this.tec,
    this.height,
    this.width,
    this.label,
    this.hint,
    this.isError = false,
    this.suffixIcon,
    this.contentPadding,
  });

  @override
  State<PasswordTextInput> createState() => _PasswordTextInputState();
}

class _PasswordTextInputState extends State<PasswordTextInput> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return PrimaryTextInput(
      hint: widget.hint,
      label: widget.label,
      height: widget.height,
      width: widget.width,
      isError: widget.isError,
      isPassword: true,
      isObscure: obscure,
      contentPadding: widget.contentPadding,
      tec: widget.tec,
      suffixIconConstraints: const BoxConstraints(
        maxWidth: 40,
        maxHeight: 25,
      ),
      suffixIcon: SizedBox(
        // Fixes sizing issue
        height: double.infinity,
        child: ClearInkWell(
          onTap: () {
            setState(() {
              obscure = !obscure;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: PaddingSizes.medium,
            ),
            child: Center(
              child: SvgIcon(
                obscure ? TradelyIcons.eyeOpen : TradelyIcons.eyeClosed,
                size: obscure ? 16 : 25,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
