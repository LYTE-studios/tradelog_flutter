import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class BaseTradelyPageHeader extends StatelessWidget {
  final String currentRoute;

  final String title;

  final String? subTitle;

  final String? icon;

  final Widget? buttons;

  const BaseTradelyPageHeader({
    super.key,
    required this.currentRoute,
    required this.title,
    this.subTitle,
    this.buttons,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Row(
              children: [
                if (icon != null) SvgIcon(icon!),
                Text(
                  currentRoute,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: TextStyles.selectedMediumTitleColor,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PaddingSizes.medium,
                  ),
                  child: SvgIcon(TradelyIcons.diary),
                ),
                Text("General"),
              ],
            ),
          ],
        )
      ],
    );
  }
}
