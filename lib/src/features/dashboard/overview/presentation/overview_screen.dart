import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/paywall_dialog.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/add_trade_dialog.dart';
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

  OverviewStatisticsDto? statistics;

  @override
  Future<void> loadData() async {
    // // Show the paywall dialog after the screen is built
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showPaywallDialog(context);
    // });
    profile = await client.profile.getProfile();

    statistics = await client.statistics.getOverviewStatistics();

    setState(() {
      profile = profile;
      statistics = statistics;
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
          onTap: () => AddTradeDialog.show(context),
          height: 42,
          text: "Add new trade",
          prefixIcon: TradelyIcons.plusCircle,
          prefixIconSize: 22,
        ),
      ),
      child: Row(
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
                        toolTip:
                            'The total realized net profit and loss for all closed trades.',
                        // TODO
                        valueFormatter: "\$",
                        value: statistics?.netProfitLossThisMonth,
                        percentage: statistics?.netProfitLossTrend,
                      ),
                      DataContainer(
                        title: 'Trade win rate',
                        toolTip:
                            'Reflects the percentage of your winning trades out of total trades taken.',
                        value: statistics?.tradeWinRateThisMonth,
                        percentage: statistics?.tradeWinRateTrend,
                      ),
                      DataContainer(
                        title: ' Avg realized R:R',
                        involvedWidget: 'line_progress_bar',
                        // progressPercentage: '',
                        toolTip:
                            'Average Win / Average Loss = Average Realize R:R',
                        value: statistics?.realizedReturnThisMonth ?? 0,
                        percentage: statistics?.realizedReturnTrend ?? 0,
                        loading: loading,
                      ),
                    ],
                  ),
                ),
                // TODO
                const ChartContainer(
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
                // TODO container data
                LongShortContainer(
                  long: statistics?.longTradesAmount ?? 0,
                  short: statistics?.shortTradesAmount ?? 0,
                ),
                HoldingContainer(
                  holdingTime: statistics?.averageHoldingTime,
                ),
                ProfitContainer(
                  factor: statistics?.profitFactor,
                ),
                // TODO activityHeatmap
                const Expanded(
                  child: ActivityHeatmapContainer(),
                ),
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
        child: const PaywallDialog(),
      );
    },
  );
}
