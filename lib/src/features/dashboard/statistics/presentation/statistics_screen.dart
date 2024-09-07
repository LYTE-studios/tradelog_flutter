import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/statistics/presentation/widgets/small_data_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/data/data_list.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  static const String route = '/$location';
  static const String location = 'statistics';

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Lorem ipsum dolor sit amet consectetur lorem.",
        icon: TradelyIcons.statistics,
        currentRoute: location,
        title: "Statistics 📊",
        buttons: Row(
          children: [
            PrimaryButton(
              onTap: () {},
              height: 42,
              text: "Export list",
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            const SizedBox(
              width: PaddingSizes.large,
            ),
            PrimaryButton(
              onTap: () {},
              height: 42,
              text: "Filter trades",
              prefixIcon: TradelyIcons.diary,
            ),
          ],
        ),
      ),
      child: const Column(
        children: [
          // should this Row be a fixed height?
          SizedBox(
            height: 150,
            child: Row(
              children: [
                SmallDataContainer(
                  title: 'Best trading month',
                  positive: true,
                  data: "123",
                ),
                SmallDataContainer(
                  title: 'Worst trading month',
                  positive: false,
                  data: "1528,451",
                ),
                SmallDataContainer(
                  title: 'Average trading month',
                ),
                SmallDataContainer(
                  title: 'Coming soon',
                  blurred: true,
                ),
                SmallDataContainer(
                  title: 'Coming soon',
                  blurred: true,
                ),
                SmallDataContainer(
                  title: 'Coming soon',
                  blurred: true,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // todo, add the data etc.
                DataList(),
                DataList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
