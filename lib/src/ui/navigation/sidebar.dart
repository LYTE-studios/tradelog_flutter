import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/account_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/diary/presentation/diary_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/my_trades_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/statistics/presentation/statistics_screen.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar_footer.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar_header.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar_item.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar_pro.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class Sidebar extends StatelessWidget {
  final bool extended;

  final Function() onTap;

  const Sidebar({super.key, required this.extended, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: PaddingSizes.extraLarge,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
              width: extended ? 270 : 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: PaddingSizes.xxxl,
                  horizontal: PaddingSizes.large,
                ),
                child: Column(
                  children: [
                    SidebarHeader(
                      extended: extended,
                    ),
                    const SizedBox(
                      height: PaddingSizes.extraLarge,
                    ),
                    SidebarItem(
                      extended: extended,
                      route: OverviewScreen.route,
                    ),
                    SidebarItem(
                      extended: extended,
                      route: DiaryScreen.route,
                    ),
                    SidebarItem(
                      extended: extended,
                      route: MyTradesScreen.route,
                    ),
                    SidebarItem(
                      extended: extended,
                      route: StatisticsScreen.route,
                    ),
                    SidebarItem(
                      extended: extended,
                      route: AccountScreen.route,
                    ),
                    const SizedBox(
                      height: PaddingSizes.large,
                    ),
                    SidebarPro(
                      extended: extended,
                    ),
                    const Spacer(),
                    SidebarFooter(
                      extended: extended,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 11,
            top: PaddingSizes.xxxl,
            child: ClearInkWell(
              onTap: onTap,
              child: Container(
                height: 22,
                width: 22,
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: CircleBorder(
                    side: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                child: Center(
                  child: SvgIcon(
                    size: 14,
                    extended
                        ? TradelyIcons.chevronLeft
                        : TradelyIcons.chevronRight,
                    leaveUnaltered: true,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
