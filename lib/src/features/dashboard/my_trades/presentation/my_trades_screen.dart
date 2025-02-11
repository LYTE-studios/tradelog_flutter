import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:to_csv/to_csv.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_list_item_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/enums/trade_enums.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_date_time_utils.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/calender_widget.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/image_overlay.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/list/trade_list.dart';
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
        currentRoute: MyTradesScreen.location,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConnectedAccountsWidget(
              accounts: [
                {
                  'image': TradelyIcons.tradelocker,
                  'backgroundColor': Colors.transparent,
                },
                {
                  'image': TradelyIcons.metatrader,
                  'backgroundColor': Color(0xFF272835),
                },
                {
                  'image': TradelyIcons.metatrader,
                  'backgroundColor': Color(0xFF272835),
                },
                {
                  'image': TradelyIcons.metatrader,
                  'backgroundColor': Color(0xFF272835),
                },
              ],
              onAddAccount: () {
                print('Add account clicked');
              },
              onMoreOptions: () {
                print('More options clicked');
              },
            ),
            Container(
              width: 1.5,
              height: 42,
              decoration: BoxDecoration(
                color: Color(0xFF272835),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Text(''),
            ),
            SizedBox(width: 20),
            PrimaryButton(
              outlined: true,
              borderColor: Color(0xFF272835),
              onTap: () {},
              prefixIconPadding: EdgeInsets.only(right: 10.0),
              height: 42,
              borderRadii: 12,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              text: "Share",
              textStyle: const TextStyle(
                color: Color(0xFF666D80),
                fontSize: 16,
              ),
              prefixIconSize: 16,
              prefixIcon: TradelyIcons.share,
              color: Theme.of(context).colorScheme.primaryContainer,
              prefixIconColor: Color(0xFF666D80),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF272835), width: 1),
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                TradelyIcons.menu,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  Color(0xFF666D80),
                  BlendMode.srcIn,
                ),
              ),
            )
          ],
        ),
        title: "Dashboard",
        subHeader: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CalenderWidget(),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Total Trades',
            //       style: Theme.of(context).textTheme.titleMedium,
            //     ),
            //     const SizedBox(
            //       height: PaddingSizes.extraSmall / 3,
            //     ),
            //     Row(
            //       children: [
            //         Text(
            //           r"$Loss/Profit",
            //           style: Theme.of(context).textTheme.titleLarge,
            //         ),
            //         IconButton(
            //           icon: Icon(
            //             Icons.refresh,
            //             color: HexColor.fromHex('#7C7C7C'),
            //           ),
            //           onPressed: () async {
            //             setLoading(true);

            //             await UsersService().refreshAccount();

            //             await loadData();

            //             setLoading(false);
            //           },
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PrimaryButton(
                  outlined: true,
                  borderColor: Color(0xFF272835),
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
                  padding: EdgeInsets.all(5),
                  suffixIconSize: 35,
                  suffixIconColor: Color(0xFF666D80),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                const SizedBox(
                  width: PaddingSizes.medium,
                ),
                PrimaryButton(
                  outlined: true,
                  borderColor: Color(0xFF272835),
                  prefixIcon: TradelyIcons.filter,
                  prefixIconColor: Color(0xFF666D80),
                  prefixIconSize: 13,
                  onTap: () {},
                  height: 42,
                  text: "Filter",
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  textStyle: const TextStyle(
                    color: Color(0xFF666D80),
                    fontSize: 16,
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                const SizedBox(
                  width: PaddingSizes.medium,
                ),
                PrimaryButton(
                  outlined: true,
                  borderColor: Color(0xFF272835),
                  onTap: () {
                    downloadCsv();
                  },
                  prefixIconPadding: EdgeInsets.only(right: 10.0),
                  height: 42,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  text: "Import / Export",
                  textStyle: const TextStyle(
                    color: Color(0xFF666D80),
                    fontSize: 16,
                  ),
                  prefixIconSize: 12,
                  prefixIcon: TradelyIcons.export_icon,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  prefixIconColor: Color(0xFF666D80),
                ),
              ],
            )
          ],
        ),
      ),
      child: BaseContainer(
        height: MediaQuery.of(context).size.height * .73,
        padding: const EdgeInsets.only(top: 0),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        borderColor: Colors.transparent,
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
