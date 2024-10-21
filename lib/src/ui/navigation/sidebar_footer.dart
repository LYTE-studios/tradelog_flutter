import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/broker_connection_dialog.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class SidebarFooter extends StatelessWidget {
  final bool extended;

  const SidebarFooter({
    super.key,
    required this.extended,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Sidebar.animationDuration,
      child: Column(
        children: [
          PrimaryButton(
            width: extended ? null : 48,
            align:
                extended ? MainAxisAlignment.start : MainAxisAlignment.center,
            onTap: () {},
            height: 48,
            padding: extended ? null : EdgeInsets.zero,
            prefixIconPadding: extended ? null : EdgeInsets.zero,
            text: extended ? "Add new trade" : null,
            prefixIcon: TradelyIcons.plusCircle,
            prefixIconSize: 22,
          ),
          const SizedBox(
            height: PaddingSizes.small,
          ),
          ClearInkWell(
            child: BaseContainer(
              outsidePadding: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadii.small,
              height: 48,
              width: extended ? null : 48,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          // todo -> icons that rotate
                          extended ? PaddingSizes.medium : PaddingSizes.xxs,
                    ),
                    child: const SvgIcon(
                      TradelyIcons.tradelyLogoPro,
                      leaveUnaltered: true,
                    ),
                  ),
                  if (extended)
                    Text(
                      "Link exchange",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: TextStyles.bodyColor,
                          ),
                    ),
                ],
              ),
            ),
            onTap: () => BrokerConnectionDialog.show(context),
          ),
          // if (extended)
          //   const SizedBox(
          //     height: PaddingSizes.large,
          //   ),
          // if (extended)
          //   Align(
          //     alignment: Alignment.centerLeft,
          //     child: Padding(
          //       padding: const EdgeInsets.only(
          //         left: PaddingSizes.medium,
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             sessionManager.signedInUser?.fullName ?? '',
          //             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          //                   fontSize: 17,
          //                 ),
          //           ),
          //           const SizedBox(
          //             height: PaddingSizes.xxs,
          //           ),
          //           Text(
          //             sessionManager.signedInUser?.email ?? '',
          //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //                   fontSize: 15,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
