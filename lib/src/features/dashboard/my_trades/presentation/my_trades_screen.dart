import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/enums/tradely_enums.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/base/custom_header.dart';
import 'package:tradelog_flutter/src/ui/base/custom_row_trades.dart';
import 'package:tradelog_flutter/src/ui/base/generic_list_view_trades.dart';
import 'package:tradelog_flutter/src/ui/buttons/filter_trades_button.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/list/header_row_item.dart';
import 'package:tradelog_flutter/src/ui/list/text_profit_loss.dart';
import 'package:tradelog_flutter/src/ui/list/text_row_item.dart';
import 'package:tradelog_flutter/src/ui/list/trend_row_item.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class MyTradesScreen extends StatefulWidget {
  MyTradesScreen({super.key});

  final allRows = List.generate(20, (int index) {
    return const CustomRow(
      horizontalPadding: 20,
      rowItems: [
        TextRowItem(
          text: '14:23:05',
          flex: 1,
        ),
        TextRowItem(
          text: 'EURJPY',
          flex: 1,
        ),
        TrendRowItem(
          short: true,
          flex: 1,
        ),
        TextRowItem(
          text: 'Closed',
          flex: 1,
        ),
        TextProfitLoss(
          text: '\$8,37',
          short: true,
          flex: 1,
        ),
        TextRowItem(
          text: '2.25%',
          flex: 1,
        ),
      ],
    );
  });

  static const String route = '/$location';
  static const String location = 'my_trades';

  @override
  State<MyTradesScreen> createState() => _MyTradesScreenState();
}

class _MyTradesScreenState extends State<MyTradesScreen> with ScreenStateMixin {
  TradeType tradeTypeFilter = TradeType.short;

  List<DisplayTrade> trades = [];

  void onUpdateTradeType(TradeType type) {
    setState(() {
      tradeTypeFilter = type;
    });
  }

  // @override
  // Future<void> loadData() async {
  //   trades = await client.tradeLocker.getTrades(accountId, accNum);
  //
  //   return super.loadData();
  // }

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
      child: BaseContainer(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GenericListView(
                header: const CustomHeader(
                  horizontalPadding: 20,
                  children: [
                    HeaderRowItem(
                      flex: 1,
                      text: 'Open Time',
                    ),
                    HeaderRowItem(
                      flex: 1,
                      text: 'Symbol',
                    ),
                    HeaderRowItem(
                      flex: 1,
                      text: 'Direction',
                    ),
                    HeaderRowItem(
                      flex: 1,
                      text: 'Status',
                    ),
                    HeaderRowItem(
                      flex: 1,
                      text: 'Net P/L',
                    ),
                    HeaderRowItem(
                      flex: 1,
                      text: 'Net ROI %',
                    ),
                  ],
                ),
                rows: widget.allRows,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
