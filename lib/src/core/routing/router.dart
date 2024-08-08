import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradelog_flutter/src/features/account/presentation/account_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/presentation/login_screen.dart';
import 'package:tradelog_flutter/src/features/diary/presentation/diary_screen.dart';
import 'package:tradelog_flutter/src/features/my_trades/presentation/my_trades_screen.dart';
import 'package:tradelog_flutter/src/features/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/features/statistics/presentation/statistics_screen.dart';

GoRouter router = GoRouter(
  initialLocation: OverviewScreen.route,
  routes: <RouteBase>[
    GoRoute(
      path: LoginScreen.route,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: OverviewScreen.route,
      builder: (BuildContext context, GoRouterState state) {
        return const OverviewScreen();
      },
    ),
    GoRoute(
      path: DiaryScreen.route,
      builder: (BuildContext context, GoRouterState state) {
        return const DiaryScreen();
      },
    ),
    GoRoute(
      path: DiaryScreen.route,
      builder: (BuildContext context, GoRouterState state) {
        return const MyTradesScreen();
      },
    ),
    GoRoute(
      path: StatisticsScreen.route,
      builder: (BuildContext context, GoRouterState state) {
        return const StatisticsScreen();
      },
    ),
    GoRoute(
      path: AccountScreen.route,
      builder: (BuildContext context, GoRouterState state) {
        return const AccountScreen();
      },
    ),
  ],
);
