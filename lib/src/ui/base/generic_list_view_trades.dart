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
                  // Alternate row background color based on index (even/odd)
                  final Color rowColor = index.isOdd
                      ? const Color(0xFF111111)
                      : const Color(0xFF1A1A1A);

                  return Container(
                    color: rowColor,
                    child: rows[index],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
