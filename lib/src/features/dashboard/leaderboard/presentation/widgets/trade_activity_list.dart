// import 'package:flutter/material.dart';
// import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/trade_activity_list_item.dart';
// import '../../models/leaderboard_entry.dart';

// class TradeActivityList extends StatelessWidget {
//   final List<LeaderboardTradeActivity> entries;

//   const TradeActivityList({Key? key, required this.entries}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       // color: Colors.grey[900],
//       child: entries.isEmpty
//           ? Center(
//               child: const Text(
//                 "No Trade Activities",
//                 style: TextStyle(color: Colors.grey),
//               ),
//             )
//           : ListView.builder(
//               itemCount: entries.length,
//               itemBuilder: (context, index) {
//                 final entry = entries[index];
//                 final currencyImg = entry.currencyPair.split('/');
//                 if (currencyImg.length < 2) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text(
//                       "Invalid currency pair: ${entry.currencyPair}",
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   );
//                 }

//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 12.0),
//                   child: TradeActivityListItem(
//                     name: entry.name,
//                     currencyPair: entry.currencyPair,
//                     exchangeRate: entry.exchangeRate,
//                     moment: entry.moment,
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/trade_activity_list_item.dart';
import '../../models/leaderboard_entry.dart';

class TradeActivityList extends StatelessWidget {
  final List<LeaderboardTradeActivity> entries;

  const TradeActivityList({Key? key, required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: entries.isEmpty
          ? Center(
              child: const Text(
                "No Trade Activities",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Stack(
              children: [
                // Main scrollable list
                ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final currencyImg = entry.currencyPair.split('/');
                    if (currencyImg.length < 2) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Invalid currency pair: ${entry.currencyPair}",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TradeActivityListItem(
                        name: entry.name,
                        currencyPair: entry.currencyPair,
                        exchangeRate: entry.exchangeRate,
                        moment: entry.moment,
                      ),
                    );
                  },
                ),
                // Top shadow
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 80.0, // Height of the top shadow
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
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
                // Bottom shadow
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80.0, // Height of the bottom shadow
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
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
