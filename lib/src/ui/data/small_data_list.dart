import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class SmallDataList extends StatelessWidget {
  final int? totalTrades;
  final double? averageWin;
  final double? bestWin;
  final double? bestLoss;
  final int? averageWinStreak;
  final int? maxWinStreak;

  const SmallDataList({
    super.key,
    this.totalTrades,
    this.averageWin,
    this.bestWin,
    this.bestLoss,
    this.averageWinStreak,
    this.maxWinStreak,
  });

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
                value: totalTrades?.toString() ?? '-',
              ),
              buildRow(
                context,
                title: 'Average Win',
                value: TradelyNumberUtils.formatNullableValuta(averageWin),
              ),
              buildRow(
                context,
                title: 'Best Win',
                value: TradelyNumberUtils.formatNullableValuta(bestWin),
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
                value: averageWinStreak?.toString() ?? '-',
              ),
              buildRow(
                context,
                title: 'Max Win Streak',
                value: maxWinStreak?.toString() ?? '-',
              ),
              buildRow(
                context,
                title: 'Worst Loss',
                value: TradelyNumberUtils.formatNullableValuta(bestLoss),
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
