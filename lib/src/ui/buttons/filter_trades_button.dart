import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/dialogs/filter_trades_dialog.dart';

class FilterTradesButton extends StatefulWidget {
  final Function() onTap;
  final double height;
  final String? text;
  final String? prefixIcon;
  final bool? leaveIconUnaltered;
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
  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    double width = MediaQuery.sizeOf(context).width;

    return OverlayEntry(
      builder: (context) => Positioned(
        right: width - offset.dx - size.width,
        top: offset.dy + widget.height + PaddingSizes.large,
        child: Material(
          // Added Material widget for proper elevation
          elevation: 8,
          color: Colors.transparent,
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
