import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class LineProgressBar extends StatelessWidget {
  final double progressRed; // Percentage of red (0.0 - 1.0)
  final double progressGreen; // Percentage of green (0.0 - 1.0)

  const LineProgressBar({
    Key? key,
    required this.progressRed,
    required this.progressGreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1, // Height of the progress bar
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 63, 211, 186), // Background color
        borderRadius: BorderRadius.circular(
            BorderRadii.medium), // Convert double to BorderRadius
      ),
      child: Row(
        children: [
          // Red Portion
          Flexible(
            flex: (progressRed * 100).toInt(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.horizontal(
                  left: const Radius.circular(BorderRadii.medium),
                  right: progressGreen != 0
                      ? const Radius.circular(BorderRadii.medium)
                      : Radius.zero, // Round if no green
                ),
              ),
            ),
          ),
          // Green Portion
          Flexible(
            flex: (progressGreen * 100).toInt(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 63, 211, 186),
                borderRadius: BorderRadius.horizontal(
                  left: progressRed == 0
                      ? const Radius.circular(BorderRadii.medium)
                      : const Radius.circular(
                          BorderRadii.medium), // Round if no red
                  right: const Radius.circular(BorderRadii.medium),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
