import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildRow(
                context,
                title: 'Total trades',
                value: '-',
              ),
              buildRow(
                context,
                title: 'Average Win',
                value: '-',
              ),
              buildRow(
                context,
                title: 'Best Win',
                value: '-',
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildRow(
                context,
                title: 'Avg Win Streak',
                value: '-',
              ),
              buildRow(
                context,
                title: 'Max Win Streak',
                value: '-',
              ),
              buildRow(
                context,
                title: 'Best Loss',
                value: '-',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRow(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        right: PaddingSizes.large,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              softWrap: false,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(
            width: PaddingSizes.small,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
            softWrap: false,
          ),
        ],
      ),
    );
  }
}
