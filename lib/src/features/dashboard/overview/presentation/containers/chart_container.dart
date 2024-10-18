import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/equity_line_chart.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ChartContainer extends StatelessWidget {
  // Example data
  final String? data;

  const ChartContainer({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ToolTipTitle(
            titleText: 'Equity line',
            toolTipText: 'This is the equity chart',
          ),
          const SizedBox(
            height: PaddingSizes.large,
          ),
          RichText(
            text: TextSpan(
              text: data != null ? "\$103,456" : "-",
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: data != null ? ".24" : "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: PaddingSizes.large,
          ),
          Expanded(
            child: EquityLineChart(),
          ),
        ],
      ),
    );
  }
}
