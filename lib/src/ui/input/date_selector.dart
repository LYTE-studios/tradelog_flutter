import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

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

    ;

    return Column(
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
          height: PaddingSizes.extraLarge,
        ),
        Expanded(
          child: SfDateRangePicker(
            onViewChanged: onSwipe,
            monthCellStyle: DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(
                color: colorScheme.onPrimary,
              ),
              // sorry, I couldn't be bothered with writing a custom cell builder
              // just to make the today date a smaller circle...
              // yes, it's a fake border that matches the size of the select circle
              todayCellDecoration: BoxDecoration(
                border: Border.all(
                  width: 15,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
                color: colorScheme.primary.withOpacity(0.5),
                shape: BoxShape.circle,
                // Make it a circle
              ),
            ),
            monthViewSettings: DateRangePickerMonthViewSettings(
              viewHeaderHeight: 60,
              showTrailingAndLeadingDates: true,
              dayFormat: 'EE',
              firstDayOfWeek: 1,
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: textTheme.titleSmall?.copyWith(),
              ),
            ),
            selectionRadius: 20,
            todayHighlightColor: TextStyles.titleColor,
            enablePastDates: true,
            controller: _controller,
            headerHeight: 0,
            allowViewNavigation: false,
          ),
        ),
      ],
    );
  }
}
