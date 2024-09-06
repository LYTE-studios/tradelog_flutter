import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class DataContainer extends StatelessWidget {
  final String title;

  final String toolTip;

  final String? data;

  final bool up;

  final int? percentage;

  const DataContainer({
    super.key,
    required this.title,
    required this.toolTip,
    this.data,
    this.up = true,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BaseContainerExpanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ToolTipTitle(
            titleText: title,
            toolTipText: toolTip,
          ),
          // This will scale the text based on the screen size.
          // Maybe not the best idea?
          // it overwrites the TextSize
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                data ?? "-",
                style: textTheme.bodyLarge,
              ),
            ),
          ),
          Row(
            children: [
              percentage != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                        right: PaddingSizes.extraSmall,
                      ),
                      child: SvgIcon(
                        up ? TradelyIcons.trendUp : TradelyIcons.trendDown,
                        color: up ? colorScheme.tertiary : colorScheme.error,
                        size: 12,
                      ),
                    )
                  : const SizedBox.shrink(),
              Text(
                percentage != null ? "$percentage%" : "-%",
                style: textTheme.bodySmall?.copyWith(
                  color: percentage != null
                      ? up
                          ? colorScheme.tertiary
                          : colorScheme.error
                      : null,
                ),
              ),
              Text(
                " vs last month",
                style: textTheme.bodySmall,
              )
            ],
          ),
        ],
      ),
    );
  }
}
