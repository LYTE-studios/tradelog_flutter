import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
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
        // Removed Expanded to allow the container to expand naturally with its content.
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: TradelyLoadingSwitcher(
            loading: loading,
            child: Column(
              children:
                  rows.map((row) => _HoverRowWrapper(child: row)).toList(),
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
        color: _isHovered
            ? Theme.of(context).colorScheme.secondaryContainer.withOpacity(.2)
            : null,
        child: widget.child,
      ),
    );
  }
}
