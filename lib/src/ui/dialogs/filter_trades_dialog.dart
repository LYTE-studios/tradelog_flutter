import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/dialogs/filter_trade_box.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class FilterTradesDialog extends StatelessWidget {
  final DateTime? from;
  final DateTime? to;
  final Function(DateTime, DateTime)? onUpdateDateFilter;
  final Function() onResetFilters;
  final Function() onShowTrades;

  const FilterTradesDialog({
    super.key,
    this.onUpdateDateFilter,
    required this.onResetFilters,
    required this.onShowTrades,
    this.from,
    this.to,
  });

  @override
  Widget build(BuildContext context) {
    return DarkCalendar(
      selectedDate: from ?? DateTime.now(),
      onDateSelected: (date) {
        if (onUpdateDateFilter != null) {
          onUpdateDateFilter!(date, date);
          onShowTrades();
        }
      },
    );
  }
}
