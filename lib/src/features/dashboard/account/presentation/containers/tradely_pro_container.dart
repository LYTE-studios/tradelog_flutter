import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/subscription_toggle_tab.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class TradelyProContainer extends StatelessWidget {
  const TradelyProContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      child: Column(
        children: [
          Row(
            children: [
              SvgIcon(
                TradelyIcons.tradelyLogoText,
                leaveUnaltered: true,
              ),
              SvgIcon(
                TradelyIcons.tradelyLogoPro,
                leaveUnaltered: true,
              ),
            ],
          ),
          SubscriptionToggleTab(
            callback: (int) {},
            height: 50,
            animatedBoxDecoration: BoxDecoration(
              color: Colors.orange,
            ),
            activeStyle: Theme.of(context).textTheme.labelMedium!,
            inactiveStyle: Theme.of(context).textTheme.labelMedium!,
            width: 350,
          ),
        ],
      ),
    );
  }
}
