import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:super_tooltip/super_tooltip.dart'; // Import the package
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class ToolTipTitle extends StatelessWidget {
  final String titleText;
  final String toolTipText;
  final bool? isSuffixIcon;
  final bool? isPrefixIcon;
  final bool showTitleText; // Add this parameter

  const ToolTipTitle({
    super.key,
    required this.titleText,
    required this.toolTipText,
    this.isSuffixIcon = false,
    this.isPrefixIcon = true,
    this.showTitleText = true, // Add this parameter with default value
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Added to prevent row expansion
      children: [
        if (isPrefixIcon ?? true) ...[
          TooltipIcon(tooltipText: toolTipText),
          const SizedBox(width: PaddingSizes.extraSmall),
        ],
        if (showTitleText) // Add condition for showing title text
          Expanded(
            child: Text(
              titleText,
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis, // Added to handle text overflow
            ),
          ),
        if (isSuffixIcon ?? false) ...[
          const SizedBox(width: PaddingSizes.extraSmall),
          TooltipIcon(tooltipText: toolTipText),
        ],
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
      hitTestBehavior: HitTestBehavior.translucent,
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        verticalOffset: 12,
        preferBelow: true,
        padding: const EdgeInsets.symmetric(
          horizontal: PaddingSizes.medium,
          vertical: PaddingSizes.small,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(BorderRadii.small),
        ),
        richMessage: WidgetSpan(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 156),
            child: Text(
              widget.tooltipText,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
              softWrap: true,
            ),
          ),
        ),
        child: SvgIcon(
          TradelyIcons.infoCircle,
          color: TextStyles.mediumTitleColor,
        ),
      ),
    );
  }
}
