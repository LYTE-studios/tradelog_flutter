import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/overview_statistics_dto.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class ChartedDateSelector extends StatefulWidget {
  final Function(DateTime)? onDateChanged;

  final Map<DateTime, DayPerformanceDto>? chartData;

  /// has a fixed height of 380
  const ChartedDateSelector({
    super.key,
    this.onDateChanged,
    this.chartData,
  });

  @override
  State<ChartedDateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<ChartedDateSelector> {
  final DateRangePickerController _controller = DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    String title = DateFormat("MMMM yyyy").format(
      _controller.displayDate ?? DateTime.now(),
    );

    void onNext() {
      setState(() {
        _controller.displayDate = DateTime(
          _controller.displayDate!.year,
          _controller.displayDate!.month + 1,
          1,
        );
      });
    }

    void onPrevious() {
      setState(() {
        _controller.displayDate = DateTime(
          _controller.displayDate!.year,
          _controller.displayDate!.month - 1,
          1,
        );
      });
    }

    void onSwipe(
        DateRangePickerViewChangedArgs dateRangePickerViewChangedArgs) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          title = DateFormat("MMMM yyyy").format(
            _controller.displayDate ?? DateTime.now(),
          );
        });
      });
    }

    return SizedBox(
      height: 380,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 23,
                ),
              ),
              Row(
                children: [
                  PrimaryButton(
                    prefixIcon: TradelyIcons.chevronLeft,
                    onTap: onPrevious,
                    height: 35,
                    width: 35,
                    padding: EdgeInsets.zero,
                    prefixIconPadding: EdgeInsets.zero,
                    color: colorScheme.secondaryContainer,
                  ),
                  const SizedBox(
                    width: PaddingSizes.large,
                  ),
                  PrimaryButton(
                    prefixIcon: TradelyIcons.chevronRight,
                    onTap: onNext,
                    height: 35,
                    width: 35,
                    padding: EdgeInsets.zero,
                    prefixIconPadding: EdgeInsets.zero,
                    color: colorScheme.secondaryContainer,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: PaddingSizes.large,
          ),
          Expanded(
            child: SfDateRangePicker(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              onSelectionChanged: (args) {
                widget.onDateChanged?.call(args.value);
              },
              initialSelectedDate: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
              selectionMode: DateRangePickerSelectionMode.single,
              onViewChanged: onSwipe,
              cellBuilder: (context, details) {
                DayPerformanceDto? dayPerformance;

                for (DateTime date in widget.chartData?.keys ?? []) {
                  if (date.year == details.date.year &&
                      date.month == details.date.month &&
                      date.day == details.date.day) {
                    dayPerformance = widget.chartData?[date];
                  }
                }

                double? profit = dayPerformance?.totalWon;
                double? loss = dayPerformance?.totalLoss?.abs();

                Color getChangeColor() {
                  if (profit != null || loss != null) {
                    if ((profit?.abs() ?? 0) > (loss?.abs() ?? 0)) {
                      return HexColor.fromHex('#14D39F').withOpacity(.7);
                    } else {
                      return HexColor.fromHex('#E13232').withOpacity(.7);
                    }
                  }

                  return Theme.of(context).colorScheme.primary.withOpacity(.8);
                }

                return Container(
                  height: details.bounds.height,
                  width: details.bounds.width,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Center(
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _controller.selectedDate
                                    ?.isAtSameMomentAs(details.date) ??
                                false
                            ? getChangeColor()
                            : Colors.transparent,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Center(
                            child: Text(
                              details.date.day.toString(),
                              style: textTheme.titleSmall?.copyWith(
                                color: details.visibleDates[10].month ==
                                        details.date.month
                                    ? null
                                    : TextStyles.labelTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          if (profit != null &&
                              loss != null &&
                              profit + loss != 0)
                            Center(
                              child: SizedBox(
                                height: 36,
                                width: 36,
                                child: CircularProgressIndicator(
                                  value: profit / (profit + loss),
                                  color: HexColor.fromHex('#14D39F'),
                                  backgroundColor: HexColor.fromHex('#E13232'),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              monthViewSettings: DateRangePickerMonthViewSettings(
                viewHeaderHeight: 60,
                showTrailingAndLeadingDates: true,
                dayFormat: 'EE',
                firstDayOfWeek: 1,
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              selectionColor: HexColor.fromHex("#161616"),
              rangeSelectionColor: Colors.transparent,
              endRangeSelectionColor: Colors.transparent,
              startRangeSelectionColor: Colors.transparent,
              todayHighlightColor: TextStyles.titleColor,
              selectionShape: DateRangePickerSelectionShape.circle,
              enablePastDates: true,
              controller: _controller,
              headerHeight: 0,
              allowViewNavigation: false,
            ),
          ),
        ],
      ),
    );
  }
}
