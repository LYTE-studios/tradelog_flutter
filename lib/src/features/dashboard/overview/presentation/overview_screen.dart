import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/paywall_dialog.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/add_trade_dialog.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/web_statistic_chart.dart';
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
  @override
  Widget build(BuildContext context) {
    loading = true;

    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Discover all your performance metrics & progress.",
        icon: TradelyIcons.overview,
        currentRoute: OverviewScreen.location,
        title: "Good morning${(true) ? '' : ' ${'Tanguy' ?? ''}'}!",
        titleIconPath: 'assets/images/emojis/hand_emoji.png',
        buttons: PrimaryButton(
          onTap: () => AddTradeDialog.show(context),
          height: 42,
          text: "Add new trade",
          prefixIcon: TradelyIcons.plusCircle,
          prefixIconSize: 22,
        ),
      ),
      child: ListView(
        children: [
          // SizedBox(
          //   height: 420,
          //   child: Row(
          //     children: [
          //       Expanded(
          //         flex: 2,
          //         child: Column(
          //           children: [
          //             SizedBox(
          //               height: 140,
          //               child: Row(
          //                 children: [
          //                   DataContainer(
          //                     title: 'Net Profit/Loss',
          //                     toolTip:
          //                         'The total realized net profit and loss for all closed trades.',
          //                     value: statistics?.netProfitLossThisMonth,
          //                     percentage: statistics?.netProfitLossTrend,
          //                     loading: loading,
          //                   ),
          //                   const SizedBox(
          //                     width: PaddingSizes.small,
          //                   ),
          //                   DataContainer(
          //                     title: 'Trade win rate',
          //                     toolTip:
          //                         'Reflects the percentage of your winning trades out of total trades taken.',
          //                     value: statistics?.tradeWinRateThisMonth,
          //                     percentage: statistics?.tradeWinRateTrend,
          //                     loading: loading,
          //                   ),
          //                   const SizedBox(
          //                     width: PaddingSizes.small,
          //                   ),
          //                   ProgressDataContainer(
          //                     title: ' Avg realized R:R',
          //                     toolTip:
          //                         'Average Win / Average Loss = Average Realize R:R',
          //                     value: statistics?.realizedReturnThisMonth ?? 0,
          //                     percentage: statistics?.realizedReturnTrend ?? 0,
          //                     loading: loading,
          //                   )
          //                 ],
          //               ),
          //             ),
          //             const SizedBox(
          //               width: PaddingSizes.extraSmall,
          //             ),
          //             SizedBox(
          //               height: 460,
          //               child: ChartContainer(
          //                 title: 'Equity line',
          //                 toolTip:
          //                     "Your equity line shows your account’s value over time, highlighting profits and losses.",
          //                 data: statistics?.equityChartData ?? {},
          //                 balance:
          //                     statistics?.equityChartData?.values.firstOrNull,
          //                 loading: loading,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       const SizedBox(
          //         width: PaddingSizes.extraSmall,
          //       ),
          //       Expanded(
          //         child: Column(
          //           children: [
          //             LongShortContainer(
          //               long: statistics?.longTradesAmount ?? 0,
          //               short: statistics?.shortTradesAmount ?? 0,
          //               averageWin: generalStatistics?.averageWinningTrade,
          //               bestWin: generalStatistics?.largestProfit,
          //               bestLoss: generalStatistics?.largestLoss,
          //               averageWinStreak:
          //                   generalStatistics?.averageWinStreak?.toInt(),
          //               maxWinStreak: generalStatistics?.maxWinStreak?.toInt(),
          //               loading: loading,
          //             ),
          //             HoldingContainer(
          //               holdingTime: generalStatistics?.averageHoldingTime,
          //               loading: loading,
          //             ),
          //             ProfitContainer(
          //               factor: statistics?.profitFactor,
          //             ),
          //             // TODO activityHeatmap
          //             // const Expanded(
          //             //   child: ActivityHeatmapContainer(),
          //             // ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 240,
            child: Row(
              children: [
                Expanded(
                  child: BaseDataContainer(
                    title: 'Weekday',
                    toolTip: '',
                    child: Expanded(
                      child: WebStatisticChart(
                        data: const {
                          'Monday': 1,
                          'Tuesday': 2,
                          'Wednesday': 1,
                          'Thursday': 4,
                          'Friday': 1,
                          'Saturday': 3,
                          'Sunday': 2,
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BaseDataContainer(
                    title: 'Sessions',
                    toolTip: '',
                    child: Expanded(
                      child: WebStatisticChart(
                        color: HexColor.fromHex('#FFCC00'),
                        data: const {
                          'London': 4,
                          'New York': 2,
                          'Asia': 2,
                          'Pacific': 5,
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BaseDataContainer(
                    title: 'Pairs',
                    toolTip: '',
                    child: Expanded(
                      child: WebStatisticChart(
                        data: const {
                          'AUDCAD': 4,
                          'AUDNZD': 2,
                          'EURCAD': 5,
                          'AUDUSDA': 1,
                          'CHFNZD': 1,
                          'EURUSD': 3,
                          'EURNZD': 1,
                        },
                      ),
                    ),
                  ),
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
