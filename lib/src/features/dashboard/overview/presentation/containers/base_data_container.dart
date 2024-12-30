import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseDataContainer extends StatelessWidget {
  final String title;

  final String toolTip;

  final Widget child;

  const BaseDataContainer({
    super.key,
    required this.title,
    required this.toolTip,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      padding: const EdgeInsets.all(
        PaddingSizes.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToolTipTitle(
            titleText: title,
            toolTipText: toolTip,
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
