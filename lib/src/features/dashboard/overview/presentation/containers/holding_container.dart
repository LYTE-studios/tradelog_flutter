import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class HoldingContainer extends StatelessWidget {
  final double holdingTime;

  const HoldingContainer({super.key, required this.holdingTime});

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      padding: const EdgeInsets.all(
        PaddingSizes.large,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Average Holding Time",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                ),
          ),
          Expanded(
            child: Row(
              children: [
                SvgIcon(
                  TradelyIcons.reset,
                  color: TextStyles.mediumTitleColor,
                  size: 22,
                ),
                const SizedBox(
                  width: PaddingSizes.small,
                ),
                Expanded(
                  child: FittedBox(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 18),
                        children: const [
                          TextSpan(text: '0 ', style: TextStyle(fontSize: 18)),
                          TextSpan(text: 'Days  '),
                          TextSpan(text: '7 ', style: TextStyle(fontSize: 18)),
                          TextSpan(text: 'Hours  '),
                          TextSpan(text: '12 ', style: TextStyle(fontSize: 18)),
                          TextSpan(text: 'Minutes  '),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
