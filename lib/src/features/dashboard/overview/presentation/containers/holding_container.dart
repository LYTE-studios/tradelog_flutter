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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Average Holding Time",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            children: [
              SvgIcon(
                TradelyIcons.reset,
                color: TextStyles.mediumTitleColor,
                size: 22,
              ),
              const SizedBox(
                width: PaddingSizes.large,
              ),
              // todo make widget for these
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18),
                  children: const <TextSpan>[
                    TextSpan(text: '0 ', style: TextStyle(fontSize: 24)),
                    TextSpan(text: 'Days'),
                  ],
                ),
              ),
              const SizedBox(
                width: PaddingSizes.large,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18),
                  children: const <TextSpan>[
                    TextSpan(text: '7 ', style: TextStyle(fontSize: 24)),
                    TextSpan(text: 'Hours '),
                  ],
                ),
              ),
              const SizedBox(
                width: PaddingSizes.large,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18),
                  children: const <TextSpan>[
                    TextSpan(text: '12 ', style: TextStyle(fontSize: 24)),
                    TextSpan(text: 'Minutes'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}