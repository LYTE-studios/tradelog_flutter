import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/overview_statistics_dto.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class DateSelector extends StatefulWidget {
  final DateRangePickerSelectionMode pickerSelectionMode;

  final Function(DateTime)? onDateChanged;

  final Function(DateTime, DateTime)? onDatesChanged;

  final Map<DateTime, DayPerformanceDto>? chartData;

  final DateTime? from;
  final DateTime? to;

  final int firstDayOfWeek; // Add this parameter

  /// has a fixed height of 380
  const DateSelector({
    super.key,
    this.pickerSelectionMode = DateRangePickerSelectionMode.single,
    this.onDateChanged,
    this.chartData,
    this.onDatesChanged,
    this.from,
    this.to,
    this.firstDayOfWeek = 7, // Default to Sunday
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
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
              backgroundColor: Colors.transparent,
              initialDisplayDate: widget.from,
              initialSelectedRange: PickerDateRange(widget.from, widget.to),
              onSelectionChanged: (args) {
                if (widget.pickerSelectionMode ==
                    DateRangePickerSelectionMode.range) {
                  widget.onDatesChanged?.call(
                    args.value.startDate,
                    args.value.endDate,
                  );
                } else {
                  widget.onDateChanged?.call(args.value);
                }
              },
              selectionMode: widget.pickerSelectionMode,
              onViewChanged: onSwipe,
              rangeTextStyle: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
              ),
              // cellBuilder: (context, details) {
              //   DayPerformanceDto? dayPerformance = widget.chartData?[DateTime(
              //     details.date.year,
              //     details.date.month,
              //     details.date.day,
              //   )];

              //   double? profit = dayPerformance?.totalProfit;
              //   double? loss = dayPerformance?.totalLoss?.abs();

              //   if (profit != null) {
              //     print([profit, loss]);
              //   }

              //   return Container(
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //     ),
              //     child: Stack(
              //       clipBehavior: Clip.none,
              //       children: [
              //         if (profit != null && loss != null && profit + loss != 0)
              //           CircularProgressIndicator(
              //             value: profit / (profit + loss),
              //             color: HexColor.fromHex('#14D39F'),
              //             backgroundColor: HexColor.fromHex('#E13232'),
              //           ),
              //         Center(
              //           child: Text(
              //             details.date.day.toString(),
              //             style: textTheme.titleSmall?.copyWith(
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   );
              // },
              monthCellStyle: DateRangePickerMonthCellStyle(
                todayTextStyle: TextStyle(
                  color: colorScheme.onPrimary,
                ),
                todayCellDecoration: BoxDecoration(
                  border: Border.all(
                    width: 9,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                  color: colorScheme.onPrimary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                textStyle: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                trailingDatesTextStyle: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: TextStyles.titleColor.withOpacity(0.3),
                ),
                leadingDatesTextStyle: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: TextStyles.titleColor.withOpacity(0.3),
                ),
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                viewHeaderHeight: 60,
                showTrailingAndLeadingDates: true,
                dayFormat: 'EE',
                firstDayOfWeek: widget.firstDayOfWeek, // Add this line
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              selectionRadius: 17,
              selectionShape: DateRangePickerSelectionShape.circle,
              todayHighlightColor: TextStyles.titleColor,
              rangeSelectionColor: colorScheme.secondaryContainer,
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
