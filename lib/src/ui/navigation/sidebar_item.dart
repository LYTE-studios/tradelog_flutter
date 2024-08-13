import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/account_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/diary/presentation/diary_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/my_trades_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/statistics/presentation/statistics_screen.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class SidebarItem extends StatelessWidget {
  final bool extended;
  final String route;

  const SidebarItem({
    super.key,
    required this.extended,
    required this.route,
  });

  static const Map<String, String> routeToIcon = {
    OverviewScreen.route: TradelyIcons.overview,
    DiaryScreen.route: TradelyIcons.diary,
    MyTradesScreen.route: TradelyIcons.myTrades,
    StatisticsScreen.route: TradelyIcons.statistics,
    AccountScreen.route: TradelyIcons.account,
  };

  static const Map<String, String> routeToTitle = {
    OverviewScreen.route: "Overview",
    DiaryScreen.route: "Diary",
    MyTradesScreen.route: "My Trades",
    StatisticsScreen.route: "Statistics",
    AccountScreen.route: "Account",
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final currentRoute = GoRouterState.of(context).fullPath;
    bool selected = currentRoute == route;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: PaddingSizes.xxs,
      ),
      child: ClearInkWell(
        onTap: () {
          context.go(
            route,
          );
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              BorderRadii.small,
            ),
            color: selected ? theme.colorScheme.primaryContainer : null,
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
                  size: 22,
                  color: selected
                      ? TextStyles.bodyColor
                      : TextStyles.mediumTitleColor,
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
                      color: selected ? TextStyles.bodyColor : null,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
