import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class ProfitContainer extends StatefulWidget {
  final double? factor;

  final double? profit;
  final double? loss;

  final bool loading;

  const ProfitContainer({
    super.key,
    this.factor,
    this.profit,
    this.loss,
    this.loading = false,
  });

  @override
  State<ProfitContainer> createState() => _ProfitContainerState();
}

class _ProfitContainerState extends State<ProfitContainer> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BaseDataContainer(
      title: 'Profit Factor',
      toolTip:
          'The profit factor is calculated by dividing total profits by total losses. \nA value greater than 1.0 signifies a profitable trading system',
      child: MouseRegion(
        onExit: (_) {
          setState(() {
            selectedIndex = null;
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              width: PaddingSizes.large,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.factor?.toStringAsFixed(2) ?? "-",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 30,
                      ),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                height: 128,
                width: 81,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            int? index = selectedIndex;
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              index = null;
                              return;
                            }
                            index = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;

                            if (index != selectedIndex) {
                              setState(() {
                                selectedIndex = index;
                              });
                            }
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 24,
                        startDegreeOffset: 270,
                        sections: [
                          PieChartSectionData(
                            showTitle: false,
                            value: widget.profit,
                            color: HexColor.fromHex('#14D39F'),
                            radius: selectedIndex == 0 ? 8 : 6,
                          ),
                          PieChartSectionData(
                            showTitle: false,
                            value: widget.loss,
                            color: HexColor.fromHex('#E13232'),
                            radius: selectedIndex == 1 ? 8 : 6,
                          ),
                        ],
                      ),
                    ),
                    AnimatedPositioned(
                      top: selectedIndex == 0 ? null : -8,
                      bottom: selectedIndex == 0 ? -8 : null,
                      left: selectedIndex == 0 ? null : -24,
                      right: selectedIndex == 0 ? -24 : null,
                      duration: kThemeAnimationDuration,
                      child: Visibility(
                        visible: selectedIndex == 0 || selectedIndex == 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(BorderRadii.extraSmall),
                            color: selectedIndex == 0
                                ? HexColor.fromHex('#14D39F')
                                : HexColor.fromHex('#E13232'),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: PaddingSizes.xxs,
                              horizontal: PaddingSizes.extraSmall,
                            ),
                            child: Text(
                              selectedIndex == 0
                                  ? TradelyNumberUtils.formatNullableValuta(
                                      widget.profit)
                                  : TradelyNumberUtils.formatNullableValuta(
                                      widget.loss,
                                    ),
                              style: TextStyles.bodySmall.copyWith(
                                fontSize: 11,
                                color: TextStyles.titleColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: PaddingSizes.large,
            ),
          ],
        ),
      ),
    );
  }
}
