import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';

class ProfitContainer extends StatelessWidget {
  final int percentage;

  const ProfitContainer({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profit Factor",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "$percentage%",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
          // FittedBox is needed for Syncfusion widget.
          FittedBox(
            child: SfCircularChart(
              margin: EdgeInsets.zero,
              series: <CircularSeries>[
                RadialBarSeries<String, String>(
                  trackColor: Theme.of(context).colorScheme.tertiary,
                  enableTooltip: true,
                  maximumValue: 100,
                  cornerStyle: CornerStyle.bothCurve,
                  radius: "100%",
                  dataSource: [""],
                  innerRadius: '80%',
                  xValueMapper: (_, __) => 'Profit',
                  yValueMapper: (_, __) => 100 - percentage,
                  pointColorMapper: (_, __) =>
                      Theme.of(context).colorScheme.error,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
