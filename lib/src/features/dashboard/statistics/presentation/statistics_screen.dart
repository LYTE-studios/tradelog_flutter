import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/overview_statistics_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/enums/trade_enums.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
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
  OverviewStatisticsDto? statistics;

  DateTime? from;
  DateTime? to;

  @override
  Future<void> loadData() async {
    statistics = await UsersService().getAccountStatistics(
      from: from,
      to: to,
    );

    setState(() {
      statistics = statistics;
    });
    return super.loadData();
  }

  bool? isPositive(double? value) {
    if (value == null || value == 0) {
      return null;
    }

    return value > 0;
  }

  @override
  Widget build(BuildContext context) {
    double? bestProfit = statistics?.getBestMonthProfit();
    double? worstLoss = statistics?.getWorstMonthProfit();
    double? averageMonth = statistics?.getAverageMonthProfit();

    int tradesWon = ((statistics?.overallStatistics.winRate ?? 0) *
            (statistics?.overallStatistics.totalTrades ?? 0) /
            100)
        .toInt();

    int tradesLost =
        (statistics?.overallStatistics.totalTrades ?? 0) - tradesWon;

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
              text: "Filter",
              prefixIcon: TradelyIcons.diary,
              from: from,
              to: to,
              onUpdateDateFilter: (from, to) {
                this.from = from;
                this.to = to;
              },
              onResetFilters: () async {
                setState(() {
                  from = null;
                  to = null;
                  loading = true;
                });
                await loadData();
                setLoading(false);
              },
              onShowTrades: () async {
                setLoading(true);
                await loadData();
                setLoading(false);
              },
            ),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 114,
            child: Row(
              children: [
                SmallDataContainer(
                  loading: loading,
                  title: 'Best trading month',
                  positive: isPositive(bestProfit),
                  data: TradelyNumberUtils.formatNullableValuta(bestProfit),
                ),
                const SizedBox(
                  width: PaddingSizes.extraSmall,
                ),
                SmallDataContainer(
                  loading: loading,
                  title: 'Worst trading month',
                  positive: isPositive(worstLoss),
                  data: TradelyNumberUtils.formatNullableValuta(worstLoss),
                ),
                const SizedBox(
                  width: PaddingSizes.extraSmall,
                ),
                SmallDataContainer(
                  loading: loading,
                  title: 'Average trading month',
                  positive: isPositive(averageMonth),
                  data: TradelyNumberUtils.formatNullableValuta(averageMonth),
                ),
                const SizedBox(
                  width: PaddingSizes.extraSmall,
                ),
                SmallDataContainer(
                  title: 'Coming soon',
                  blurred: true,
                ),
                const SizedBox(
                  width: PaddingSizes.extraSmall,
                ),
                SmallDataContainer(
                  title: 'Coming soon',
                  blurred: true,
                ),
                const SizedBox(
                  width: PaddingSizes.extraSmall,
                ),
                SmallDataContainer(
                  title: 'Coming soon',
                  blurred: true,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: PaddingSizes.extraSmall,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.61,
            child: Row(
              children: [
                DataList(
                  loading: loading,
                  values: {
                    "Total P&L": TradelyNumberUtils.formatNullableValuta(
                      statistics?.overallStatistics.totalProfit,
                    ),

                    // TODO : Average Daily Volume

                    "Average Winning Trade":
                        TradelyNumberUtils.formatNullableValuta(
                      statistics?.overallStatistics.averageWin,
                    ),

                    "Average Losing Trade":
                        TradelyNumberUtils.formatNullableValuta(
                      statistics?.overallStatistics.averageLoss,
                    ),

                    "Total Number of Trades":
                        statistics?.overallStatistics.totalTrades.toString() ??
                            '',

                    "Number of Winning Trades": tradesWon.toString(),
                    "Number of Losing Trades": tradesLost.toString(),
                  },
                ),
                const SizedBox(
                  width: PaddingSizes.extraSmall,
                ),
                DataList(
                  loading: loading,
                  values: {
                    "Largest Profit": TradelyNumberUtils.formatNullableValuta(
                      statistics?.overallStatistics.bestWin,
                    ),
                    "Largest Loss": TradelyNumberUtils.formatNullableValuta(
                      statistics?.overallStatistics.worstLoss,
                    ),
                    "Average Win P&L": TradelyNumberUtils.formatNullableValuta(
                      statistics?.overallStatistics.averageWin,
                    ),
                    "Average Loss P&L": TradelyNumberUtils.formatNullableValuta(
                      statistics?.overallStatistics.averageLoss,
                    ),
                    "Profit Factor":
                        statistics?.overallStatistics.profitFactor == null ||
                                statistics?.overallStatistics.profitFactor == 0
                            ? ''
                            : statistics?.overallStatistics.profitFactor
                                    .toStringAsFixed(1) ??
                                '',
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
