import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/features/dashboard/statistics/presentation/widgets/small_data_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/filter_trades_button.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/data/data_list.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  static const String route = '/$location';
  static const String location = 'statistics';

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with ScreenStateMixin {
  StatisticsDto? statistics;

  @override
  Future<void> loadData() async {
    statistics = await client.statistics.getStatistics();

    setState(() {
      statistics = statistics;
    });
  }

  bool? isPositive(double? value) {
    if (value == null || value == 0) {
      return null;
    }

    return value > 0;
  }

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Track in-depth statistics, and export them as a csv.",
        icon: TradelyIcons.statistics,
        currentRoute: StatisticsScreen.location,
        title: "Statistics",
        titleIconPath: 'assets/images/emojis/statistics_emoji.png',
        buttons: Row(
          children: [
            PrimaryButton(
              onTap: () {},
              height: 42,
              text: "Export list",
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            const SizedBox(
              width: PaddingSizes.large,
            ),
            FilterTradesButton(
              onTap: () {},
              height: 42,
              text: "Filter trades",
              prefixIcon: TradelyIcons.diary,
              tradeStatusFilter: TradeStatus.open,
              tradeTypeFilter: Option.long,
              onUpdateTradeTypeFilter: (Option ty) {
                print(ty);
              },
              onUpdateTradeStatusFilter: (TradeStatus st) {
                print(st);
              },
              onResetFilters: () {},
              onShowTrades: () {},
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          // should this Row be a fixed height?
          SizedBox(
            height: 114,
            child: Row(
              children: [
                SmallDataContainer(
                  loading: loading,
                  title: 'Best trading month',
                  positive: isPositive(statistics?.bestTradingMonth),
                  data: TradelyNumberUtils.formatNullableValuta(
                    statistics?.bestTradingMonth,
                  ),
                ),
                SmallDataContainer(
                  loading: loading,
                  title: 'Worst trading month',
                  positive: isPositive(statistics?.worstTradingMonth),
                  data: TradelyNumberUtils.formatNullableValuta(
                    statistics?.worstTradingMonth,
                  ),
                ),
                SmallDataContainer(
                  loading: loading,
                  title: 'Average trading month',
                  positive: isPositive(statistics?.averageTradingMonth),
                  data: TradelyNumberUtils.formatNullableValuta(
                    statistics?.averageTradingMonth,
                  ),
                ),
                SmallDataContainer(
                  title: 'Coming soon',
                  blurred: true,
                ),
                SmallDataContainer(
                  title: 'Coming soon',
                  blurred: true,
                ),
                SmallDataContainer(
                  title: 'Coming soon',
                  blurred: true,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                DataList(
                  loading: loading,
                  values: {
                    "Total P&L": TradelyNumberUtils.formatNullableValuta(
                      statistics?.totalPL,
                    ),

                    // TODO : Average Daily Volume

                    "Average Winning Trade":
                        TradelyNumberUtils.formatNullableValuta(
                      statistics?.averageWinningTrade,
                    ),

                    "Average Losing Trade":
                        TradelyNumberUtils.formatNullableValuta(
                      // TODO : Average losing trade
                      0,
                    ),

                    "Total Number of Trades":
                        statistics?.totalNumberOfTrades?.toStringAsFixed(0) ??
                            "-",

                    "Number of Winning Trades":
                        // TODO: Number of winning trades
                        "-",
                    "Number of Losing Trades":
                        // TODO: Number of losing trades
                        "-",

                    "Number of Break Even Trades": statistics
                            ?.numberOfBreakEvenTrades
                            ?.toStringAsFixed(0) ??
                        "-",
                    "Max Consecutive Wins":
                        // TODO : Max consecutive wins
                        "-",
                    "Max Consecutive Losses":
                        statistics?.maxConsecutiveLosses?.toStringAsFixed(0) ??
                            "-",

                    // TODO : Commissions
                    // TODO : Swap

                    "Total Fees": TradelyNumberUtils.formatNullableValuta(
                      statistics?.totalFees,
                    ),
                    "Largest Profit": TradelyNumberUtils.formatNullableValuta(
                      statistics?.largestProfit,
                    ),
                    "Largest Loss": TradelyNumberUtils.formatNullableValuta(
                      statistics?.largestLoss,
                    ),
                    "Average Trade P&L":
                        // TODO: Average trade P&L
                        "-",
                    "Profit Factor":
                        // TODO : Profit factor
                        "-",
                  },
                ),
                DataList(
                  loading: loading,
                  values: {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
