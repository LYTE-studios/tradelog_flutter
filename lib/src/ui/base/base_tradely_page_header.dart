import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class BaseTradelyPageHeader extends StatelessWidget {
  final String currentRoute;

  final String title;

  final String? titleIconPath;

  final String? subTitle;

  final String? icon;

  final Widget? buttons;
  final Widget? trailing;
  final Widget? subHeader;

  const BaseTradelyPageHeader(
      {super.key,
      required this.currentRoute,
      required this.title,
      this.titleIconPath,
      this.subTitle,
      this.buttons,
      this.icon,
      this.trailing,
      this.subHeader});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: PaddingSizes.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: PaddingSizes.extraSmall,
                      ),
                      child: SvgIcon(
                        icon!,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  Text(
                    currentRoute,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: TextStyles.titleColor,
                        ),
                  ),
                ],
              ),
              trailing ?? const SizedBox.shrink(),
            ],
          ),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: PaddingSizes.extraSmall,
                      ),
                      if (titleIconPath != null && titleIconPath!.isNotEmpty)
                        Image.asset(
                          titleIconPath!,
                          width: 25,
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: PaddingSizes.extraSmall / 3,
                  ),
                  if (subTitle != null)
                    Text(
                      subTitle!,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                ],
              ),
              if (buttons != null) buttons!,
            ],
          ),
          SizedBox(
            height: PaddingSizes.extraLarge * 2,
          ),
          if (subHeader != null) subHeader!,
        ],
      ),
    );
  }
}
