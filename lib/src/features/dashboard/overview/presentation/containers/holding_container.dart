import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class HoldingContainer extends StatelessWidget {
  final double? holdingTime;

  final bool loading;

  const HoldingContainer({
    super.key,
    this.holdingTime,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDataContainer(
      title: 'Average Holding Time',
      toolTip: 'The average duration trades are held',
      child: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 2,
              ),
              child: SvgIcon(
                TradelyIcons.reset,
                color: TextStyles.mediumTitleColor,
                size: 22,
              ),
            ),
            const SizedBox(
              width: PaddingSizes.extraSmall,
            ),
            RichText(
              text: holdingTime == null
                  ? const TextSpan(text: "-")
                  : TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 18),
                      children: [
                        TextSpan(
                          text: '${(holdingTime! / 1440).toInt()}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const TextSpan(text: ' Days  '),
                        TextSpan(
                          text: '${((holdingTime! / 60) % 24).toInt()}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const TextSpan(text: ' Hours  '),
                        TextSpan(
                          text: '${((holdingTime! / 60) % 60).toInt()}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const TextSpan(text: ' Minutes  '),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
