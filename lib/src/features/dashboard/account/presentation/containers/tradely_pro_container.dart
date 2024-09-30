import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/enums/tradely_enums.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/plan_option.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/subscription_toggle_tab.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class TradelyProContainer extends StatelessWidget {
  const TradelyProContainer({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return BaseContainer(
      boxConstraints: const BoxConstraints(
        minWidth: 100,
        maxWidth: 687,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: PaddingSizes.xxxl,
        vertical: PaddingSizes.xxl * 2,
      ),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                SvgIcon(
                  size: 30,
                  TradelyIcons.tradelyLogoText,
                  leaveUnaltered: true,
                ),
                SizedBox(
                  width: PaddingSizes.xxs,
                ),
                SvgIcon(
                  size: 30,
                  TradelyIcons.tradelyLogoPro,
                  leaveUnaltered: true,
                ),
              ],
            ),
            const SizedBox(
              height: PaddingSizes.large,
            ),
            SubscriptionToggleTab(
              onToggle: (ProFrequency proFrequency) {},
              height: 50,
              width: 350,
            ),
            const SizedBox(
              height: PaddingSizes.xxl,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlanOption(
                  title: SizedBox(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Free"),
                    ),
                  ),
                  price: 20,
                  isSelected: true,
                  subTitle: "Need more? Go PRO!",
                ),
                SizedBox(
                  width: PaddingSizes.large,
                ),
                PlanOption(
                  title: SizedBox(
                    height: 50,
                    child: SvgIcon(
                      size: 35,
                      TradelyIcons.tradelyLogoPro,
                      leaveUnaltered: true,
                    ),
                  ),
                  price: 20,
                  isSelected: true,
                  subTitle: "Save \$45 with annual plan",
                ),
              ],
            ),
            const SizedBox(
              height: PaddingSizes.extraLarge,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(
                  BorderRadii.large,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSizes.xxl,
                  vertical: PaddingSizes.medium,
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Terms and conditions apply, for more info ",
                    children: [
                      TextSpan(
                        text: "click here",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Uri url = Uri.parse("https://tradely.io/");
                            if (await canLaunchUrl(url)) {
                              launchUrl(
                                Uri.parse("https://tradely.io/"),
                              );
                            }
                          },
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: colorScheme.primary,
                        ),
                      ),
                    ],
                    style: textTheme.labelMedium?.copyWith(
                      color: TextStyles.subTitleColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
