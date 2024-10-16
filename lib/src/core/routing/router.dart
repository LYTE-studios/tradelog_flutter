import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/login/login_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/new_password/new_password_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/register/register_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/register/verification_code_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/widgets/auth_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/account_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/dashboard_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/diary/presentation/diary_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/my_trades_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/statistics/presentation/statistics_screen.dart';

GoRouter router = GoRouter(
  initialLocation: LoginScreen.route,
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return AuthScreen(child: child);
      },
      routes: [
        GoRoute(
          path: LoginScreen.route,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(
            child: LoginScreen(),
          ),
          routes: [
            GoRoute(
              path: RegisterScreen.location,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage(
                child: RegisterScreen(),
              ),
              routes: [
                GoRoute(
                  path: VerificationCodeScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      NoTransitionPage(
                    child: VerificationCodeScreen(
                      email: state.extra as String,
                    ),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: ForgotPasswordScreen.location,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage(
                child: ForgotPasswordScreen(),
              ),
              routes: [
                GoRoute(
                  path: NewPasswordScreen.location,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      const NoTransitionPage(
                    child: NewPasswordScreen(),
                  ),
                ),
              ],
            ),
          ],
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
