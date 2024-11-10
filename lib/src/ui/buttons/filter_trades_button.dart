import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
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
  final TradeStatus tradeStatusFilter;
  final Option tradeTypeFilter;
  final Function(Option) onUpdateTradeTypeFilter;
  final Function(TradeStatus) onUpdateTradeStatusFilter;
  final Function() onResetFilters;
  final Function() onShowTrades;

  const FilterTradesButton({
    super.key,
    required this.onTap,
    required this.height,
    this.text,
    this.prefixIcon,
    this.leaveIconUnaltered,
    required this.tradeStatusFilter,
    required this.tradeTypeFilter,
    required this.onUpdateTradeTypeFilter,
    required this.onUpdateTradeStatusFilter,
    required this.onResetFilters,
    required this.onShowTrades,
  });

  @override
  State<FilterTradesButton> createState() => _FilterTradesButtonState();
}

class _FilterTradesButtonState extends State<FilterTradesButton> {
  Option tradeTypeFilter = Option.long;
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          height: 640,
          width: 520,
          child: FilterTradesDialog(
            tradeTypeFilter: tradeTypeFilter,
            tradeStatusFilter: tradeStatusFilter,
            onResetFilters: widget.onResetFilters,
            onUpdateTradeTypeFilter: onUpdateTradeType,
            onUpdateTradeStatusFilter: onUpdateTradeStatus,
            onShowTrades: widget.onShowTrades,
          ),
        ),
      ),
    );
  }

  void onUpdateTradeStatus(TradeStatus type) {
    setState(() {
      print("here zazaza");
      tradeStatusFilter = type;
      widget.onUpdateTradeStatusFilter(type);
      _hideOverlay();
      _showOverlay();
    });
  }

  void onUpdateTradeType(Option type) {
    setState(() {
      print("here zazaza");
      tradeTypeFilter = type;
      widget.onUpdateTradeTypeFilter(type);
      _hideOverlay();
      _showOverlay();
    });
  }

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
  void initState() {
    tradeTypeFilter = widget.tradeTypeFilter;
    super.initState();
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
