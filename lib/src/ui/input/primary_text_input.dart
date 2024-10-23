import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class PrimaryTextInput extends StatelessWidget {
  final double? height;

  final double? width;

  final TextEditingController tec;

  final String? label;

  final String? hint;

  final bool isError;

  final bool isPassword;

  final Widget? suffixIcon;

  final bool isObscure;

  final BoxConstraints? suffixIconConstraints;

  final EdgeInsets? contentPadding;

  final bool readOnly;

  final Function()? onSave;

  const PrimaryTextInput({
    super.key,
    this.height,
    this.width,
    required this.tec,
    this.label,
    this.hint,
    this.isError = false,
    this.isPassword = false,
    this.isObscure = false,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.contentPadding,
    this.readOnly = false,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(
              bottom: PaddingSizes.small,
            ),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        SizedBox(
          height: height,
          width: width ?? 200,
          child: TextFormField(
            readOnly: readOnly,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                ),
            onFieldSubmitted: (_) => onSave?.call(),
            controller: tec,
            decoration: InputDecoration(
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: PaddingSizes.extraLarge,
                    vertical: PaddingSizes.extraLarge,
                  ),
              hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isError
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
              fillColor: isError
                  ? Theme.of(context).colorScheme.error.withOpacity(0.1)
                  : Theme.of(context).colorScheme.tertiaryContainer,
              hintText: hint,
              error: isError ? const SizedBox() : null,
              suffixIcon: suffixIcon,
              suffixIconConstraints: suffixIconConstraints,
            ),
            obscureText: isObscure,
          ),
        ),
      ],
    );
  }
}
