import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_list_item_dto.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_date_time_utils.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/ui/base/custom_header.dart';
import 'package:tradelog_flutter/src/ui/base/custom_row_trades.dart';
import 'package:tradelog_flutter/src/ui/base/generic_list_view_trades.dart';
import 'package:tradelog_flutter/src/ui/list/header_row_item.dart';
import 'package:tradelog_flutter/src/ui/list/text_profit_loss.dart';
import 'package:tradelog_flutter/src/ui/list/text_row_item.dart';
import 'package:tradelog_flutter/src/ui/list/trend_row_item.dart';

class TradeList extends StatelessWidget {
  final bool loading;

  final List<TradeListItemDto> trades;

  final double sidePadding;

  const TradeList({
    super.key,
    required this.loading,
    required this.trades,
    this.sidePadding = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GenericListView(
      loading: loading,
      header: CustomHeader(
        horizontalPadding: sidePadding,
        children: const [
          HeaderRowItem(
            flex: 1,
            text: 'Open Time',
          ),
          HeaderRowItem(
            flex: 1,
            text: 'Close Time',
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
            text: 'Lot Size',
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
              horizontalPadding: sidePadding,
              rowItems: [
                TextRowItem(
                  text: TradelyDateTimeUtils.toReadableTime(
                    trade.openTime,
                    true,
                  ),
                  flex: 1,
                ),
                TextRowItem(
                  text: TradelyDateTimeUtils.toReadableTime(
                    trade.closeTime,
                    true,
                  ),
                  flex: 1,
                ),
                TextRowItem(
                  text: trade.symbol ?? '-',
                  flex: 1,
                ),
                TrendRowItem(
                  option: trade.option,
                  flex: 1,
                ),
                TextRowItem(
                  text: trade.quantity?.toStringAsFixed(2) ?? "",
                  flex: 1,
                ),
                TextProfitLoss(
                  text: TradelyNumberUtils.formatNullableValuta(trade.profit),
                  short: (trade.profit == null) || (trade.profit == 0)
                      ? null
                      : (trade.profit! < 0),
                  flex: 1,
                ),
                TextProfitLoss(
                  text: "%${trade.gain?.abs().toStringAsFixed(2) ?? "-"}",
                  short: (trade.profit == null) || (trade.profit == 0)
                      ? null
                      : (trade.profit! < 0),
                  flex: 1,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
