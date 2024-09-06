import 'package:flutter/material.dart';

class SmallDataList extends StatelessWidget {
  const SmallDataList({super.key});

  // Example data
  final List<Map<String, String>> data = const [
    {"label": "Total Trades", "value": "-"},
    {"label": "Average Win", "value": "-"},
    {"label": "Best Win", "value": "-"},
    {"label": "Avg Win Streak", "value": "-"},
    {"label": "Max Win Streak", "value": "-"},
    {"label": "Best Loss", "value": "-"},
  ];

  // todo this widgets needs to be redone, child aspect ratio is not good for big screens.
  // better to be 2 columns with rows.
  // todo fix themes on text
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 60,
      crossAxisCount: 2,
      childAspectRatio: 6,
      // Adjust height for the rows
      children: data.map((item) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item['label']!, style: Theme.of(context).textTheme.bodySmall),
            Text(item['value']!, style: Theme.of(context).textTheme.bodySmall),
          ],
        );
      }).toList(),
    );
  }
}
