import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
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
    if (widget.data.isEmpty) {
      return _buildEmptyState(context);
    }

    final List<ChartData> chartData = widget.data.isEmpty ? [] : widget.data;

    double minimum = chartData.map((e) => e.y).reduce(min);
    double maximum = chartData.map((e) => e.y).reduce(max);

    minimum = ((minimum - ((maximum - minimum) * 2)) / 10).roundToDouble() * 10;
    maximum = maximum + (maximum - minimum);

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
      selectionType: SelectionType.point,
      // Removes the border around the chart plot area
      primaryXAxis: DateTimeAxis(
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
        interval: (maximum - minimum) / 8,
        decimalPlaces: 0,
        minimum: minimum,
        maximum: maximum,
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        axisLabelFormatter: (details) {
          String text = "\$${TradelyNumberUtils.formatValuta(
                details.value.toDouble(),
              ).split(".").firstOrNull ?? ""}";

          if (details.value < maximum - ((maximum - minimum) * 0.92)) {
            text = "";
          }

          if (details.value > maximum - ((maximum - minimum) * 0.08)) {
            text = "";
          }

          return ChartAxisLabel(
            text,
            Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFA2A2AA),
                  letterSpacing: 0,
                ),
          );
        },
      ),
      tooltipBehavior: TooltipBehavior(
        color: Theme.of(context).colorScheme.primary,
        elevation: 0,
        shadowColor: Theme.of(context).colorScheme.primary,
        enable: true,
        shouldAlwaysShow: false,
        canShowMarker: false,
        header: '',
        format: '\$point.y',
        duration: 0,
        builder: (data, _, __, pointIndex, index) {
          ChartData c = data as ChartData;

          return IntrinsicWidth(
            child: Container(
              height: 27,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    spreadRadius: 1,
                    blurRadius: 4,
                  )
                ],
                borderRadius: BorderRadius.circular(
                  BorderRadii.small,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: PaddingSizes.small,
                ),
                child: Center(
                  child: Text(
                    '\$ ${c.y.toStringAsFixed(2)}',
                    style: TextStyles.bodyMedium.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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

  final DateTime x;
  final double y;
}

Widget _buildEmptyState(BuildContext context) {
  final List<ChartData> emptyChartData = _getEmptyChartData();

  return Stack(
    children: [
      SfCartesianChart(
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
          minimum: 40,
          maximum: 150,
          interval: 20,
          labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFA2A2AA),
                letterSpacing: 0,
              ),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(width: 0),
        ),
        series: <ChartSeries<ChartData, int>>[
          AreaSeries<ChartData, int>(
            dataSource: emptyChartData,
            xValueMapper: (ChartData data, _) => data.x.millisecondsSinceEpoch,
            yValueMapper: (ChartData data, _) => data.y,
            markerSettings: const MarkerSettings(
              height: 14,
              width: 14,
              isVisible: false,
            ),
            borderDrawMode: BorderDrawMode.top,
            borderWidth: 4,
            borderColor: const Color(0xFF181818),
            gradient: LinearGradient(
              stops: const [0.5, 1],
              colors: [
                HexColor.fromHex('141414'),
                HexColor.fromHex('111111').withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ],
        plotAreaBorderWidth: 0,
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Add exchange \nfirst to start',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: const Color(0xFFCCCCCC).withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
          ),
        ),
      ),
    ],
  );
}

List<ChartData> _getEmptyChartData() {
  List<ChartData> emptyData = [
    ChartData(DateTime.now(), 60),
    ChartData(DateTime.now(), 72),
    ChartData(DateTime.now(), 80),
    ChartData(DateTime.now(), 70),
    ChartData(DateTime.now(), 90),
    ChartData(DateTime.now(), 85),
    ChartData(DateTime.now(), 100),
    ChartData(DateTime.now(), 110),
    ChartData(DateTime.now(), 130),
    ChartData(DateTime.now(), 120),
  ];

  return emptyData;
}
