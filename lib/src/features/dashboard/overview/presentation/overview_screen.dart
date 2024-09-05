import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/data_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
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
        icon: TradelyIcons.overview,
        currentRoute: location,
        title: "Good morning, Robin! 👋",
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
                      BaseContainerExpanded(
                        child: Text("data"),
                      ),
                      BaseContainerExpanded(
                        child: Text("data"),
                      ),
                    ],
                  ),
                ),
                BaseContainerExpanded(
                  flex: 3,
                  child: Text("data"),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  BaseContainerExpanded(
                    flex: 2,
                    child: Text("data"),
                  ),
                  BaseContainerExpanded(
                    child: Text("data"),
                  ),
                  BaseContainerExpanded(
                    child: Text("data"),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
