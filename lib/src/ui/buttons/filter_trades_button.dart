import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/buttons/dialog_button.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/date_selector.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class FilterTradesButton extends StatelessWidget {
  final Function() onTap;

  final double height;

  final String? text;

  final String? prefixIcon;

  final bool? leaveIconUnaltered;

  const FilterTradesButton({
    super.key,
    required this.onTap,
    required this.height,
    this.text,
    this.prefixIcon,
    this.leaveIconUnaltered,
  });

  @override
  Widget build(BuildContext context) {
    return DialogButton(
      onTap: () {},
      height: height,
      text: text,
      prefixIcon: prefixIcon,
      dialog: BaseContainer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        height: 640,
        width: 520,
        child: Column(
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
                  onTap: () {},
                  height: 34,
                  width: 95,
                  text: "Long",
                  prefixIcon: TradelyIcons.trendUp,
                  prefixIconSize: 12,
                ),
                const SizedBox(
                  width: PaddingSizes.medium,
                ),
                PrimaryButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PaddingSizes.medium,
                  ),
                  onTap: () {},
                  height: 34,
                  width: 95,
                  text: "Short",
                  prefixIcon: TradelyIcons.trendDown,
                  prefixIconSize: 12,
                ),
                const SizedBox(
                  width: PaddingSizes.medium,
                ),
                PrimaryButton(
                  onTap: () {},
                  height: 34,
                  width: 95,
                  text: "- Both",
                ),
              ],
            ),
            const SizedBox(
              height: PaddingSizes.extraLarge,
            ),
            Row(
              children: [
                PrimaryButton(
                  onTap: () {},
                  height: 34,
                  width: 95,
                  text: "Closed",
                ),
                const SizedBox(
                  width: PaddingSizes.medium,
                ),
                PrimaryButton(
                  onTap: () {},
                  height: 34,
                  width: 95,
                  text: "Open",
                ),
                const SizedBox(
                  width: PaddingSizes.medium,
                ),
                PrimaryButton(
                  onTap: () {},
                  height: 34,
                  width: 95,
                  text: "Both",
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
                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
