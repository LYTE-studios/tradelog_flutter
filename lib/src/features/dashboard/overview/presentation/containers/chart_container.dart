import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ChartContainer extends StatelessWidget {
  final double? balance;

  final Map<DateTime, double> data;
  final String title;
  final String toolTip;

  final bool loading;

  const ChartContainer({
    super.key,
    required this.balance,
    required this.data,
    required this.title,
    required this.toolTip,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDataContainer(
      title: title,
      toolTip: toolTip,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: PaddingSizes.large,
          ),
          RichText(
            text: TextSpan(
              text: balance == null
                  ? "-"
                  : "\$${TradelyNumberUtils.formatValuta(balance ?? 0).split(".").firstOrNull ?? 0}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
              children: [
                TextSpan(
                  text: balance == null
                      ? ""
                      : " .${balance!.toStringAsFixed(2).split(".")[1]}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: PaddingSizes.large,
          ),
          // Expanded(
          //   child: EquityLineChart(
          //     data: data
          //         .map((date, value) => MapEntry(date, ChartData(date, value)))
          //         .values
          //         .toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
