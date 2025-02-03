import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/dashboard/diary/presentation/diary_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/my_trades_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/statistics/presentation/statistics_screen.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class SidebarItem extends StatelessWidget {
  final bool extended;
  final String route;

  const SidebarItem({
    super.key,
    required this.extended,
    required this.route,
  });

  static const Map<String, String> routeToIcon = {
    OverviewScreen.route: TradelyIcons.dashboard,
    DiaryScreen.route: TradelyIcons.diary,
    MyTradesScreen.route: TradelyIcons.myTrades,
    StatisticsScreen.route: TradelyIcons.statistics,
    // AccountScreen.route: TradelyIcons.account,
  };

  static const Map<String, String> routeToTitle = {
    OverviewScreen.route: "Dashboard",
    DiaryScreen.route: "Diary",
    MyTradesScreen.route: "My Trades",
    StatisticsScreen.route: "Statistics",
    // AccountScreen.route: "Account",
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final currentRoute = GoRouterState.of(context).fullPath;
    bool selected = currentRoute == route;
    return AnimatedSize(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Sidebar.animationDuration,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: PaddingSizes.xxs,
        ),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: theme.colorScheme.primaryContainer.withOpacity(0.2),
          onTap: () {
            context.go(
              route,
            );
          },
          borderRadius: BorderRadius.circular(
            BorderRadii.small,
          ),
          child: Ink(
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                BorderRadii.small,
              ),
              color: selected ? const Color(0xFF15161E) : null,
            ),
            child: Row(
              mainAxisAlignment:
                  extended ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: extended ? PaddingSizes.medium : 0,
                  ),
                  child: SvgIcon(
                    routeToIcon[route] ?? TradelyIcons.warning,
                    size: 18,
                    color: selected
                        ? const Color(0xFF2D62FE)
                        : const Color(0xFF666D80),
                  ),
                ),
                if (extended)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: PaddingSizes.small,
                    ),
                    child: Text(
                      routeToTitle[route] ?? "route not found",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: selected
                            ? Theme.of(context).colorScheme.onPrimary
                            : const Color(0xFF666D80),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
