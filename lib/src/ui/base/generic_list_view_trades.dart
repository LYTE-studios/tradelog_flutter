import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/custom_header.dart';
import 'package:tradelog_flutter/src/ui/base/custom_row_trades.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_switcher.dart';

class GenericListView extends StatelessWidget {
  final CustomHeader header;
  final List<CustomRow> rows;
  final bool showFooter;

  final ScrollController _scrollController = ScrollController();

  final bool loading;

  GenericListView({
    required this.header,
    required this.rows,
    this.showFooter = false,
    required this.loading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display header
        header,
        Expanded(
          child: TradelyLoadingSwitcher(
            loading: loading,
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: rows.length,
                itemBuilder: (context, index) {
                  return _HoverRowWrapper(child: rows[index]);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HoverRowWrapper extends StatefulWidget {
  final Widget child;
  const _HoverRowWrapper({required this.child, Key? key}) : super(key: key);

  @override
  State<_HoverRowWrapper> createState() => _HoverRowWrapperState();
}

class _HoverRowWrapperState extends State<_HoverRowWrapper> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        color: !_isHovered ? const Color(0xFF111111) : Colors.transparent,
        child: widget.child,
      ),
    );
  }
}
