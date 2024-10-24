import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class DropdownInput extends StatelessWidget {
  final double? height;
  final double? width;
  final String? label;
  final String? hint;
  final bool isError;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? contentPadding;

  const DropdownInput({
    super.key,
    this.height,
    this.width,
    this.label,
    this.hint,
    this.isError = false,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        SizedBox(
          width: width ?? 200,
          child: DropdownButtonFormField<String>(
            value: selectedItem,
            isDense: false,
            decoration: InputDecoration(
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: PaddingSizes.extraLarge,
                    vertical: 5,
                  ),
              filled: true,
              errorBorder: isError
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: onChanged,
            items: items
                .map(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 15,
                          ),
                    ),
                  ),
                )
                .toList(),
            isExpanded: true,
            hint: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hint ?? '',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isError
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.onTertiaryContainer,
                        fontSize: 15,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
