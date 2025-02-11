import 'package:flutter/material.dart';
import 'package:to_csv/to_csv.dart';
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
  double? bestProfit;
  double? worstLoss;
  double? averageMonth;

  int tradesWon = 0;

  int tradesLost = 0;

  OverviewStatisticsDto? statistics;

  DateTime? from;
  DateTime? to;

  Map<String, String> statMap1 = {};

  Map<String, String> statMap2 = {};

  Future<void> downloadCsv() async {
    List<List<String>> toData(Map<String, String> map) {
      List<List<String>> values = [];

      for (String key in map.keys.toList()) {
        values.add([key, map[key] ?? '']);
      }

      return values;
    }

    await myCSV(
      [
        "Stat",
        "Value",
      ],
      [
        ...toData(statMap1),
        ...toData(statMap2),
      ],
      fileName:
          "tradely_statistics_export_${DateTime.now().millisecondsSinceEpoch}",
      setHeadersInFirstRow: true,
    );
  }

  @override
  Future<void> loadData() async {
    statistics = await UsersService().getAccountStatistics(
      from: from,
      to: to,
    );

    setState(() {
      bestProfit = statistics?.getBestMonthProfit();
      worstLoss = statistics?.getWorstMonthProfit();
      averageMonth = statistics?.getAverageMonthProfit();

      tradesWon = ((statistics?.overallStatistics.winRate ?? 0) *
              (statistics?.overallStatistics.totalTrades ?? 0) /
              100)
          .toInt();

      tradesLost = (statistics?.overallStatistics.totalTrades ?? 0) - tradesWon;

      statistics = statistics;
      statMap1 = {
        "Total P&L": TradelyNumberUtils.formatNullableValuta(
          statistics?.overallStatistics.totalProfit,
        ),
        "Average Winning Trade": TradelyNumberUtils.formatNullableValuta(
          statistics?.overallStatistics.averageWin,
        ),
        "Average Losing Trade": TradelyNumberUtils.formatNullableValuta(
          statistics?.overallStatistics.averageLoss,
        ),
        "Total Number of Trades":
            statistics?.overallStatistics.totalTrades.toString() ?? '',
        "Trades Won": tradesWon.toString(),
        "Trades Lost": tradesLost.toString(),
        "Breakeven Trades":
            statistics?.overallStatistics.breakEvenTrades.toString() ?? '-',
        "Winning Days":
            statistics?.overallStatistics.winningDays.toString() ?? '-',
        "Losing Days":
            statistics?.overallStatistics.losingDays.toString() ?? '-',
        "Breakeven Days":
            statistics?.overallStatistics.breakEvenDays.toString() ?? '-',
      };
      statMap2 = {
        "Max Drawdown": TradelyNumberUtils.formatNullableValuta(
          statistics?.overallStatistics.maxDrawdown,
        ),
        "Max Drawdown %":
            '% ${statistics?.overallStatistics.maxDrawdownPercent.toStringAsFixed(2) ?? '-'}',
        "Average Drawdown": TradelyNumberUtils.formatNullableValuta(
          statistics?.overallStatistics.averageDrawdown,
        ),
        "Average Drawdown %":
            '% ${statistics?.overallStatistics.averageDrawdownPercent.toStringAsFixed(2) ?? '-'}',
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
        "Profit Factor": statistics?.overallStatistics.profitFactor == null ||
                statistics?.overallStatistics.profitFactor == 0
            ? ''
            : statistics?.overallStatistics.profitFactor.toStringAsFixed(1) ??
                '',
      };
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
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Track in-depth statistics, and export them as a csv.",
        icon: TradelyIcons.statistics,
        currentRoute: StatisticsScreen.location,
        title: "Statistics",
        titleIconPath: 'assets/images/emojis/statistics_emoji.png',
        // buttons: Row(
        //   children: [
        //     PrimaryButton(
        //       onTap: downloadCsv,
        //       height: 42,
        //       text: "Export list",
        //       color: Theme.of(context).colorScheme.primaryContainer,
        //     ),
        //     const SizedBox(
        //       width: PaddingSizes.large,
        //     ),
        //     FilterTradesButton(
        //       onTap: () {},
        //       height: 42,
        //       text: "Filter",
        //       prefixIcon: TradelyIcons.diary,
        //       from: from,
        //       to: to,
        //       onUpdateDateFilter: (from, to) {
        //         this.from = from;
        //         this.to = to;
        //       },
        //       onResetFilters: () async {
        //         setState(() {
        //           from = null;
        //           to = null;
        //           loading = true;
        //         });
        //         await loadData();
        //         setLoading(false);
        //       },
        //       onShowTrades: () async {
        //         setLoading(true);
        //         await loadData();
        //         setLoading(false);
        //       },
        //     ),
        //   ],
        // ),
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
                  loading: loading,
                  title: 'Largest Profit',
                  positive: isPositive(statistics?.overallStatistics.bestWin),
                  data: TradelyNumberUtils.formatNullableValuta(
                    statistics?.overallStatistics.bestWin,
                  ),
                ),
                const SizedBox(
                  width: PaddingSizes.extraSmall,
                ),
                SmallDataContainer(
                  loading: loading,
                  title: 'Largest Loss',
                  positive: isPositive(statistics?.overallStatistics.worstLoss),
                  data: TradelyNumberUtils.formatNullableValuta(
                    statistics?.overallStatistics.worstLoss,
                  ),
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
                  values: statMap1,
                ),
                const SizedBox(
                  width: PaddingSizes.extraSmall,
                ),
                DataList(
                  loading: loading,
                  values: statMap2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
