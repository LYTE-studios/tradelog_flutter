import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/mixins/screen_state_mixin.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_switcher.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';
import 'package:intl/intl.dart'; // Add this import at the top

class EquityLineChart extends StatefulWidget {
  final DateTime? from;

  final DateTime? to;
  final String noDataMessage;

  final Function(double?, double?)?
      onUpdateBalance; // Modified to include previous balance

  const EquityLineChart({
    super.key,
    this.from,
    this.to,
    this.noDataMessage = 'No data',
    this.onUpdateBalance,
  });

  @override
  State<EquityLineChart> createState() => _EquityLineChartState();
}

class _EquityLineChartState extends State<EquityLineChart>
    with ScreenStateMixin {
  late DateTime? from = widget.from;
  late DateTime? to = widget.to;

  List<ChartData> chartData = [];
  List<ChartData> comparisonData = []; // Add this line

  @override
  Future<void> loadData() async {
    Map<DateTime, double> map = await UsersService().getAccountBalanceChart(
      from: widget.from,
      to: widget.to,
    );

    chartData = map.entries.map((e) => ChartData(e.key, e.value)).toList();

    if (chartData.isNotEmpty) {
      List<DateTime> dates = map.keys.toList();

      dates.sort((a, b) => a.compareTo(b));

      // Get current and previous values
      double? currentValue = map[dates.last];
      double? previousValue =
          dates.length > 1 ? map[dates[dates.length - 2]] : null;

      widget.onUpdateBalance?.call(currentValue, previousValue);
    } else {
      widget.onUpdateBalance?.call(null, null);
    }

    setState(() {
      chartData = chartData;
    });

    await super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (from != widget.from || to != widget.to) {
      from = widget.from;
      to = widget.to;
      Future(() async {
        setLoading(true);
        await loadData();
        setLoading(false);
      });
    }

    bool useEmptyState = chartData.length <= 1;

    List<ChartData> data = useEmptyState ? _getEmptyChartData() : chartData;

    data.sort((a, b) => a.x.compareTo(b.x));

    // Generate comparison data first so we can include it in min/max calculations
    comparisonData = data.map((item) {
      int index = data.indexOf(item);
      double progress = index / (data.length - 1);
      double factor = 0.85 + (0.13 * progress);
      factor += 0.03 * sin(progress * 3.14159 * 2);
      return ChartData(item.x, item.y * factor);
    }).toList();

    // Calculate min/max including both datasets
    double minimum = min(
      data.map((e) => e.y).reduce(min),
      comparisonData.map((e) => e.y).reduce(min),
    );
    double maximum = max(
      data.map((e) => e.y).reduce(max),
      comparisonData.map((e) => e.y).reduce(max),
    );

    // Add padding to the range
    minimum = ((minimum - (maximum - minimum) * 0.1)).roundToDouble();
    maximum = (maximum + (maximum - minimum) * 0.1).roundToDouble();

    if (maximum - minimum < 10) {
      maximum = maximum + 10;
      minimum = minimum - 10;
    }

    double interval = (maximum - minimum) / 8;

    return TradelyLoadingSwitcher(
      loading: loading,
      child: Stack(
        children: [
          ImageFiltered(
            imageFilter: useEmptyState
                ? ImageFilter.blur(sigmaX: 5, sigmaY: 5)
                : ImageFilter.blur(),
            child: SfCartesianChart(
              margin: const EdgeInsets.only(
                  bottom: 30), // Add bottom margin for dates
              plotAreaBorderWidth: 0, // Remove border
              selectionType: SelectionType.point,
              primaryXAxis: DateTimeAxis(
                name: 'Date',
                axisLine: const AxisLine(width: 0),
                majorGridLines: MajorGridLines(
                  width: 1,
                  dashArray: const [5, 5],
                  color: TextStyles.labelTextColor.withOpacity(0.3),
                ),
                // Add padding to the plot area
                plotOffset: 0,
                plotBands: const [
                  PlotBand(
                    isVisible: true,
                    opacity: 0,
                    size: 30,
                    verticalTextAlignment: TextAnchor.start,
                  ),
                ],
                desiredIntervals: 11,
                majorTickLines: const MajorTickLines(width: 0),
                labelStyle: const TextStyle(
                  fontSize: 0, // Set to 0 to hide default labels
                  color: Colors.transparent, // Make labels transparent
                ),
              ),
              primaryYAxis: NumericAxis(
                name: 'Equity',
                axisLine: const AxisLine(width: 0),
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
                decimalPlaces: 0,
                minimum: minimum,
                maximum: maximum,
                interval: interval <= 0 ? 1 : interval,
                axisLabelFormatter: (details) {
                  String formatValue(double value) {
                    if (value >= 1000) {
                      return '${(value / 1000).toStringAsFixed(1)}k';
                    }
                    return value.toStringAsFixed(2);
                  }

                  List<double> keyPoints = [
                    minimum,
                    minimum + (maximum - minimum) / 3,
                    (minimum + maximum) / 2,
                    maximum - (maximum - minimum) / 3,
                    maximum
                  ];

                  bool shouldShow = keyPoints
                      .any((point) => (details.value - point).abs() < 0.01);

                  if (!shouldShow) {
                    return ChartAxisLabel("", const TextStyle());
                  }

                  return ChartAxisLabel(
                    "\$${formatValue(details.value.toDouble())}",
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
                enable: true,
                color: const Color(0xFF2A2A3C),
                borderColor: const Color(0xFF404040),
                borderWidth: 1,
                duration: 2000,
                shouldAlwaysShow: false,
                builder: (data, point, series, pointIndex, seriesIndex) {
                  // The tooltip box is built here in the Container below.
                  // The small arrow connecting the box to the dot is rendered automatically
                  // by the Syncfusion trackball marker settings.
                  final ChartData chartData = data as ChartData;
                  final ChartData? comparisonPoint =
                      pointIndex < comparisonData.length
                          ? comparisonData[pointIndex]
                          : null;
                  String formatValue(double value) {
                    if (value >= 1000) {
                      return '\$${(value / 1000).toStringAsFixed(1)}k';
                    }
                    return '\$${value.toStringAsFixed(1)}';
                  }

                  // Use one month before for the previous period
                  final DateTime previousPeriodDate =
                      chartData.x.subtract(const Duration(days: 30));

                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF15161E), // dark background color
                      borderRadius: BorderRadius.circular(4),
                      // Removed border outline
                    ),
                    child: Container(
                      width: 140, // reduced width
                      padding: const EdgeInsets.all(4), // reduced inner padding
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Equity',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const Divider(
                            color: Color(
                                0xFF272835), // horizontal divider with given color
                            thickness: 0.5,
                            height: 4, // reduced height
                          ),
                          // Current period row
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                DateFormat('MMM d, y').format(chartData.x),
                                style: const TextStyle(
                                  color:
                                      Color(0xFF666D80), // updated date color
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight.w300, // lighter font weight
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                formatValue(chartData.y),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary, // dark blue for current period
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          if (comparisonPoint != null) ...[
                            const SizedBox(height: 4),
                            // Previous period row
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  DateFormat('MMM d, y')
                                      .format(comparisonPoint.x),
                                  style: const TextStyle(
                                    color:
                                        Color(0xFF666D80), // updated date color
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w300, // lighter font weight
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  formatValue(comparisonPoint.y),
                                  style: const TextStyle(
                                    color: Color(
                                        0xFF33CFFF), // light blue for previous period
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
              series: [
                SplineSeries<ChartData, DateTime>(
                  splineType: SplineType.monotonic,
                  cardinalSplineTension: 0.1,
                  markerSettings: const MarkerSettings(
                    isVisible: false,
                    height: 8,
                    width: 8,
                    shape: DataMarkerType.circle,
                    borderWidth: 2,
                    color: Colors.white,
                  ),
                  width: 3,
                  color: Theme.of(context).colorScheme.primary,
                  dataSource: data,
                  xValueMapper: (data, _) => data.x,
                  yValueMapper: (data, _) => data.y,
                  enableTooltip: true,
                ),
                SplineSeries<ChartData, DateTime>(
                  splineType: SplineType.monotonic,
                  cardinalSplineTension: 0.1,
                  dashArray: const [5, 5],
                  width: 2,
                  color: const Color(0xFF33CFFF),
                  dataSource: comparisonData,
                  xValueMapper: (data, _) => data.x,
                  yValueMapper: (data, _) => data.y,
                  enableTooltip: true,
                  markerSettings: const MarkerSettings(
                    isVisible: false,
                    height: 0,
                    width: 0,
                  ),
                ),
              ],
              trackballBehavior: TrackballBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                tooltipDisplayMode:
                    TrackballDisplayMode.groupAllPoints, // changed here
                lineType: TrackballLineType.none,
                tooltipSettings: const InteractiveTooltip(
                  enable: false, // Disable small tooltip dialog
                  color: Color(0xFF2A2A3C),
                  borderColor: Color(0xFF404040),
                  borderWidth: 1,
                ),
                markerSettings: const TrackballMarkerSettings(
                  markerVisibility: TrackballVisibilityMode.visible,
                  height: 8,
                  width: 8,
                  color: Colors.white,
                  borderWidth: 2,
                ),
                shouldAlwaysShow: false,
                hideDelay: 2000,
              ),
              onTooltipRender: (TooltipArgs args) {
                if (args.text != null) {
                  final seriesIndex = args.seriesIndex;
                  final pointIndex = args.pointIndex;
                  // You can add custom logic here if needed
                }
              },
            ),
          ),
          if (!useEmptyState && chartData.isNotEmpty) ...[
            Positioned(
              bottom: 0,
              left: 10,
              child: Text(
                DateFormat('MMM d, y').format(chartData.first.x),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFA2A2AA),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: Text(
                DateFormat('MMM d, y').format(chartData.last.x),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFA2A2AA),
                ),
              ),
            ),
          ],
          Visibility(
            visible: useEmptyState,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  widget.noDataMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color(0xFFCCCCCC).withOpacity(0.6),
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final DateTime x;
  final double y;
}

List<ChartData> _getEmptyChartData() {
  List<ChartData> emptyData = [
    ChartData(
      DateTime.now().subtract(
        const Duration(days: 5),
      ),
      68,
    ),
    ChartData(
      DateTime.now().subtract(
        const Duration(days: 4),
      ),
      72,
    ),
    ChartData(
      DateTime.now().subtract(
        const Duration(days: 3),
      ),
      64,
    ),
    ChartData(
      DateTime.now().subtract(
        const Duration(days: 2),
      ),
      82,
    ),
    ChartData(
      DateTime.now().subtract(
        const Duration(days: 1),
      ),
      91,
    ),
    ChartData(
      DateTime.now(),
      100,
    ),
  ];

  return emptyData;
}
