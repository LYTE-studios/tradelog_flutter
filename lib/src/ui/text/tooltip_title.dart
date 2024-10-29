import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:super_tooltip/super_tooltip.dart'; // Import the package
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class ToolTipTitle extends StatelessWidget {
  final String titleText;
  final String toolTipText;

  const ToolTipTitle({
    super.key,
    required this.titleText,
    required this.toolTipText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TooltipIcon(
          tooltipText: toolTipText,
        ),
        const SizedBox(
          width: PaddingSizes.extraSmall,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 18,
              ),
              child: FittedBox(
                child: Text(
                  titleText,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TooltipIcon extends StatefulWidget {
  final String tooltipText;

  const TooltipIcon({
    super.key,
    required this.tooltipText,
  });

  @override
  State<TooltipIcon> createState() => _TooltipIconState();
}

class _TooltipIconState extends State<TooltipIcon> {
  SuperTooltipController controller = SuperTooltipController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (controller.isVisible) {
          return;
        }
        controller.showTooltip();
      },
      onExit: (_) {
        if (!controller.isVisible) {
          return;
        }
        controller.hideTooltip();
      },
      child: IgnorePointer(
        child: SuperTooltip(
          showBarrier: false,
          hasShadow: false,
          controller: controller,
          borderColor: Theme.of(context).colorScheme.primaryContainer,
          popupDirection: TooltipDirection.up,
          content: SizedBox(
            width: 164,
            child: Text(
              widget.tooltipText,
              softWrap: true,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: SvgIcon(
            TradelyIcons.infoCircle,
            color: TextStyles.mediumTitleColor,
          ),
        ),
      ),
    );
  }
}
