import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_date_time_utils.dart';
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
  const MyTradesScreen({super.key});

  static const String route = '/$location';
  static const String location = 'my_trades';

  @override
  State<MyTradesScreen> createState() => _MyTradesScreenState();
}

class _MyTradesScreenState extends State<MyTradesScreen> with ScreenStateMixin {
  Option tradeTypeFilter = Option.short;

  List<TradeDto> trades = [];

  void onUpdateTradeType(Option type) {
    setState(() {
      tradeTypeFilter = type;
    });
  }

  @override
  Future<void> loadData() async {
    trades = await client.global.getTrades();

    setState(() {
      trades = trades;
    });

    return super.loadData();
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
              tradeStatusFilter: TradeStatus.open,
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
                  horizontalPadding: 40,
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
                rows: trades
                    .map(
                      (trade) => CustomRow(
                        horizontalPadding: 40,
                        rowItems: [
                          TextRowItem(
                            text: TradelyDateTimeUtils.toReadableTime(
                              trade.openTime,
                              true,
                            ),
                            flex: 1,
                          ),
                          TextRowItem(
                            text: trade.symbol,
                            flex: 1,
                          ),
                          TrendRowItem(
                            option: trade.option,
                            flex: 1,
                          ),
                          TextRowItem(
                            text: trade.status.name,
                            flex: 1,
                          ),
                          TextProfitLoss(
                            text:
                                "\$${trade.realizedPl?.abs().toStringAsFixed(2) ?? "-"}",
                            short: (trade.realizedPl == null) ||
                                    (trade.realizedPl == 0)
                                ? null
                                : (trade.realizedPl! < 0),
                            flex: 1,
                          ),
                          TextProfitLoss(
                            text:
                                "%${trade.netRoi?.abs().toStringAsFixed(2) ?? "-"}",
                            short: (trade.netRoi == null) || (trade.netRoi == 0)
                                ? null
                                : (trade.netRoi! < 0),
                            flex: 1,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
