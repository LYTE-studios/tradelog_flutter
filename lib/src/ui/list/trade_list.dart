import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_list_item_dto.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_date_time_utils.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/ui/base/custom_header.dart';
import 'package:tradelog_flutter/src/ui/base/custom_row_trades.dart';
import 'package:tradelog_flutter/src/ui/base/generic_list_view_trades.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/list/text_profit_loss.dart';
import 'package:tradelog_flutter/src/ui/list/text_row_item.dart';
import 'package:tradelog_flutter/src/ui/list/trend_row_item.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class TradeList extends StatefulWidget {
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
  State<TradeList> createState() => _TradeListState();
}

class _TradeListState extends State<TradeList> {
  final List<_HeaderDefinition> _headers = [
    _HeaderDefinition(label: 'Open Time', icon: TradelyIcons.multiDropdown),
    _HeaderDefinition(label: 'Close Time', icon: TradelyIcons.multiDropdown),
    _HeaderDefinition(label: 'Symbol', icon: TradelyIcons.multiDropdown),
    _HeaderDefinition(label: 'Direction', icon: TradelyIcons.multiDropdown),
    _HeaderDefinition(label: 'Lot Size', icon: TradelyIcons.multiDropdown),
    _HeaderDefinition(label: 'Net P/L', icon: TradelyIcons.multiDropdown),
    _HeaderDefinition(label: 'Net ROI %', icon: TradelyIcons.multiDropdown),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GenericListView(
        loading: widget.loading,
        header: CustomHeader(
          horizontalPadding: widget.sidePadding,
          children: [
            SizedBox(
              height: double.infinity,
              child: ReorderableListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final item = _headers.removeAt(oldIndex);
                    _headers.insert(newIndex, item);
                  });
                },
                buildDefaultDragHandles: false,
                children: _headers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final headerDef = entry.value;
                  return ReorderableDragStartListener(
                    key: ValueKey(headerDef.label),
                    index: index,
                    child: SizedBox(
                      width:
                          (constraints.maxWidth - (widget.sidePadding + 24)) /
                              _headers.length,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            headerDef.label,
                            textAlign: TextAlign.left,
                            style: TextStyles.titleSmall.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFA2A2AA),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SvgIcon(
                            headerDef.icon!,
                            size: 15,
                            color: const Color(0xFFA2A2AA),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        rows: widget.trades.map((trade) {
          final rowItems = _headers.map((headerDef) {
            switch (headerDef.label) {
              case 'Open Time':
                return TextRowItem(
                  text:
                      TradelyDateTimeUtils.toReadableTime(trade.openTime, true),
                  flex: 1,
                );
              case 'Close Time':
                return TextRowItem(
                  text: TradelyDateTimeUtils.toReadableTime(
                      trade.closeTime, true),
                  flex: 1,
                );
              case 'Symbol':
                return TextRowItem(
                  text: trade.symbol ?? '-',
                  flex: 1,
                  showFlags: true,
                );
              case 'Direction':
                return TrendRowItem(
                  option: trade.option,
                  flex: 1,
                );
              case 'Lot Size':
                return TextRowItem(
                  text: trade.quantity?.toStringAsFixed(2) ?? "",
                  flex: 1,
                );
              case 'Net P/L':
                return TextProfitLoss(
                  text: TradelyNumberUtils.formatNullableValuta(trade.profit),
                  short: (trade.profit == null || trade.profit == 0)
                      ? null
                      : (trade.profit! < 0),
                  flex: 1,
                );
              case 'Net ROI %':
                return TextProfitLoss(
                  text: "%${trade.gain?.abs().toStringAsFixed(2) ?? "-"}",
                  short: (trade.profit == null || trade.profit == 0)
                      ? null
                      : (trade.profit! < 0),
                  flex: 1,
                );
              default:
                return const SizedBox.shrink();
            }
          }).toList();

          return CustomRow(
            horizontalPadding: widget.sidePadding,
            rowItems: rowItems,
          );
        }).toList(),
      );
    });
  }
}

class _HeaderDefinition {
  final String label;
  final String? icon;
  _HeaderDefinition({required this.label, this.icon});
}
