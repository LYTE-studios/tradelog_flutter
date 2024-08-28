import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class SidebarPro extends StatelessWidget {
  final bool extended;

  const SidebarPro({
    super.key,
    required this.extended,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Sidebar.animationDuration,
      child: !extended
          ? const SvgIcon(
              TradelyIcons.tradelyProLogo,
              leaveUnaltered: true,
              size: 24,
            )
          : Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(
                  BorderRadii.small,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSizes.large,
                  vertical: PaddingSizes.extraLarge,
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgIcon(
                          TradelyIcons.tradelyLogo,
                          leaveUnaltered: true,
                          size: 24,
                        ),
                        SizedBox(
                          width: PaddingSizes.medium,
                        ),
                        SvgIcon(
                          TradelyIcons.tradelyProLogo,
                          leaveUnaltered: true,
                          size: 24,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: PaddingSizes.extraLarge,
                    ),
                    PrimaryButton(
                      onTap: () {},
                      height: 40,
                      text: "Upgrade now",
                      textStyle:
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: TextStyles.titleColor,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    const SizedBox(
                      height: PaddingSizes.extraSmall,
                    ),
                    PrimaryButton(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      onTap: () {},
                      height: 40,
                      text: "See more",
                      textStyle:
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: TextStyles.labelTextColor,
                              ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
