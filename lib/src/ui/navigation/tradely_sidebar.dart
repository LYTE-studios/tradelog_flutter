import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:tradelog_flutter/src/features/account/presentation/account_screen.dart';
import 'package:tradelog_flutter/src/features/diary/presentation/diary_screen.dart';
import 'package:tradelog_flutter/src/features/my_trades/presentation/my_trades_screen.dart';
import 'package:tradelog_flutter/src/features/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/features/statistics/presentation/statistics_screen.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class TradelySidebar extends StatelessWidget {
  const TradelySidebar({super.key});

  // Map routes to their corresponding index in the Sidebar
  static const Map<String, int> routeToIndex = {
    OverviewScreen.route: 0,
    DiaryScreen.route: 1,
    MyTradesScreen.route: 2,
    StatisticsScreen.route: 3,
    AccountScreen.route: 4,
  };

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).fullPath;
    final initialIndex = routeToIndex[currentRoute] ?? 0;
    final controller =
        SidebarXController(selectedIndex: initialIndex, extended: false);
    return SidebarX(
      animationDuration: const Duration(milliseconds: 0),
      showToggleButton: true,
      theme: SidebarXTheme(
        margin: const EdgeInsets.only(
            //right: PaddingSizes.xxxl,
            ),
        itemMargin: const EdgeInsets.symmetric(
          horizontal: PaddingSizes.medium,
        ),
        selectedItemMargin: const EdgeInsets.symmetric(
          horizontal: PaddingSizes.medium,
        ),
        itemPadding: const EdgeInsets.symmetric(
          vertical: PaddingSizes.medium,
        ),
        selectedItemPadding: const EdgeInsets.symmetric(
          vertical: PaddingSizes.medium,
        ),
        padding: const EdgeInsets.only(
          top: PaddingSizes.xxl,
        ),
        width: 100,
        hoverTextStyle: Theme.of(context).textTheme.titleMedium,
        textStyle: Theme.of(context).textTheme.titleMedium,
        selectedTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: TextStyles.selectedMediumTitleColor,
            ),
        selectedItemDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(
            BorderRadii.small,
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 275,
        itemMargin: EdgeInsets.symmetric(
          horizontal: PaddingSizes.medium,
        ),
        selectedItemMargin: EdgeInsets.symmetric(
          horizontal: PaddingSizes.medium,
        ),
        padding: EdgeInsets.symmetric(
          vertical: PaddingSizes.xxl,
        ),
        itemPadding: EdgeInsets.only(
          left: PaddingSizes.medium,
          top: PaddingSizes.medium,
          bottom: PaddingSizes.medium,
        ),
        selectedItemPadding: EdgeInsets.only(
          left: PaddingSizes.medium,
          top: PaddingSizes.medium,
          bottom: PaddingSizes.medium,
        ),
        itemTextPadding: EdgeInsets.only(
          left: PaddingSizes.medium,
        ),
        selectedItemTextPadding: EdgeInsets.only(
          left: PaddingSizes.medium,
        ),
      ),
      controller: controller,
      headerBuilder: (BuildContext context, bool extended) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: extended ? Alignment.centerLeft : Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  left: extended ? PaddingSizes.medium * 2 : 0,
                  bottom: PaddingSizes.xxl,
                ),
                child: SvgIcon(
                  extended
                      ? TradelyIcons.tradelyLogo
                      : TradelyIcons.tradelyLogoSmall,
                  leaveUnaltered: true,
                  size: 25,
                ),
              ),
            ),
            Positioned(
              right: -11,
              child: ClearInkWell(
                onTap: () {
                  controller.setExtended(!extended);
                },
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
        );
      },
      items: [
        SidebarXItem(
          iconBuilder: (
            selected,
            hovered,
          ) {
            return SvgIcon(
              TradelyIcons.overview,
              size: 22,
              color: selected
                  ? TextStyles.selectedMediumTitleColor
                  : TextStyles.mediumTitleColor,
            );
          },
          label: 'Overview',
          onTap: () {
            context.go(OverviewScreen.route);
          },
        ),
        SidebarXItem(
          iconBuilder: (
            selected,
            hovered,
          ) {
            return SvgIcon(
              TradelyIcons.diary,
              size: 22,
              color: selected
                  ? TextStyles.selectedMediumTitleColor
                  : TextStyles.mediumTitleColor,
            );
          },
          label: 'Diary',
          onTap: () {
            context.go(DiaryScreen.route);
          },
        ),
        SidebarXItem(
          iconBuilder: (
            selected,
            hovered,
          ) {
            return SvgIcon(
              TradelyIcons.myTrades,
              size: 22,
              color: selected
                  ? TextStyles.selectedMediumTitleColor
                  : TextStyles.mediumTitleColor,
            );
          },
          label: 'My Trades',
          onTap: () {
            context.go(MyTradesScreen.route);
          },
        ),
        SidebarXItem(
          iconBuilder: (
            selected,
            hovered,
          ) {
            return SvgIcon(
              TradelyIcons.statistics,
              size: 22,
              color: selected
                  ? TextStyles.selectedMediumTitleColor
                  : TextStyles.mediumTitleColor,
            );
          },
          label: 'Statistics',
          onTap: () {
            context.go(StatisticsScreen.route);
          },
        ),
        SidebarXItem(
          iconBuilder: (
            selected,
            hovered,
          ) {
            return SvgIcon(
              TradelyIcons.account,
              size: 22,
              color: selected
                  ? TextStyles.selectedMediumTitleColor
                  : TextStyles.mediumTitleColor,
            );
          },
          label: 'Account',
          onTap: () {
            context.go(AccountScreen.route);
          },
        ),
      ],
    );
  }
}
