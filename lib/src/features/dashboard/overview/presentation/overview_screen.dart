import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/overview_statistics_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/user_profile_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/paywall_dialog.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/chart_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/data_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/filter_trades_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/most_traded_pair.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/net_daily_chart.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/my_trades_chart.dart';

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
        icon: TradelyIcons.dashboard,
        currentRoute: OverviewScreen.location,
        title:
            "${getDisplayText()} ${(profile?.firstName.isNotEmpty ?? false) ? profile!.firstName : ''}!",
        titleIconPath: 'assets/images/emojis/hand_emoji.png',
        trailing: FilterTradesButton(
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
          height: 32,
          text: "Filter",
          prefixIcon: TradelyIcons.diary,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Modified top section: summary boxes and split charts row
          SizedBox(
            height: 550,
            child: Column(
              children: [
                // First row: 4 summary boxes
                SizedBox(
                  height: 140,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DataContainer(
                          title: 'Net Profit/Loss',
                          toolTip:
                              'The total realized net profit and loss for all closed trades',
                          value: statistics?.overallStatistics.totalProfit,
                          loading: loading,
                          iconNumber: 1,
                          isPositive: true,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: DataContainer(
                          title: 'Trade win rate',
                          toolTip:
                              'Reflects the percentage of your winning trades out of total trades taken',
                          value: statistics?.overallStatistics.winRate,
                          loading: loading,
                          iconNumber: 2,
                          isPositive: true,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: DataContainer(
                          title: 'Avg realized R:R',
                          toolTip:
                              'Average Win / Average Loss = Average Realize R:R',
                          value: 1.5, // Example value
                          loading: loading,
                          iconNumber: 3,
                          isPositive: false,
                        ),
                      ),
                      // Added new Unrealized P/L box with dummy value
                      Expanded(
                        flex: 1,
                        child: DataContainer(
                          title: 'Unrealized P/L',
                          toolTip:
                              'Current unrealized profit/loss from open positions',
                          value: 2435.50, // Added dummy value
                          loading: loading,
                          iconNumber: 4,
                          isPositive: false,
                        ),
                      ),
                    ],
                  ),
                ),
                // Second row: Updated layout with equity chart and trades list
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.70 - 10,
                            child: ChartContainer(
                              title: 'Equity value chart',
                              toolTip:
                                  "Your equity line shows your account's value over time, highlighting profits and losses",
                              loading: loading,
                              from: from,
                              to: to,
                              titleImage: 'assets/icons/piggy.png',
                              onViewAllTrades: () {
                                print('View all trades clicked');
                              },
                              onRefresh: () async {
                                setLoading(true);
                                await loadData();
                                setLoading(false);
                              },
                              child: Container(), // Add the required child parameter
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: constraints.maxWidth * 0.30 - 10,
                            child:
                                TradesList(), // Removed BaseDataContainer wrapper
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          // Bottom section with Most Traded Pairs and Net Daily P&L
          SizedBox(
            height: 360,
            child: Row(
              children: [
                const Expanded(
                  child: BaseDataContainer(
                    isSuffixIcon: true,
                    isPrefixIcon: false,
                    title: 'Most Traded Pairs',
                    toolTip: 'Shows your most frequently traded currency pairs',
                    child: MostTradedPairsScreen(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: BaseDataContainer(
                    title: 'Net Daily P&L',
                    toolTip: 'Shows your daily profit and loss',
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Net Daily P&L",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 16),
                          const Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: NetDailyChart(),
                            ),
                          ),
                        ],
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
