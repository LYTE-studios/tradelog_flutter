// import 'package:tradelog_flutter/src/features/dashboard/'
import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/leaderboard_service.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/leaderboard_list.dart';
import 'package:tradelog_flutter/src/ui/base/custom_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/list/header_row_item.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/models/leaderboard_entry.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/leaderboard_header.dart';

import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/leaderboard_list.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/trade_activity_list.dart';

import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/leaderboard_service.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/leaderboard_list.dart';
import 'package:tradelog_flutter/src/ui/base/custom_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/models/leaderboard_entry.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/leaderboard_header.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/trade_activity_list.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  static const String route = '/$location';
  static const String location = 'leaderboard';

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreen();
}

class _LeaderboardScreen extends State<LeaderboardScreen>
    with ScreenStateMixin {
  LeaderboardEntry? selectedEntry;
  @override
  Widget build(BuildContext context) {
    final leaderboardData = LeaderboardService.fetchLeaderboard();
    final tradeActivityData = TradeActivityItems.fetchTradeActivityItems();

    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle:
            "Discover top traded pairs, latest trades & trade your rank up",
        icon: TradelyIcons.myTrades,
        currentRoute: LeaderboardScreen.location,
        title: "Leaderboard",
        titleIconPath: 'assets/images/emojis/chart_emoji.png',
        // buttons: Row(
        //   children: [
        //     PrimaryButton(
        //       onTap: () {},
        //       height: 42,
        //       text: "Export list",
        //       color: Theme.of(context).colorScheme.primaryContainer,
        //     ),
        //   ],
        // ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Container(
                  height: 90,
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: LeaderboardHeader(),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.white10),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: LeaderboardList(
                      entries: leaderboardData,
                      onEntrySelected: (entry) {
                        setState(() {
                          selectedEntry = entry; // Update the selected entry
                        });
                      },
                      selectedEntry: selectedEntry,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  // decoration: BoxDecoration(
                  //   border: Border.all(width: 1.0, color: Colors.white54),
                  //   borderRadius:
                  //       const BorderRadius.all(Radius.circular(12.0)),
                  // ),
                  child: TradeActivityList(entries: tradeActivityData),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
