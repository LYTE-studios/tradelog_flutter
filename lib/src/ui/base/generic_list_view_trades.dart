import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/custom_row_trades.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_switcher.dart';

class GenericListView extends StatelessWidget {
  final Widget header;
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Display header
        header,
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: TradelyLoadingSwitcher(
            loading: loading,
            child: Column(
              children: [
                for (int i = 0; i < rows.length; i++) ...[
                  _HoverRowWrapper(child: rows[i]),
                  if (i < rows.length - 1)
                    const Divider(
                      color: Color(0xFF15161E),
                    ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HoverRowWrapper extends StatefulWidget {
  final Widget child;
  const _HoverRowWrapper({required this.child});

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
        // No extra padding so that the hover background is constrained to this row.
        decoration: BoxDecoration(
          color: _isHovered
              ? Theme.of(context).colorScheme.secondaryContainer.withOpacity(.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: widget.child,
      ),
    );
  }
}
