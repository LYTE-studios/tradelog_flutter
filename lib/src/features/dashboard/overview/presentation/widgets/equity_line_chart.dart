import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EquityLineChart extends StatefulWidget {
  const EquityLineChart({super.key});

  @override
  State<EquityLineChart> createState() => _EquityLineChartState();
}

class _EquityLineChartState extends State<EquityLineChart> {
  late TooltipBehavior _tooltipBehavior;
  num? _highlightedPointIndex;

  void setHighlightedPointIndex(num? index) {
    setState(() {
      _highlightedPointIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = List.generate(100, (index) {
      int year = 2010 + index;
      double value =
          20 + Random().nextDouble() * 80; // Random values between 20 and 100
      return ChartData(year, value);
    });

    return SfCartesianChart(
      onTooltipRender: (TooltipArgs args) =>
          setHighlightedPointIndex(args.pointIndex),
      onMarkerRender: (MarkerRenderArgs args) {
        if (_highlightedPointIndex == null) {
          print("null");
          return;
        }
        if (args.pointIndex == _highlightedPointIndex) {
          print('highlighted');
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
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
      ),
      tooltipBehavior: TooltipBehavior(
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
            markerSettings: MarkerSettings(
              height: 14,
              width: 14,
              isVisible: false,
            ),
            borderDrawMode: BorderDrawMode.top,
            borderWidth: 5,
            borderColor: Theme.of(context).colorScheme.primary,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.2),
                Theme.of(context).scaffoldBackgroundColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y)
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final double y;
}
