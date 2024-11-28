// widgets/leaderboard_list.dart
import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/presentation/widgets/leaderboard_item.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import '../../models/leaderboard_entry.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class LeaderboardList extends StatelessWidget {
  final List<LeaderboardEntry> entries;

  final Function(LeaderboardEntry) onEntrySelected;
  final selectedEntry;

  const LeaderboardList({
    required this.entries,
    required this.onEntrySelected,
    required this.selectedEntry,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 34.0, vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    child: LeaderboardItem(entry: selectedEntry ?? entries[0]),
                  ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 10,
                        ),
                        itemBuilder: (context, index) {
                          final entry = entries[index];
                          final isSelected = entry == selectedEntry;
                          final textColor;
                          switch (index) {
                            case 0:
                              textColor =
                                  const Color.fromARGB(255, 255, 200, 6);
                              break;
                            case 1:
                              textColor = Colors.white;
                              break;
                            case 2:
                              textColor = Color.fromARGB(255, 139, 95, 63);
                              break;
                            default:
                              textColor = Colors.white;
                          }
                          while (index < 7) {
                            return GestureDetector(
                              onTap: () => onEntrySelected(entry),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: (isSelected)
                                      ? const Color.fromARGB(255, 45, 98, 254)
                                      : Colors.transparent,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          // Example avatar
                                          // backgroundColor: Colors.grey.shade300,
                                          backgroundImage:
                                              NetworkImage(entry.avatarUrl),
                                          radius: 16.0,
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          "\$${entry.name}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Container(
                                          child: Row(
                                            children: [
                                              (entry.points > 0)
                                                  ? SvgIcon(
                                                      TradelyIcons.arrowDown,
                                                      color:
                                                          colorScheme.tertiary,
                                                    )
                                                  : SvgIcon(
                                                      TradelyIcons.arrowDown,
                                                      color: colorScheme.error,
                                                    ),
                                              Text(
                                                '${entry.points.abs()}',
                                                style: TextStyle(
                                                  color: (entry.points > 0)
                                                      ? colorScheme.tertiary
                                                      : colorScheme.error,
                                                  fontSize: 12.0,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Container(
                                        width: 240,
                                        height: 20.0,
                                        alignment: Alignment.centerRight,
                                        decoration: BoxDecoration(
                                          border: !isSelected
                                              ? Border(
                                                  bottom: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.white24))
                                              : Border(
                                                  bottom: BorderSide(
                                                      width: 1.0,
                                                      color:
                                                          Colors.transparent)),
                                        ),
                                        child: Text(
                                          '#${entry.rank}',
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  SizedBox(height: 46),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 10,
                        ),
                        itemCount: entries.length > 10 ? 10 : entries.length,
                        itemBuilder: (context, index) {
                          final entry = entries[index + 7];
                          final isSelected = entry == selectedEntry;
                          if (index < 10) {
                            return GestureDetector(
                              onTap: () => onEntrySelected(entry),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: (isSelected)
                                      ? const Color.fromARGB(255, 45, 98, 254)
                                      : Colors.transparent,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          // Example avatar
                                          // backgroundColor: Colors.grey.shade300,
                                          backgroundImage:
                                              NetworkImage(entry.avatarUrl),
                                          radius: 16.0,
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          "\$${entry.name}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Container(
                                          child: Row(
                                            children: [
                                              (entry.points > 0)
                                                  ? SvgIcon(
                                                      TradelyIcons.arrowDown,
                                                      color:
                                                          colorScheme.tertiary,
                                                    )
                                                  : SvgIcon(
                                                      TradelyIcons.arrowDown,
                                                      color: colorScheme.error,
                                                    ),
                                              Text(
                                                '${entry.points.abs()}',
                                                style: TextStyle(
                                                  color: (entry.points > 0)
                                                      ? colorScheme.tertiary
                                                      : colorScheme.error,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: !isSelected
                                              ? Border(
                                                  bottom: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.white24))
                                              : Border(
                                                  bottom: BorderSide(
                                                      width: 1.0,
                                                      color:
                                                          Colors.transparent)),
                                        ),
                                        width: 240,
                                        height: 20.0,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '#${entry.rank}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        }),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
