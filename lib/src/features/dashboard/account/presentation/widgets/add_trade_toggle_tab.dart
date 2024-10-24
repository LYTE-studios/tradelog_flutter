import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/enums/tradely_enums.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

// todo move this to the UI package
// I yoinked this from
// https://pub.dev/packages/appinio_animated_toggle_tab/example
// and modified it so it could handle the custom text
class AddTradeToggleTab extends StatefulWidget {
  /// function(int) for call back and control the view of tabs
  final Function(AddTradeType) onToggle;

  /// height of the tab
  final double height;

  /// width of the tab
  final double width;

  final int initialIndex;

  const AddTradeToggleTab({
    super.key,
    required this.onToggle,
    required this.height,
    required this.width,
    this.initialIndex = 0,
  });

  @override
  State<StatefulWidget> createState() => SubscriptionToggleTabState();
}

class SubscriptionToggleTabState extends State<AddTradeToggleTab> {
  late int index;

  AddTradeType selectedType = AddTradeType.manual;

  SubscriptionToggleTabState() : super();

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  void setType(AddTradeType type) {
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
          alignment: Alignment(selectedType == AddTradeType.manual ? -1 : 1, 0),
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
                color: const Color(0xFF3B3B3B),
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
              onTap: () => setType(AddTradeType.manual),
              child: Container(
                alignment: Alignment.center,
                width: widget.width / 2,
                height: widget.height,
                child: Text(
                  "Manual",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: selectedType == AddTradeType.manual
                            ? TextStyles.titleColor // Default selected color
                            : const Color(
                                0xFF919191), // Color for unselected option,
                      ),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setType(AddTradeType.file),
              child: Container(
                alignment: Alignment.center,
                width: widget.width / 2,
                height: widget.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Upload CSV",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: selectedType == AddTradeType.file
                                ? TextStyles
                                    .titleColor // Default selected color
                                : const Color(
                                    0xFF919191), // Color for unselected option,
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
