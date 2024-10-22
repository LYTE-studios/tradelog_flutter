import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tradelog_flutter/src/core/enums/tradely_enums.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/date_selector.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class FilterTradesDialog extends StatelessWidget {
  final TradeStatus tradeStatusFilter;

  final TradeType tradeTypeFilter;

  final Function(TradeType) onUpdateTradeTypeFilter;

  final Function(TradeStatus) onUpdateTradeStatusFilter;

  final Function() onResetFilters;

  final Function() onShowTrades;

  const FilterTradesDialog({
    super.key,
    required this.tradeStatusFilter,
    required this.tradeTypeFilter,
    required this.onUpdateTradeTypeFilter,
    required this.onResetFilters,
    required this.onUpdateTradeStatusFilter,
    required this.onShowTrades,
  });

  @override
  Widget build(BuildContext context) {
    final unSelectedColor = Theme.of(context).colorScheme.primaryContainer;

    return Column(
      children: [
        const DateSelector(
          pickerSelectionMode: DateRangePickerSelectionMode.range,
        ),
        const SizedBox(
          height: PaddingSizes.xxxl,
        ),
        Row(
          children: [
            PrimaryButton(
              padding: const EdgeInsets.symmetric(
                horizontal: PaddingSizes.medium,
              ),
              onTap: () => onUpdateTradeTypeFilter.call(TradeType.long),
              height: 34,
              width: 95,
              text: "Long",
              prefixIcon: TradelyIcons.trendUp,
              prefixIconSize: 12,
              color: tradeTypeFilter != TradeType.long ? unSelectedColor : null,
            ),
            const SizedBox(
              width: PaddingSizes.medium,
            ),
            PrimaryButton(
              padding: const EdgeInsets.symmetric(
                horizontal: PaddingSizes.medium,
              ),
              onTap: () => onUpdateTradeTypeFilter.call(TradeType.short),
              height: 34,
              width: 95,
              text: "Short",
              prefixIcon: TradelyIcons.trendDown,
              prefixIconSize: 12,
              color:
                  tradeTypeFilter != TradeType.short ? unSelectedColor : null,
            ),
            const SizedBox(
              width: PaddingSizes.medium,
            ),
            PrimaryButton(
              onTap: () => onUpdateTradeTypeFilter.call(TradeType.both),
              height: 34,
              width: 95,
              text: "- Both",
              color: tradeTypeFilter != TradeType.both ? unSelectedColor : null,
            ),
          ],
        ),
        const SizedBox(
          height: PaddingSizes.extraLarge,
        ),
        Row(
          children: [
            PrimaryButton(
              onTap: () => onUpdateTradeStatusFilter.call(TradeStatus.closed),
              height: 34,
              width: 95,
              text: "Closed",
              color: tradeStatusFilter != TradeStatus.closed
                  ? unSelectedColor
                  : null,
            ),
            const SizedBox(
              width: PaddingSizes.medium,
            ),
            PrimaryButton(
              onTap: () => onUpdateTradeStatusFilter.call(TradeStatus.open),
              height: 34,
              width: 95,
              text: "Open",
              color: tradeStatusFilter != TradeStatus.open
                  ? unSelectedColor
                  : null,
            ),
            const SizedBox(
              width: PaddingSizes.medium,
            ),
            PrimaryButton(
              onTap: () => onUpdateTradeStatusFilter.call(TradeStatus.both),
              height: 34,
              width: 95,
              text: "Both",
              color: tradeStatusFilter != TradeStatus.both
                  ? unSelectedColor
                  : null,
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            PrimaryButton(
              onTap: () {},
              height: 46,
              width: 195,
              prefixIcon: TradelyIcons.search,
              text: "Show 23 trades",
            ),
            const SizedBox(
              width: PaddingSizes.medium,
            ),
            PrimaryButton(
              onTap: () {},
              height: 46,
              width: 195,
              prefixIcon: TradelyIcons.reset,
              text: "Reset filters",
              textStyle: Theme.of(context).textTheme.titleMedium,
              color: Theme.of(context).scaffoldBackgroundColor,
              prefixIconColor: TextStyles.mediumTitleColor,
              outlined: true,
              borderColor: Theme.of(context).colorScheme.outline,
            ),
          ],
        )
      ],
    );
  }
}
