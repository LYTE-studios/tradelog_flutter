import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseInAppNotification extends StatelessWidget {
  final String message;
  final Function()? onDismiss;
  final bool isSuccessful;

  const BaseInAppNotification({
    Key? key,
    required this.message,
    required this.isSuccessful,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        width: 360,
        height: 65,
        decoration: BoxDecoration(
          color:
              isSuccessful ? const Color(0xFF12382D) : const Color(0xFF3B1818),
          border: Border.all(
            color: isSuccessful
                ? const Color(0xFF14D39F)
                : const Color(0xFFE13232),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SvgIcon(
              isSuccessful ? TradelyIcons.checkCircle : TradelyIcons.warning,
              size: 28,
              color: isSuccessful
                  ? const Color(0xFF14D39F)
                  : const Color(0xFFE13232),
            ),
            const SizedBox(width: PaddingSizes.small),
            Text(
              message,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
