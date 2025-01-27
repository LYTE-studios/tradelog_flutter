import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/line_progress_bar.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ProgressDataContainer extends StatelessWidget {
  final String title;

  final String toolTip;

  final String? valueFormatter;

  final double? value;

  final double? profit;

  final double? loss;

  final bool loading;

  const ProgressDataContainer({
    super.key,
    required this.title,
    required this.toolTip,
    this.value,
    this.valueFormatter,
    this.loading = false,
    this.profit,
    this.loss,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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
          // This will scale the text based on the screen size.
          // Maybe not the best idea?
          // it overwrites the TextSize
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: PaddingSizes.extraSmall,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 36,
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      children: [
                        Text(
                          (valueFormatter ?? "") +
                              (value?.toStringAsFixed(2) ?? "-"),
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 16, // Fixed height for the container
            alignment: Alignment.center, // Center the child vertically
            child: Transform.translate(
              offset: const Offset(0, 4),
              child: LineProgressBar(
                progressRed: loss ?? .01,
                progressGreen: profit ?? .01,
              ),
            ),
          ),
          const SizedBox(
            width: PaddingSizes.medium,
          ),
        ],
      ),
    );
  }
}
