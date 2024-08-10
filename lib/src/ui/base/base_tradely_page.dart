import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/navigation/tradely_sidebar.dart';

class BaseTradelyPage extends StatelessWidget {
  final Widget? child;

  const BaseTradelyPage({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const TradelySidebar(),
          child ??
              Expanded(
                child: Center(
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
