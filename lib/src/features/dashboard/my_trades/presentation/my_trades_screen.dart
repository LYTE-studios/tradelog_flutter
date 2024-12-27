import 'package:flutter/material.dart';
import 'package:to_csv/to_csv.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_list_item_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/enums/trade_enums.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_date_time_utils.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
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
import 'package:tradelog_flutter/src/ui/list/trade_list.dart';
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
  TradeOption tradeTypeFilter = TradeOption.short;

  List<TradeListItemDto> trades = [];

  Future<void> downloadCsv() async {
    await myCSV(
      [
        "Open Time",
        "Symbol",
        "Direction",
        "Profit",
      ],
      trades
          .map(
            (e) => <String>[
              TradelyDateTimeUtils.toReadableTime(
                e.openTime,
                true,
              ),
              e.symbol,
              e.option.toString(),
              e.profit?.toStringAsFixed(2) ?? "",
            ],
          )
          .toList(),
      fileName: "tradely_trade_export_${DateTime.now().millisecondsSinceEpoch}",
      setHeadersInFirstRow: true,
    );
  }

  void onUpdateTradeType(TradeOption type) {
    setState(() {
      tradeTypeFilter = type;
    });
  }

  @override
  Future<void> loadData() async {
    trades = (await UsersService().fetchTrades()).trades;

    setState(() {
      trades = trades;
    });

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "An overview of your trading history.",
        icon: TradelyIcons.myTrades,
        currentRoute: MyTradesScreen.location,
        title: "My trades",
        titleIconPath: 'assets/images/emojis/chart_emoji.png',
        buttons: Row(
          children: [
            PrimaryButton(
              color: Theme.of(context).colorScheme.primaryContainer,
              padding: EdgeInsets.zero,
              prefixIconPadding: EdgeInsets.zero,
              align: MainAxisAlignment.center,
              prefixIcon: TradelyIcons.refresh,
              onTap: () async {
                setLoading(true);

                try {
                  await UsersService().refreshAccount();
                } catch (e) {}

                await loadData();

                setLoading(false);
              },
              height: 42,
              width: 42,
            ),
            const SizedBox(
              width: PaddingSizes.medium,
            ),
            PrimaryButton(
              onTap: () {
                downloadCsv();
              },
              height: 42,
              text: "Export list",
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            const SizedBox(
              width: PaddingSizes.medium,
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
        height: MediaQuery.of(context).size.height * .73,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TradeList(
                loading: loading,
                trades: trades,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
