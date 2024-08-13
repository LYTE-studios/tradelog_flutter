import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradelog_flutter/src/features/authentication/login/login_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/register/register_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/shared/auth_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/account_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/dashboard_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/diary/presentation/diary_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/my_trades_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/statistics/presentation/statistics_screen.dart';

GoRouter router = GoRouter(
  initialLocation: OverviewScreen.route,
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return AuthScreen(child: child);
      },
      routes: [
        GoRoute(
          path: LoginScreen.route,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: RegisterScreen.route,
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterScreen();
          },
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) {
        return DashboardScreen(child: child);
      },
      routes: [
        GoRoute(
          path: OverviewScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: OverviewScreen(),
          ),
        ),
        GoRoute(
          path: DiaryScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: DiaryScreen(),
          ),
        ),
        GoRoute(
          path: MyTradesScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: MyTradesScreen(),
          ),
        ),
        GoRoute(
          path: StatisticsScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: StatisticsScreen(),
          ),
        ),
        GoRoute(
          path: AccountScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: AccountScreen(),
          ),
        ),
      ],
    ),
  ],
);
