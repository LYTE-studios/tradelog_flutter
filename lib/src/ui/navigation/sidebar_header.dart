import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class SidebarHeader extends StatelessWidget {
  final bool extended;

  const SidebarHeader({
    super.key,
    required this.extended,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
                        horizontal: PaddingSizes.large,

      ),
      child: Align(
        alignment: extended ? Alignment.centerLeft : Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
            
            left: extended ? PaddingSizes.medium : 0,
          ),
          child: Column(
            children: [
              Center(
                child: SvgIcon(
                  extended
                      ? TradelyIcons.tradelySimpleLogo
                      : TradelyIcons.tradelyLogoSmall,
                  leaveUnaltered: true,
                  size: extended ? 25 : 36,
                ),
              ),
              const SizedBox(
                height: PaddingSizes.large,
              ),
              const Divider(
                color: Color(0xFF272835),
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
