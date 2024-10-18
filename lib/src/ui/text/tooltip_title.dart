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
    final controller = SuperTooltipController();

    return Row(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onExit: (_) => controller.hideTooltip(),
          onEnter: (_) => controller.showTooltip(),
          child: IgnorePointer(
            child: SuperTooltip(
              showBarrier: false,
              hasShadow: false,
              controller: controller,
              borderColor: Theme.of(context).colorScheme.primaryContainer,
              popupDirection: TooltipDirection.up,
              content: SizedBox(
                width: 250,
                child: Text(
                  toolTipText,
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
