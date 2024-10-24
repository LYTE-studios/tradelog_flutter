import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class LinkedAccount extends StatelessWidget {
  final double balance;

  final String symbol;

  final String name;

  final bool active;

  const LinkedAccount({
    super.key,
    required this.name,
    required this.balance,
    required this.active,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: PaddingSizes.extraLarge,
        vertical: PaddingSizes.medium,
      ),
      outsidePadding: const EdgeInsets.only(
        bottom: PaddingSizes.medium,
      ),
      width: 210,
      height: 135,
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      enableBorder: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available balance",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(
                    height: PaddingSizes.xxs,
                  ),
                  Text(
                    "$symbol${balance.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 19,
                        ),
                  ),
                ],
              ),
              SvgIcon(
                TradelyIcons.ellipsisVertical,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 20,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                        ),
                  ),
                  const SizedBox(
                    height: PaddingSizes.xxs,
                  ),
                  Text(
                    "Active",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ],
              ),
              // const SvgIcon(
              //   TradelyIcons.warning,
              //   leaveUnaltered: true,
              // ),
            ],
          )
        ],
      ),
    );
  }
}
