import 'package:flutter/material.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
