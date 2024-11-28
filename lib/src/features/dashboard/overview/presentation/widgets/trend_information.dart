import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class TrendInformation extends StatelessWidget {
  final double? percentage;

  const TrendInformation({
    super.key,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    bool up = (percentage ?? 0) > 0;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        percentage != null
            ? Padding(
                padding: const EdgeInsets.only(
                  right: PaddingSizes.xxs,
                ),
                child: SvgIcon(
                  up ? TradelyIcons.trendUp : TradelyIcons.trendDown,
                  color: up ? colorScheme.tertiary : colorScheme.error,
                  size: 10,
                ),
              )
            : const SizedBox.shrink(),
        Text(
          percentage != null && percentage != null ? "$percentage%" : "- %",
          style: textTheme.bodySmall?.copyWith(
            fontSize: 14,
            color: percentage != null && percentage != 0
                ? up
                    ? colorScheme.tertiary
                    : colorScheme.error
                : null,
          ),
        ),
        Text(
          " vs last month",
          style: textTheme.bodySmall?.copyWith(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
