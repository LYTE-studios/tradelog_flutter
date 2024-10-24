import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class TradelyProContainer extends StatelessWidget {
  const TradelyProContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BaseContainer(
      width: 430,
      height: 215,
      backgroundColor: const Color(0xFF181818),
      enableBorder: false,
      boxConstraints: const BoxConstraints(
        minWidth: 100,
        maxWidth: 687,
      ),
      padding: const EdgeInsets.only(
        left: PaddingSizes.extraLarge,
        right: PaddingSizes.extraLarge,
        top: PaddingSizes.xxl,
        bottom: PaddingSizes.medium,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SvgIcon(
                TradelyIcons.tradelyLogoText,
                color: Colors.white,
                size: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 5,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$29',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(width: PaddingSizes.xxxs),
                    Text(
                      '/month',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 15,
                        color: const Color(0xFF949494),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const SvgIcon(
                        TradelyIcons.check,
                        size: 18,
                        color: Color(0xFF14D39F),
                      ),
                      const SizedBox(width: PaddingSizes.extraSmall),
                      Text(
                        'Lorem Ipsum Dolor',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PaddingSizes.xxs),
                  Row(
                    children: [
                      const SvgIcon(
                        TradelyIcons.check,
                        size: 18,
                        color: Color(0xFF14D39F),
                      ),
                      const SizedBox(width: PaddingSizes.extraSmall),
                      Text(
                        'Lorem Ipsum Dolor',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: PaddingSizes.extraLarge),
              Column(
                children: [
                  Row(
                    children: [
                      const SvgIcon(
                        TradelyIcons.check,
                        size: 18,
                        color: Color(0xFF14D39F),
                      ),
                      const SizedBox(width: PaddingSizes.extraSmall),
                      Text(
                        'Lorem Ipsum Dolor',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PaddingSizes.xxs),
                  Row(
                    children: [
                      const SvgIcon(
                        TradelyIcons.check,
                        size: 18,
                        color: Color(0xFF14D39F),
                      ),
                      const SizedBox(width: PaddingSizes.extraSmall),
                      Text(
                        'Lorem Ipsum Dolor',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          PrimaryButton(
            onTap: () {}, // link to Stripe Subscription Management System
            height: 48,
            text: 'Manage subscription',
            color: const Color(0xFF262626),
          )
        ],
      ),
    );
  }
}
