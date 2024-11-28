import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/equity_line_chart.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ChartContainer extends StatefulWidget {
  final double? balance;

  final Map<DateTime, double> data;
  final String titleText;
  final String toolTipText;

  const ChartContainer({
    super.key,
    required this.balance,
    required this.data,
    required this.titleText,
    required this.toolTipText,
  });

  @override
  State<ChartContainer> createState() => _ChartContainerState();
}

class _ChartContainerState extends State<ChartContainer> {
  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToolTipTitle(
            titleText: widget.titleText,
            toolTipText: widget.toolTipText,
          ),
          const SizedBox(
            height: PaddingSizes.large,
          ),
          RichText(
            text: TextSpan(
              text: widget.balance == null
                  ? "-"
                  : "\$${TradelyNumberUtils.formatValuta(widget.balance ?? 0).split(".").firstOrNull ?? 0}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
              children: [
                TextSpan(
                  text: widget.balance == null
                      ? ""
                      : " .${widget.balance!.toStringAsFixed(2).split(".")[1]}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: PaddingSizes.large,
          ),
          Expanded(
            child: EquityLineChart(
              data: widget.data
                  .map((date, value) => MapEntry(date, ChartData(date, value)))
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
