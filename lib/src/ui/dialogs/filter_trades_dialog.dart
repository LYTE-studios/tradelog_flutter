import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tradelog_flutter/src/core/data/models/enums/trade_enums.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/date_selector.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

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
    final unSelectedColor = Theme.of(context).colorScheme.primaryContainer;

    return Column(
      children: [
        DateSelector(
          from: from,
          to: to,
          onDatesChanged: onUpdateDateFilter,
          pickerSelectionMode: DateRangePickerSelectionMode.range,
        ),
        const SizedBox(
          height: PaddingSizes.xxxl,
        ),
        // Row(
        //   children: [
        //     PrimaryButton(
        //       padding: const EdgeInsets.symmetric(
        //         horizontal: PaddingSizes.medium,
        //       ),
        //       onTap: () => onUpdateTradeTypeFilter.call(TradeOption.long),
        //       height: 34,
        //       width: 95,
        //       text: "Long",
        //       prefixIcon: TradelyIcons.trendUp,
        //       prefixIconSize: 12,
        //       color:
        //           tradeTypeFilter != TradeOption.long ? unSelectedColor : null,
        //     ),
        //     const SizedBox(
        //       width: PaddingSizes.medium,
        //     ),
        //     PrimaryButton(
        //       padding: const EdgeInsets.symmetric(
        //         horizontal: PaddingSizes.medium,
        //       ),
        //       onTap: () => onUpdateTradeTypeFilter.call(TradeOption.short),
        //       height: 34,
        //       width: 100,
        //       text: "Short",
        //       prefixIcon: TradelyIcons.trendDown,
        //       prefixIconSize: 12,
        //       color:
        //           tradeTypeFilter != TradeOption.short ? unSelectedColor : null,
        //     ),
        //     const SizedBox(
        //       width: PaddingSizes.medium,
        //     ),
        //     PrimaryButton(
        //       onTap: () => onUpdateTradeTypeFilter.call(TradeOption.long),
        //       height: 34,
        //       width: 95,
        //       text: "- Both",
        //       color:
        //           tradeTypeFilter != TradeOption.long ? unSelectedColor : null,
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: PaddingSizes.extraLarge,
        // ),
        // Row(
        //   children: [
        //     PrimaryButton(
        //       onTap: () => onUpdateTradeStatusFilter.call(TradeStatus.closed),
        //       height: 34,
        //       width: 95,
        //       text: "Closed",
        //       color: tradeStatusFilter != TradeStatus.closed
        //           ? unSelectedColor
        //           : null,
        //     ),
        //     const SizedBox(
        //       width: PaddingSizes.medium,
        //     ),
        //     PrimaryButton(
        //       onTap: () => onUpdateTradeStatusFilter.call(TradeStatus.open),
        //       height: 34,
        //       width: 95,
        //       text: "Open",
        //       color: tradeStatusFilter != TradeStatus.open
        //           ? unSelectedColor
        //           : null,
        //     ),
        //     const SizedBox(
        //       width: PaddingSizes.medium,
        //     ),
        //     PrimaryButton(
        //       onTap: () => onUpdateTradeStatusFilter.call(TradeStatus.open),
        //       height: 34,
        //       width: 95,
        //       text: "Both",
        //       color: tradeStatusFilter != TradeStatus.open
        //           ? unSelectedColor
        //           : null,
        //     ),
        //   ],
        // ),
        // const Spacer(),
        Row(
          children: [
            PrimaryButton(
              onTap: onShowTrades,
              height: 46,
              width: 195,
              prefixIcon: TradelyIcons.search,
              text: "Show results",
            ),
            const SizedBox(
              width: PaddingSizes.medium,
            ),
            // PrimaryButton(
            //   onTap: () {},
            //   height: 46,
            //   width: 195,
            //   prefixIcon: TradelyIcons.reset,
            //   text: "Reset filters",
            //   textStyle: Theme.of(context).textTheme.titleMedium,
            //   color: Theme.of(context).scaffoldBackgroundColor,
            //   prefixIconColor: TextStyles.mediumTitleColor,
            //   outlined: true,
            //   borderColor: Theme.of(context).colorScheme.outline,
            // ),
          ],
        )
      ],
    );
  }
}
