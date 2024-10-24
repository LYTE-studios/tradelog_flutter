import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/custom_header.dart';
import 'package:tradelog_flutter/src/ui/base/custom_row_trades.dart';

class GenericListView extends StatelessWidget {
  final CustomHeader header;
  final List<CustomRow> rows;
  final bool showFooter;

  final ScrollController _scrollController = ScrollController();

  GenericListView({
    required this.header,
    required this.rows,
    this.showFooter = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display header
        header,
        Expanded(
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
      ],
    );
  }
}
