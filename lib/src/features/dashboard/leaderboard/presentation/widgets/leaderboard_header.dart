import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/models/leaderboard_entry.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/leaderboard_service.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/currency_pair_display.dart';

class LeaderboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currencyData = LeaderboardCurrencyItems.fetchLeaderboardCurrency();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 100, // Adjust as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Stack(
        children: [
          // Main content (scrollable row)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: currencyData.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CurrencyPairDisplay(
                    currencyPair: item.currencyPair,
                    exchangeRate: item.exchangeRate,
                  ),
                );
              }).toList(),
            ),
          ),
          // Left-side shadow
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 240.0, // Width of the shadow area
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(1), // Darker on the right
                    Colors.transparent, // Fades out
                  ],
                ),
              ),
            ),
          ),
          // Right-side shadow
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 240.0, // Width of the shadow area
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(1), // Darker on the right
                    Colors.transparent, // Fades out
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
