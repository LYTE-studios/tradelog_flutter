import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class TradelyProContainer extends StatelessWidget {
  const TradelyProContainer({super.key});

  Future<void> _launchUrl() async {
    const url = 'https://www.stripe.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SvgIcon(
                        TradelyIcons.check,
                        size: 18,
                        color: Color(0xFF14D39F),
                      ),
                      const SizedBox(width: PaddingSizes.extraSmall),
                      Text(
                        'Tracking trades',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PaddingSizes.xxs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SvgIcon(
                        TradelyIcons.check,
                        size: 18,
                        color: Color(0xFF14D39F),
                      ),
                      const SizedBox(width: PaddingSizes.extraSmall),
                      Text(
                        'Export reports',
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SvgIcon(
                        TradelyIcons.check,
                        size: 18,
                        color: Color(0xFF14D39F),
                      ),
                      const SizedBox(width: PaddingSizes.extraSmall),
                      Text(
                        'Sync broker',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PaddingSizes.xxs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SvgIcon(
                        TradelyIcons.check,
                        size: 18,
                        color: Color(0xFF14D39F),
                      ),
                      const SizedBox(width: PaddingSizes.extraSmall),
                      Text(
                        'Key metrics',
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
            onTap: _launchUrl, // link to Stripe Subscription Management System
            height: 48,
            text: 'Manage subscription',
            color: const Color(0xFF262626),
          )
        ],
      ),
    );
  }
}
