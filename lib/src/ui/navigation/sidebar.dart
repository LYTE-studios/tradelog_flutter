import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/diary/presentation/diary_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/my_trades_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/statistics/presentation/statistics_screen.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar_footer.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar_header.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar_item.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class Sidebar extends StatelessWidget {
  final bool extended;

  const Sidebar({
    super.key,
    required this.extended,
  });

  static const double extendedLength = 240;
  static const double closedLength = 81;

  static const Duration animationDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AnimatedSize(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Sidebar.animationDuration,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
            width: extended ? extendedLength : closedLength,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: PaddingSizes.xxxl, bottom: PaddingSizes.extraSmall),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SidebarHeader(
                        extended: extended,
                      ),

                      const SizedBox(
                        height: PaddingSizes.large,
                      ),
                      if (extended)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0 + PaddingSizes.large),
                          child: Text(
                            'Main Menu',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.02,
                              fontSize: 12,
                              color: const Color(0xFFA4ABB8),
                            ),
                          ),
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
                      const SizedBox(
                        height: PaddingSizes.large,
                      ),
                      if (extended)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0 + PaddingSizes.large,
                              vertical: 8),
                          child: Text(
                            'Record',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.02,
                              fontSize: 12,
                              color: const Color(0xFFA4ABB8),
                            ),
                          ),
                        ),
                      SidebarItem(
                        extended: extended,
                        route: StatisticsScreen.route,
                      ),
                      // SidebarItem(
                      //   extended: extended,
                      //   route: AccountScreen.route,
                      // ),
                    ],
                  ),
                  SidebarFooter(
                    extended: extended,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
