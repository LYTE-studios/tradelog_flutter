import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class LineProgressBar extends StatefulWidget {
  /// Percentage of red (0.0 - 1.0)
  final double progressRed;

  /// Percentage of green (0.0 - 1.0)
  final double progressGreen;

  const LineProgressBar({
    super.key,
    required this.progressRed,
    required this.progressGreen,
  });

  static const double _selectedHeight = 10;

  static const double _unselectedHeight = 8;

  @override
  State<LineProgressBar> createState() => _LineProgressBarState();
}

class _LineProgressBarState extends State<LineProgressBar> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BorderRadii.medium),
      ),
      child: Row(
        children: [
          Flexible(
            flex: (widget.progressGreen * 100).toInt().abs(),
            child: Tooltip(
              verticalOffset: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  BorderRadii.extraSmall,
                ),
                color: HexColor.fromHex('#14D39F'),
              ),
              preferBelow: false,
              textStyle: TextStyles.bodySmall.copyWith(
                color: TextStyles.titleColor,
                fontSize: 12,
              ),
              message:
                  TradelyNumberUtils.formatNullableValuta(widget.progressGreen),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onExit: (_) {
                  setState(() {
                    selectedIndex = null;
                  });
                },
                onEnter: (_) {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: Container(
                  height: selectedIndex == 0
                      ? LineProgressBar._selectedHeight
                      : LineProgressBar._unselectedHeight,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 63, 211, 186),
                    borderRadius: BorderRadius.horizontal(
                      right: widget.progressRed == 0
                          ? const Radius.circular(BorderRadii.medium)
                          : Radius.zero, // Round if no red
                      left: const Radius.circular(BorderRadii.medium),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: (widget.progressRed * 100).toInt().abs(),
            child: Tooltip(
              verticalOffset: 12,
              textStyle: TextStyles.bodySmall.copyWith(
                color: TextStyles.titleColor,
                fontSize: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  BorderRadii.extraSmall,
                ),
                color: HexColor.fromHex('#E13232'),
              ),
              preferBelow: false,
              message:
                  TradelyNumberUtils.formatNullableValuta(widget.progressRed),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onExit: (_) {
                  setState(() {
                    selectedIndex = null;
                  });
                },
                onEnter: (_) {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Container(
                  height: selectedIndex == 1
                      ? LineProgressBar._selectedHeight
                      : LineProgressBar._unselectedHeight,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.horizontal(
                      right: const Radius.circular(BorderRadii.medium),
                      left: widget.progressGreen == 0
                          ? const Radius.circular(BorderRadii.medium)
                          : Radius.zero,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
