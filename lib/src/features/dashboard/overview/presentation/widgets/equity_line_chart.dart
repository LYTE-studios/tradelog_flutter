import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_switcher.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class EquityLineChart extends StatefulWidget {
  final DateTime? from;

  final DateTime? to;

  final String noDataMessage;

  const EquityLineChart({
    super.key,
    this.from,
    this.to,
    this.noDataMessage = 'No data',
  });

  @override
  State<EquityLineChart> createState() => _EquityLineChartState();
}

class _EquityLineChartState extends State<EquityLineChart>
    with ScreenStateMixin {
  late DateTime? from = widget.from;
  late DateTime? to = widget.to;

  List<ChartData> chartData = [];

  @override
  Future<void> loadData() async {
    Map<DateTime, double> map = await UsersService().getAccountBalanceChart(
      from: widget.from,
      to: widget.to,
    );

    chartData = map.entries.map((e) => ChartData(e.key, e.value)).toList();

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

    List<ChartData> data = chartData.isEmpty ? _getEmptyChartData() : chartData;

    bool useEmptyState = chartData.isEmpty;

    double minimum = data.map((e) => e.y).reduce(min);
    double maximum = data.map((e) => e.y).reduce(max);

    minimum = ((minimum - (maximum - minimum)) / 10).roundToDouble() * 10;
    maximum = maximum + ((maximum - minimum) / 2);

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
                ? ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  )
                : ImageFilter.blur(),
            child: SfCartesianChart(
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
                interval: interval <= 0 ? 1 : interval,
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
                tooltipPosition: TooltipPosition.auto,
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
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                )
              ],
            ),
          ),
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
