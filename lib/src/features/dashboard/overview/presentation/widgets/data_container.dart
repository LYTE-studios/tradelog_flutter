import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';

class DataContainer extends StatelessWidget {
  final String title;

  final String toolTip;

  final String? data;

  final bool up;

  final int? percentage;

  const DataContainer({
    super.key,
    required this.title,
    required this.toolTip,
    this.data,
    this.up = true,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ToolTipTitle(
            titleText: title,
            toolTipText: toolTip,
          ),
          Text(data ?? ""),
          Text(
            "% vs last month",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
