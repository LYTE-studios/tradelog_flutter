import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class SmallDataList extends StatelessWidget {
  final int? totalTrades;
  final int? long;
  final int? short;
  final double? averageWin;
  final double? averageLoss;
  final double? bestWin;
  final double? bestLoss;

  const SmallDataList({
    super.key,
    this.totalTrades,
    this.averageWin,
    this.averageLoss,
    this.long,
    this.short,
    this.bestWin,
    this.bestLoss,
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
                title: 'Long trades',
                value: long?.toString() ?? '-',
              ),
              buildRow(
                context,
                title: 'Avg Win',
                value: TradelyNumberUtils.formatNullableValuta(averageWin),
              ),
              buildRow(
                context,
                title: 'Avg Loss',
                value: TradelyNumberUtils.formatNullableValuta(averageLoss),
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
                title: 'Short trades',
                value: short?.toString() ?? '-',
              ),
              buildRow(
                context,
                title: 'Best Win',
                value: TradelyNumberUtils.formatNullableValuta(bestWin),
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
