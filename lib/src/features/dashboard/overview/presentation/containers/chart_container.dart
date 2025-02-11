import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/equity_line_chart.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ChartContainer extends StatefulWidget {
  final String title;
  final String toolTip;

  final bool loading;

  final DateTime? from;
  final DateTime? to;
  final String? titleImage; // Add this line
  final VoidCallback? onViewAllTrades; // Add this
  final VoidCallback? onRefresh; // Add this

  const ChartContainer({
    super.key,
    required this.title,
    required this.toolTip,
    this.loading = false,
    this.from,
    this.to,
    this.titleImage, // Add this line
    this.onViewAllTrades,
    this.onRefresh,
  });

  @override
  State<ChartContainer> createState() => _ChartContainerState();
}

class _ChartContainerState extends State<ChartContainer> {
  double? balance;
  double? previousBalance;

  double? get percentageChange {
    if (balance == null || previousBalance == null) return null;
    return ((balance! - previousBalance!) / previousBalance!) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return BaseDataContainer(
      title: widget.title,
      toolTip: widget.toolTip,
      titleImage: widget.titleImage, // Add this line
      onViewAllTrades: widget.onViewAllTrades, // Add this
      onRefresh: widget.onRefresh, // Add this
      buttonText: 'All Trades', // Specify button text for Chart Container
      // Add custom button content with arrow
      customButtonContent: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'All Trades',
            style: TextStyle(
              color: Color(0xFF666D80),
              fontSize: 13, // Slightly smaller font
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.expand_more,
            size: 14, // Smaller icon
            color: const Color(0xFF666D80),
          ),
        ],
      ),
      // Updated refresh button
      additionalHeaderWidget: Container(
        margin: const EdgeInsets.only(left: 8),
        child: Container(
          height: 32, // Match height with "All Trades" button
          width: 32, // Make it square
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF272835)),
          ),
          child: IconButton(
            onPressed: widget.onRefresh,
            icon: Image.asset(
              'assets/icons/refresh.png',
              width: 14, // Smaller icon
              height: 14, // Smaller icon
            ),
            padding: EdgeInsets.zero, // Remove padding
            constraints: const BoxConstraints(), // Remove constraints
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: PaddingSizes.large),
          Container(
            // Add this divider
            height: 1,
            color: const Color(0xFF232135),
          ),
          const SizedBox(height: PaddingSizes.large),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: balance == null
                      ? "-"
                      : "\$${TradelyNumberUtils.formatValuta(balance ?? 0).split(".").firstOrNull ?? 0}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                  children: [
                    TextSpan(
                      text: balance == null
                          ? ""
                          : ".${balance!.toStringAsFixed(2).split(".")[1]}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
              if (percentageChange != null) ...[
                const SizedBox(width: 12),
                Icon(
                  percentageChange! >= 0
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  color: percentageChange! >= 0
                      ? const Color(0xFF40C4AA)
                      : Colors.red,
                  size: 20,
                ),
                Text(
                  "${percentageChange!.abs().toStringAsFixed(1)}%",
                  style: TextStyle(
                    color: percentageChange! >= 0
                        ? const Color(0xFF40C4AA)
                        : Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "from last period",
                  style: TextStyle(
                    color: Color(0xFF666D80),
                    fontSize: 16,
                    fontWeight: FontWeight.normal, // Added normal weight
                  ),
                ),
              ],
              const Spacer(),
              // Period indicators moved here
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'This period',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF666D80),
                              fontSize: 13,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: const Color(0xFF33CFFF),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Previous period',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF666D80),
                              fontSize: 13,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: PaddingSizes.large),
          Expanded(
            child: EquityLineChart(
              onUpdateBalance: (newBalance, prevBalance) {
                setState(() {
                  balance = newBalance;
                  previousBalance = prevBalance;
                });
              },
              from: widget.from,
              to: widget.to,
            ),
          ),
        ],
      ),
    );
  }
}
