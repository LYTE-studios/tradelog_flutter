import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
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

  DateTime? from;
  DateTime? to;

  Future<void> downloadCsv() async {
    await myCSV(
      [
        "Open Time",
        "Close Time",
        "Symbol",
        "Direction",
        "Profit",
        "ROI",
      ],
      trades
          .map(
            (e) => <String>[
              TradelyDateTimeUtils.toReadableTime(
                e.openTime,
                true,
              ),
              TradelyDateTimeUtils.toReadableTime(
                e.closeTime,
                true,
              ),
              e.symbol ?? '-',
              e.option.name,
              TradelyNumberUtils.formatNullableValuta(e.profit),
              e.gain?.toStringAsFixed(2) ?? "",
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
    trades = (await UsersService().fetchTrades(from: from, to: to)).trades;

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
        subHeader: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Trades',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: PaddingSizes.extraSmall / 3,
                ),
                Row(
                  children: [
                    Text(
                      r"$Loss/Profit",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: HexColor.fromHex('#7C7C7C'),
                      ),
                      onPressed: () async {
                        setLoading(true);

                        await UsersService().refreshAccount();

                        await loadData();

                        setLoading(false);
                      },
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PrimaryButton(
                  height: 42,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: BaseContainer(
                          height: MediaQuery.of(context).size.height * .73,
                          padding: const EdgeInsets.only(top: 10),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
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
                      ),
                    );
                  },
                  suffixIcon: TradelyIcons.fullScreenIcon,
                  padding: const EdgeInsets.all(5),
                  suffixIconSize: 35,
                  suffixIconColor: const Color(0xFF898989),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                const SizedBox(
                  width: PaddingSizes.medium,
                ),
                PrimaryButton(
                  onTap: () {},
                  height: 42,
                  suffixIconPadding: const EdgeInsets.only(left: 12.0),
                  text: "Trade Type",
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  textStyle: const TextStyle(
                    color: Color(0xFF898989),
                    fontSize: 16,
                  ),
                  suffixIcon: TradelyIcons.chevronDown,
                  suffixIconSize: 8,
                  suffixIconColor: const Color(0xFF898989),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                const SizedBox(
                  width: PaddingSizes.medium,
                ),
                PrimaryButton(
                  onTap: () {
                    downloadCsv();
                  },
                  suffixIconPadding: const EdgeInsets.only(left: 10.0),
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  text: "Export",
                  textStyle: const TextStyle(
                    color: Color(0xFF898989),
                    fontSize: 16,
                  ),
                  suffixIconSize: 20,
                  suffixIcon: TradelyIcons.chevronRight,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  suffixIconColor: const Color(0xFF898989),
                ),
              ],
            )
          ],
        ),
      ),
      child: BaseContainer(
        height: MediaQuery.of(context).size.height * .73,
        padding: const EdgeInsets.only(top: 10),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
