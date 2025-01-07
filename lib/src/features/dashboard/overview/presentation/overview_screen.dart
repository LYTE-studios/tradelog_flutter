import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/overview_statistics_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/user_profile_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/paywall_dialog.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/chart_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/holding_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/long_short_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/profit_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/progress_data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/web_statistic_chart.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/filter_trades_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  static const String route = '/$location';
  static const String location = 'overview';

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> with ScreenStateMixin {
  OverviewStatisticsDto? statistics;

  UserProfileDto? profile;

  DateTime? from;
  DateTime? to;

  Future<void> loadProfile() async {
    profile = await UsersService().getUserProfile();

    setState(() {
      profile = profile;
    });
  }

  @override
  void initState() {
    Future(() {
      loadProfile();
    });

    super.initState();
  }

  @override
  Future<void> loadData() async {
    statistics = await UsersService().getAccountStatistics(from: from, to: to);

    setState(() {
      statistics = statistics;
    });
    return super.loadData();
  }

  String getDisplayText() {
    DateTime now = DateTime.now();
    if (now.hour < 4) {
      return "Good night";
    } else if (now.hour < 12) {
      return "Good morning";
    } else if (now.hour < 18) {
      return "Good afternoon";
    } else {
      return "Good evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Discover all your performance metrics & progress.",
        icon: TradelyIcons.overview,
        currentRoute: OverviewScreen.location,
        title:
            "${getDisplayText()} ${(profile?.firstName.isNotEmpty ?? false) ? profile!.firstName : ''}!",
        titleIconPath: 'assets/images/emojis/hand_emoji.png',
        buttons: FilterTradesButton(
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
          onTap: () {},
          height: 42,
          text: "Filter",
          prefixIcon: TradelyIcons.diary,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 600,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: Row(
                          children: [
                            DataContainer(
                              title: 'Net Profit/Loss',
                              toolTip:
                                  'The total realized net profit and loss for all closed trades.',
                              value: statistics?.overallStatistics.totalProfit,
                              loading: loading,
                            ),
                            DataContainer(
                              isPercentage: true,
                              title: 'Trade win rate',
                              toolTip:
                                  'Reflects the percentage of your winning trades out of total trades taken.',
                              value: statistics?.overallStatistics.winRate,
                              loading: loading,
                            ),
                            ProgressDataContainer(
                              title: ' Avg realized R:R',
                              profit: statistics?.overallStatistics.averageWin,
                              loss: statistics?.overallStatistics.averageLoss,
                              toolTip:
                                  'Average Win / Average Loss = Average Realize R:R',
                              value: statistics?.overallStatistics.averageWin ==
                                          null ||
                                      statistics
                                              ?.overallStatistics.averageLoss ==
                                          null
                                  ? null
                                  : (statistics?.overallStatistics.averageWin ??
                                          0) /
                                      (statistics?.overallStatistics
                                                  .averageLoss ??
                                              1)
                                          .abs(),
                              loading: loading,
                            )
                          ],
                        ),
                      ),
                      ChartContainer(
                        title: 'Equity line',
                        toolTip:
                            "Your equity line shows your account’s value over time, highlighting profits and losses.",
                        balance: statistics?.overallStatistics.balance,
                        loading: loading,
                        from: from,
                        to: to,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      LongShortContainer(
                        long: statistics?.overallStatistics.long ?? 0,
                        short: statistics?.overallStatistics.short ?? 0,
                        averageWin: statistics?.overallStatistics.averageWin,
                        averageLoss: statistics?.overallStatistics.averageLoss,
                        bestWin: statistics?.overallStatistics.bestWin,
                        bestLoss: statistics?.overallStatistics.worstLoss,
                        loading: loading,
                      ),
                      ProfitContainer(
                        profit: statistics?.overallStatistics.totalWon,
                        loss: statistics?.overallStatistics.totalLost,
                        factor: statistics?.overallStatistics.profitFactor,
                      ),
                      HoldingContainer(
                        holdingTime:
                            statistics?.overallStatistics.holdingTimeMinutes,
                        loading: loading,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 360,
            child: Row(
              children: [
                BaseDataContainer(
                  title: 'Weekday',
                  toolTip:
                      'Displays the weekday with the highest trading activity',
                  child: WebStatisticChart(
                    data: statistics?.weekDistribution.toJson() ??
                        {
                          'Monday': 0,
                          'Tuesday': 0,
                          'Wednesday': 0,
                          'Thursday': 0,
                          'Friday': 0,
                          'Saturday': 0,
                        },
                  ),
                ),
                BaseDataContainer(
                  title: 'Sessions',
                  toolTip:
                      'Displays the session with the highest trading activity',
                  child: WebStatisticChart(
                    color: HexColor.fromHex('#FFCC00'),
                    data: statistics?.sessionDistribution.toJson() ??
                        {
                          'London': 0,
                          'New York': 0,
                          'Asia': 0,
                          'Pacific': 0,
                        },
                  ),
                ),
                BaseDataContainer(
                  title: 'Pairs',
                  toolTip: 'Highlights the asset you traded most frequently.',
                  child: WebStatisticChart(
                    data: statistics?.toSymbolChartMap() ??
                        OverviewStatisticsDto.getDefaultSymbolChartMap(),
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
