import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/chart_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/holding_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/long_short_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/profit_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  static const String route = '/$location';
  static const String location = 'overview';

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> with ScreenStateMixin {
  TradelyProfile? profile;

  @override
  Future<void> loadData() async {
    profile = await client.profile.getProfile();

    setState(() {
      profile = profile;
    });

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Discover all your performance metrics & progress.",
        icon: TradelyIcons.overview,
        currentRoute: OverviewScreen.location,
        title:
            "Good morning${(profile?.firstName.isEmpty ?? true) ? '' : ' ${profile?.firstName ?? ''}'}!",
        titleIconPath: 'assets/images/emojis/hand_emoji.png',
        buttons: PrimaryButton(
          onTap: () {},
          height: 42,
          text: "Add new trade",
          prefixIcon: TradelyIcons.plusCircle,
          prefixIconSize: 22,
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      DataContainer(
                        title: 'Net Profit/Loss',
                        toolTip: 'test',
                      ),
                      DataContainer(
                        title: 'Trade win rate',
                        toolTip: 'test',
                        data: "43%",
                        percentage: -2,
                      ),
                      DataContainer(
                        title: ' Avg realized R:R',
                        toolTip: 'test',
                        data: "\$123,88",
                        percentage: 45,
                      ),
                    ],
                  ),
                ),
                ChartContainer(
                  titleText: 'Equity Line',
                  toolTipText: 'This graph shows the equity line',
                  data: null,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                LongShortContainer(),
                HoldingContainer(
                  holdingTime: 20,
                ),
                ProfitContainer(
                  percentage: 45,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
