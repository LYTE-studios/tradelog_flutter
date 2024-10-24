import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/enums/tradely_enums.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

// todo move this to the UI package
// I yoinked this from
// https://pub.dev/packages/appinio_animated_toggle_tab/example
// and modified it so it could handle the custom text
class BuySellToggleTab extends StatefulWidget {
  /// function(int) for call back and control the view of tabs
  final Function(BuySellType) onToggle;

  /// height of the tab
  final double height;

  /// width of the tab
  final double width;

  final int initialIndex;

  const BuySellToggleTab({
    super.key,
    required this.onToggle,
    required this.height,
    required this.width,
    this.initialIndex = 0,
  });

  @override
  State<StatefulWidget> createState() => BuySellToggleTabState();
}

class BuySellToggleTabState extends State<BuySellToggleTab> {
  late int index;

  BuySellType selectedType = BuySellType.buy;

  BuySellToggleTabState() : super();

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  void setType(BuySellType type) {
    setState(() {
      selectedType = type;
      widget.onToggle(type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: widget.width,
      ),
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(
          BorderRadii.large,
        ),
      ),
      child: Stack(children: [
        AnimatedAlign(
          alignment: Alignment(selectedType == BuySellType.buy ? -1 : 1, 0),
          curve: Curves.fastEaseInToSlowEaseOut,
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingSizes.xxs,
            ),
            child: Container(
              width: (widget.width / 2),
              height: widget.height * 0.8,
              decoration: BoxDecoration(
                color: selectedType == BuySellType.buy
                    ? const Color(0xFF14D39F)
                    : const Color(0xFFF21111),
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
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setType(BuySellType.buy),
              child: Container(
                alignment: Alignment.center,
                width: widget.width / 2,
                height: widget.height,
                child: Text(
                  "Buy",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white, // Color for unselected option,
                      ),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setType(BuySellType.sell),
              child: Container(
                alignment: Alignment.center,
                width: widget.width / 2,
                height: widget.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sell",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white, // Color for unselected option,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
