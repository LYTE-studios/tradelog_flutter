import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/ui/selectable/clear_ink_well.dart';
import 'package:tradelog_flutter/src/core/data/models/enums/trade_enums.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class LongShortButtons extends StatelessWidget {
  final TradeOption? selected;
  final Function(TradeOption?) onChanged;

  const LongShortButtons({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget buildButton(String label, TradeOption? value) {
      return ClearInkWell(
        onTap: () => onChanged(value),
        child: Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 14,
            color: selected == value ? TextStyles.titleColor : null,
          ),
        ),
      );
    }

    return Row(
      children: [
        buildButton("All", null),
        const SizedBox(
          width: PaddingSizes.medium,
        ),
        buildButton("Long", TradeOption.long),
        const SizedBox(
          width: PaddingSizes.medium,
        ),
        buildButton("Short", TradeOption.short),
      ],
    );
  }
}
