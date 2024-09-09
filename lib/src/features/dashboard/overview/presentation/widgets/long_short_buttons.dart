import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/ui/selectable/clear_ink_well.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/data/enum/long_short_selector.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class LongShortButtons extends StatelessWidget {
  final LongShortSelector selected;
  final Function(LongShortSelector) onChanged;

  const LongShortButtons({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buildButton(String label, LongShortSelector value) {
      return ClearInkWell(
        onTap: () => onChanged(value),
        child: Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            color: selected == value ? TextStyles.titleColor : null,
          ),
        ),
      );
    }

    return Row(
      children: [
        buildButton("All", LongShortSelector.all),
        const SizedBox(width: PaddingSizes.extraLarge),
        buildButton("Long", LongShortSelector.long),
        const SizedBox(width: PaddingSizes.extraLarge),
        buildButton("Short", LongShortSelector.short),
      ],
    );
  }
}
