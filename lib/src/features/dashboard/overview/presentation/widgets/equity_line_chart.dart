import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EquityLineChart extends StatefulWidget {
  const EquityLineChart({super.key});

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
        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFA2A2AA),
              letterSpacing: 0,
            ),
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFA2A2AA),
              letterSpacing: 0,
            ),
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
