import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class EquityLineChart extends StatefulWidget {
  final List<ChartData> data;

  const EquityLineChart({
    super.key,
    required this.data,
  });

  @override
  State<EquityLineChart> createState() => _EquityLineChartState();
}

class _EquityLineChartState extends State<EquityLineChart> {
  num? _highlightedPointIndex;

  void setHighlightedPointIndex(num? index) {
    setState(() {
      _highlightedPointIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = widget.data.isEmpty
        ? List.generate(20, (index) {
            int year = 2010 + (index * 5);
            double value = 70 +
                Random().nextDouble() * 30; // Random values between 20 and 100
            return ChartData(year, value);
          })
        : widget.data;

    double minimum = chartData.map((e) => e.y).reduce(min);
    double maximum = chartData.map((e) => e.y).reduce(max);

    return SfCartesianChart(
      onTooltipRender: (TooltipArgs args) =>
          setHighlightedPointIndex(args.pointIndex),
      onMarkerRender: (MarkerRenderArgs args) {
        if (_highlightedPointIndex == null) {
          return;
        }
        if (args.pointIndex == _highlightedPointIndex) {
          args.color = Theme.of(context).colorScheme.primary;
          args.borderColor = Theme.of(context).colorScheme.primary;
          args.borderWidth = 10;
        }
      },
      plotAreaBorderWidth: 0,
      // Removes the border around the chart plot area
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        interval: 10,
        decimalPlaces: 0,
        minimum:
            ((minimum - ((maximum - minimum) * 2)) / 10).roundToDouble() * 10,
        maximum: maximum + ((maximum - minimum) * 2),
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
      ),
      tooltipBehavior: TooltipBehavior(
        color: Theme.of(context).colorScheme.primary,
        textStyle: TextStyles.bodyMedium.copyWith(
          fontSize: 14,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        enable: true,
        shouldAlwaysShow: true,
        canShowMarker: false,
        header: '',
        format: '\$point.y',
        duration: 0,
      ),
      series: [
        AreaSeries(
          // this does not work as intended, waiting for further ui changes until I know how the data looks like
          markerSettings: const MarkerSettings(
            height: 14,
            width: 14,
            isVisible: false,
          ),
          borderDrawMode: BorderDrawMode.top,
          borderWidth: 3,
          borderColor: Theme.of(context).colorScheme.primary,
          gradient: LinearGradient(
            colors: [
              HexColor.fromHex('232135'),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final double y;
}
