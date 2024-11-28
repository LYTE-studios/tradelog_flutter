import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/models/leaderboard_entry.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class LeaderboardItem extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool isHighlighted;

  const LeaderboardItem({
    required this.entry,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return
        // Expanded(
        Center(
            child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Padding(
              child: CircleAvatar(
                radius: 36.0,
                backgroundImage: NetworkImage(// Replace with your image URL
                    entry.avatarUrl),
              ),
              padding: EdgeInsets.all(12.0),
            ),
            Positioned(
                top: 67,
                left: 29,
                // child: SizedBox(
                //     width: 55,
                //     height: 20,
                child: Container(
                    width: 42,
                    height: 24,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color.fromARGB(255, 6, 85, 255)),
                    // color: Colors.blue[800],
                    child: Center(
                        child: Text(
                      '#${entry.rank}',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )))),
          ],
        ),
        Transform(
            transform: Matrix4.translationValues(12.0, 0.0, 0.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "${entry.name}",
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
              Container(
                child: Row(
                  children: [
                    (entry.points > 0)
                        ? SvgIcon(
                            TradelyIcons.arrowDown,
                            color: colorScheme.tertiary,
                          )
                        : SvgIcon(
                            TradelyIcons.arrowDown,
                            color: colorScheme.error,
                          ),
                    Text("${entry.points.abs()}",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: (entry.points > 0)
                                ? colorScheme.tertiary
                                : colorScheme.error))
                  ],
                ),
              )
            ]))
      ],
    ));
  }
}
