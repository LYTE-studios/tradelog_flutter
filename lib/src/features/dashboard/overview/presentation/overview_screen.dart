import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/chart_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/holding_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/long_short_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/profit_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  static const String route = '/$location';
  static const String location = 'overview';

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Discover all your performance metrics & progress.",
        icon: 'assets/emojis/Wave.png',
        currentRoute: location,
        title: "Good morning, Robin!",
        buttons: PrimaryButton(
          onTap: () {},
          height: 42,
          text: "Add new trade",
          prefixIcon: TradelyIcons.plusCircle,
          prefixIconSize: 22,
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      DataContainer(
                        title: 'Net Profit/Loss',
                        toolTip: 'test',
                      ),
                      DataContainer(
                        title: 'Trade win rate',
                        toolTip: 'test',
                        data: "43%",
                        percentage: 2,
                        up: false,
                      ),
                      DataContainer(
                        title: ' Avg realized R:R',
                        toolTip: 'test',
                        data: "\$123,88",
                        percentage: 45,
                        up: true,
                      ),
                    ],
                  ),
                ),
                ChartContainer(
                  data: null,
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  LongShortContainer(),
                  HoldingContainer(
                    holdingTime: 20,
                  ),
                  ProfitContainer(
                    percentage: 45,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
