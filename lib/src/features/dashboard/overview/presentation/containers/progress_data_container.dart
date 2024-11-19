import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/trend_information.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/line_progress_bar.dart';

class ProgressDataContainer extends StatelessWidget {
  final String title;

  final String toolTip;

  final String? valueFormatter;

  final double? value;

  final double? percentage;

  final bool loading;

  const ProgressDataContainer({
    super.key,
    required this.title,
    required this.toolTip,
    this.value,
    this.valueFormatter,
    this.percentage,
    this.loading = false,
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 42,
                ),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Row(children: [
                      Text(
                        (valueFormatter ?? "") +
                            (value?.toStringAsFixed(2) ?? "-"),
                        style: textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Transform.translate(
                          offset: const Offset(90, 30),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white24),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "\$ ${percentage?.toStringAsFixed(2) ?? "-"}", // Ensure proper formatting
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white60),
                            ),
                          ))
                    ])),
              ),
            ),
          ),
          Container(
              height: 30, // Fixed height for the container
              alignment: Alignment.center, // Center the child vertically
              child: Transform.translate(
                  offset: const Offset(0, 4),
                  child: const SizedBox(
                    height:
                        8, // Space between the "Hello" box and the progress bar
                    child: LineProgressBar(
                      progressRed:
                          0.4, // Ensure the percentage is between 0.0 and 1.0
                      progressGreen:
                          0.6, // Ensure the percentage is between 0.0 and 1.0
                    ),
                  )))
        ],
      ),
    );
  }
}
