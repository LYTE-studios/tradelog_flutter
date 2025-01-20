import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class WebStatisticChart extends StatelessWidget {
  final Map<String, double> data;

  final Color? color;

  const WebStatisticChart({
    super.key,
    required this.data,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        PaddingSizes.xxl,
      ),
      child: RadarChart(
        RadarChartData(
          radarBackgroundColor: Colors.transparent,
          gridBorderData: const BorderSide(color: Colors.grey, width: 1),
          radarBorderData: const BorderSide(color: Colors.grey, width: 1),
          tickBorderData:
              BorderSide(color: Colors.grey.withOpacity(1), width: 1),
          ticksTextStyle: const TextStyle(color: Colors.transparent),
          titleTextStyle: TextStyle(
            color: TextStyles.bodyColor,
            fontSize: 10,
          ),
          borderData: FlBorderData(show: false),
          radarShape: RadarShape.polygon,
          tickCount: 4,
          getTitle: (index, angle) {
            return RadarChartTitle(
              text: data.keys.toList()[index],
              angle: 0,
              positionPercentageOffset: .28,
            );
          },
          dataSets: [
            RadarDataSet(
              dataEntries:
                  data.values.map((e) => RadarEntry(value: e)).toList(),
              borderColor: color ?? Theme.of(context).colorScheme.primary,
              fillColor: color?.withOpacity(0.3) ??
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
              entryRadius: 4,
              borderWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
