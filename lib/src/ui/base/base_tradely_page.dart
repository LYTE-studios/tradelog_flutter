import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseTradelyPage extends StatelessWidget {
  final Widget? child;

  final Widget? header;

  const BaseTradelyPage({
    super.key,
    this.child,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        PaddingSizes.xxxl,
      ),
      child: Column(
        children: [
          header ?? const SizedBox.shrink(),
          Expanded(
            child: child ??
                const Center(
                  child: SvgIcon(
                    TradelyIcons.tradelyLogo,
                    leaveUnaltered: true,
                    size: 40,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
