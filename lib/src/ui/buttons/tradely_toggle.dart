import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class TradelyToggle extends StatelessWidget {
  final int selectedItem;

  /// function(int) for call back and control the view of tabs
  final Function(int) onToggle;

  /// height of the tab
  final double height;

  /// width of the tab
  final double width;

  final List<Color>? colors;

  final List<String> labels;

  const TradelyToggle({
    super.key,
    this.selectedItem = 0,
    required this.onToggle,
    required this.height,
    required this.width,
    this.colors,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    if (colors != null) {
      assert(colors!.length == 2);
    }

    assert(labels.length == 2);

    return Container(
      constraints: BoxConstraints(
        maxWidth: width,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(
          BorderRadii.large,
        ),
      ),
      child: Stack(children: [
        AnimatedAlign(
          alignment: Alignment(selectedItem == 0 ? -1 : 1, 0),
          curve: Curves.fastEaseInToSlowEaseOut,
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingSizes.xxs,
            ),
            child: Container(
              width: width / 2,
              height: height * 0.8,
              decoration: BoxDecoration(
                color: colors == null
                    ? const Color(0xFF3B3B3B)
                    : colors![selectedItem],
                borderRadius: BorderRadius.circular(
                  BorderRadii.medium,
                ),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => onToggle.call(0),
                child: Container(
                  alignment: Alignment.center,
                  width: width / 2,
                  height: height,
                  child: Text(
                    labels[0],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: selectedItem == 0
                              ? TextStyles.titleColor // Default selected color
                              : const Color(
                                  0xFF919191,
                                ), // Color for unselected option,
                        ),
                  ),
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => onToggle.call(1),
                child: Container(
                  alignment: Alignment.center,
                  width: width / 2,
                  height: height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        labels[1],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: selectedItem == 1
                                  ? TextStyles
                                      .titleColor // Default selected color
                                  : const Color(
                                      0xFF919191,
                                    ), // Color for unselected option,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
