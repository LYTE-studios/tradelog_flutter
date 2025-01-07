import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/data/models/enums/trade_enums.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/dialogs/filter_trades_dialog.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class FilterTradesButton extends StatefulWidget {
  final Function() onTap;
  final double height;
  final String? text;
  final String? prefixIcon;
  final bool? leaveIconUnaltered;
  // final TradeStatus tradeStatusFilter;
  // final TradeOption tradeTypeFilter;
  // final Function(TradeOption) onUpdateTradeTypeFilter;
  // final Function(TradeStatus) onUpdateTradeStatusFilter;
  final DateTime? from;
  final DateTime? to;
  final Function(DateTime, DateTime)? onUpdateDateFilter;
  final Function() onResetFilters;
  final Function() onShowTrades;

  const FilterTradesButton({
    super.key,
    required this.onTap,
    required this.height,
    this.text,
    this.prefixIcon,
    this.leaveIconUnaltered,
    this.from,
    this.to,
    required this.onResetFilters,
    required this.onShowTrades,
    this.onUpdateDateFilter,
  });

  @override
  State<FilterTradesButton> createState() => _FilterTradesButtonState();
}

class _FilterTradesButtonState extends State<FilterTradesButton> {
  TradeOption tradeTypeFilter = TradeOption.long;
  TradeStatus tradeStatusFilter = TradeStatus.open;

  OverlayEntry? _overlayEntry;

  // Method to create the OverlayEntry (dialog)
  OverlayEntry _createOverlayEntry() {
    print("render");
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size; // size of the button
    var offset = renderBox.localToGlobal(Offset.zero);
    double width = MediaQuery.sizeOf(context).width;

    return OverlayEntry(
      builder: (context) => Positioned(
        right: width - offset.dx - size.width,
        top: offset.dy + widget.height + PaddingSizes.large,
        child: BaseContainer(
          height: 520,
          width: 520,
          child: FilterTradesDialog(
            from: widget.from,
            to: widget.to,
            onResetFilters: widget.onResetFilters,
            onUpdateDateFilter: widget.onUpdateDateFilter,
            onShowTrades: () {
              _hideOverlay();
              widget.onShowTrades.call();
            },
          ),
        ),
      ),
    );
  }

  // void onUpdateTradeStatus(TradeStatus type) {
  //   setState(() {
  //     tradeStatusFilter = type;
  //     widget.onUpdateTradeStatusFilter(type);
  //     _hideOverlay();
  //     _showOverlay();
  //   });
  // }

  // void onUpdateTradeType(TradeOption type) {
  //   setState(() {
  //     tradeTypeFilter = type;
  //     widget.onUpdateTradeTypeFilter(type);
  //     _hideOverlay();
  //     _showOverlay();
  //   });
  // }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onTap: _toggleOverlay,
      height: widget.height,
      text: widget.text,
      prefixIcon: widget.prefixIcon,
    );
  }
}
