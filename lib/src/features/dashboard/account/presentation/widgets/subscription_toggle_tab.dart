import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/enums/tradely_enums.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

// todo move this to the UI package
// I yoinked this from
// https://pub.dev/packages/appinio_animated_toggle_tab/example
// and modified it so it could handle the custom text
class SubscriptionToggleTab extends StatefulWidget {
  /// function(int) for call back and control the view of tabs
  final Function(ProFrequency) onToggle;

  /// height of the tab
  final double height;

  /// width of the tab
  final double width;

  final int initialIndex;

  const SubscriptionToggleTab({
    super.key,
    required this.onToggle,
    required this.height,
    required this.width,
    this.initialIndex = 0,
  });

  @override
  State<StatefulWidget> createState() => _SubscriptionToggleTabState();
}

class _SubscriptionToggleTabState extends State<SubscriptionToggleTab> {
  late int index;

  ProFrequency selectedFrequency = ProFrequency.monthly;

  _SubscriptionToggleTabState() : super();

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  void setFrequency(ProFrequency frequency) {
    setState(() {
      selectedFrequency = frequency;
      widget.onToggle(selectedFrequency);
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
          alignment:
              Alignment(selectedFrequency == ProFrequency.monthly ? -1 : 1, 0),
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingSizes.xxs,
            ),
            child: Container(
              width: (widget.width / 2),
              height: widget.height * 0.8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
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
              onTap: () => setFrequency(ProFrequency.monthly),
              child: Container(
                alignment: Alignment.center,
                width: widget.width / 2,
                height: widget.height,
                child: Text(
                  "Monthly",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: TextStyles.titleColor,
                      ),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setFrequency(ProFrequency.yearly),
              child: Container(
                alignment: Alignment.center,
                width: widget.width / 2,
                height: widget.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Yearly",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: TextStyles.titleColor),
                    ),
                    const SizedBox(
                      width: PaddingSizes.xxs,
                    ),
                    const SvgIcon(
                      size: 25,
                      TradelyIcons.save30,
                      leaveUnaltered: true,
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
