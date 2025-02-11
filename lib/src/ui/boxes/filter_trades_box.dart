import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/date_selector.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class FilterTradesBox extends StatelessWidget {
  final DateTime? from;
  final DateTime? to;
  final Function(DateTime, DateTime)? onUpdateDateFilter;
  final Function() onResetFilters;
  final Function() onShowTrades;

  const FilterTradesBox({
    super.key,
    this.onUpdateDateFilter,
    required this.onResetFilters,
    required this.onShowTrades,
    this.from,
    this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PaddingSizes.large),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DateSelector(
            from: from,
            to: to,
            onDatesChanged: onUpdateDateFilter,
            pickerSelectionMode: DateRangePickerSelectionMode.range,
          ),
          const SizedBox(height: PaddingSizes.xxxl),
        ],
      ),
    );
  }
}
