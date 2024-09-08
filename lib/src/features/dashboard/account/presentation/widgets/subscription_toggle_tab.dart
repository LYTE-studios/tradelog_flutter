import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/data/enum/tradely_pro_enums.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

// I yoinked this from
// https://pub.dev/packages/appinio_animated_toggle_tab/example
// and modified it so it could handle the custom text
class SubscriptionToggleTab extends StatefulWidget {
  /// function(int) for call back and control the view of tabs
  final Function(ProFrequency) callback;

  /// style of text when active
  final TextStyle activeStyle;

  /// style of text when inactive
  final TextStyle inactiveStyle;

  /// height of the tab
  final double height;

  /// the decoration of animated box used to toggle
  final BoxDecoration animatedBoxDecoration;

  /// width of the tab
  final double width;

  final int initialIndex;

  const SubscriptionToggleTab({
    Key? key,
    required this.callback,
    required this.height,
    required this.animatedBoxDecoration,
    required this.activeStyle,
    required this.inactiveStyle,
    required this.width,
    this.initialIndex = 0,
  }) : super(key: key);

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          child: Container(
            width: (widget.width / 2),
            height: widget.height * 0.8,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(
                BorderRadii.large,
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  selectedFrequency = ProFrequency.monthly;
                  widget.callback(selectedFrequency);
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: widget.width / 2,
                height: widget.height,
                child: Text(
                  "Monthly",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: TextStyles.titleColor),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  selectedFrequency = ProFrequency.yearly;
                  widget.callback(selectedFrequency);
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: widget.width / 2,
                height: widget.height,
                child: Row(
                  children: [
                    Text(
                      "Yearly",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: TextStyles.titleColor),
                    ),
                    SvgIcon(
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

  /// building and returning one item of the tab
  Widget _buildSwitchTab(
    String title,
    TextStyle style,
    int i,
    ProFrequency frequency,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          selectedFrequency = frequency;
          index = i;
          //widget.callback(i);
        });
      },
      child: Container(
          alignment: Alignment.center,
          width: widget.width / 2,
          height: widget.height,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: style,
          )),
    );
  }
}
