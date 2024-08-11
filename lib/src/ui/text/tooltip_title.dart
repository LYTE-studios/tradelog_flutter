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

    return MouseRegion(
      // onEnter: (_) => controller.showTooltip(),
      onExit: (_) => controller.hideTooltip(),
      child: Row(
        children: [
          SuperTooltip(
            constraints: const BoxConstraints(
              maxWidth: 150,
              minWidth: 10,
              minHeight: 20,
            ),
            arrowBaseWidth: 30,
            arrowLength: 8,
            arrowTipDistance: 15,
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
                )),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: SvgIcon(
              TradelyIcons.infoCircle,
              color: TextStyles.mediumTitleColor,
            ),
          ),
          const SizedBox(
            width: PaddingSizes.extraSmall,
          ),
          Text(
            titleText,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
