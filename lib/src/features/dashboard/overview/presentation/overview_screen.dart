import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/paywall_dialog.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/activity_heatmap_container.dart';
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
  void initState() {
    super.initState();
    // Show the paywall dialog after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPaywallDialog(context);
    });
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
      child: Row(
        children: [
          const Expanded(
            flex: 2,
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      DataContainer(
                        title: 'Net Profit/Loss',
                        toolTip:
                            'The total realized net profit and loss for all closed trades.',
                      ),
                      DataContainer(
                        title: 'Trade win rate',
                        toolTip:
                            'Reflects the percentage of your winning trades out of total trades taken.',
                        data: "43%",
                        percentage: -2,
                      ),
                      DataContainer(
                        title: ' Avg realized R:R',
                        toolTip:
                            'Average Win / Average Loss = Average Realize R:R',
                        data: "\$123,88",
                        percentage: 45,
                      ),
                    ],
                  ),
                ),
                ChartContainer(
                  titleText: 'Equity line',
                  toolTipText:
                      "Your equity line shows your account’s value over time, highlighting profits and losses.",
                  data: null,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const LongShortContainer(),
                const HoldingContainer(
                  holdingTime: 20,
                ),
                const ProfitContainer(
                  percentage: 45,
                ),
                Expanded(child: ActivityHeatmapContainer()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _showPaywallDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible:
        false, // Prevent dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: PaywallDialog());
    },
  );
}
