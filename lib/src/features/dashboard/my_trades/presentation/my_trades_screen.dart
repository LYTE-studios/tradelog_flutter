import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/enums/tradely_enums.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/filter_trades_button.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class MyTradesScreen extends StatefulWidget {
  const MyTradesScreen({super.key});

  static const String route = '/$location';
  static const String location = 'my_trades';

  @override
  State<MyTradesScreen> createState() => _MyTradesScreenState();
}

class _MyTradesScreenState extends State<MyTradesScreen> {
  TradeType tradeTypeFilter = TradeType.short;

  void onUpdateTradeType(TradeType type) {
    setState(() {
      tradeTypeFilter = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Lorem ipsum dolor sit amet consectetur lorem.",
        icon: TradelyIcons.myTrades,
        currentRoute: MyTradesScreen.location,
        title: "My trades",
        titleIconPath: 'assets/images/emojis/chart_emoji.png',
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
            FilterTradesButton(
              onTap: () {},
              height: 42,
              text: "Filter trades",
              prefixIcon: TradelyIcons.diary,
              tradeStatusFilter: TradeStatus.both,
              tradeTypeFilter: tradeTypeFilter,
              onUpdateTradeTypeFilter: onUpdateTradeType,
              onUpdateTradeStatusFilter: (TradeStatus st) {
                print(st);
              },
              onResetFilters: () {},
              onShowTrades: () {},
            ),
          ],
        ),
      ),
    );
  }
}
