import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class PlanOption extends StatelessWidget {
  final Widget title;

  final int price;

  final bool isSelected;

  final String subTitle;

  const PlanOption({
    super.key,
    required this.title,
    required this.price,
    required this.isSelected,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        //width: 300,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(
            BorderRadii.large,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PaddingSizes.xxl,
            vertical: PaddingSizes.extraLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              Text("\$$price /month"),
              Text(
                subTitle,
                style: textTheme.titleMedium?.copyWith(
                  color: TextStyles.subTitleColor,
                ),
              ),
              const SizedBox(
                height: PaddingSizes.extraLarge,
              ),
              Row(
                children: [
                  SvgIcon(
                    TradelyIcons.check,
                    color: colorScheme.tertiary,
                  ),
                  const SizedBox(
                    width: PaddingSizes.small,
                  ),
                  Text(
                    "Lorum ipsum dolor",
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              Row(
                children: [
                  SvgIcon(
                    TradelyIcons.x,
                    color: colorScheme.error,
                  ),
                  const SizedBox(
                    width: PaddingSizes.small,
                  ),
                  Text(
                    "Lorum ipsum dolor",
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(
                height: PaddingSizes.xxl,
              ),
              PrimaryButton(
                onTap: () {},
                height: 48,
                text: "Current plan",
              )
            ],
          ),
        ),
      ),
    );
  }
}
