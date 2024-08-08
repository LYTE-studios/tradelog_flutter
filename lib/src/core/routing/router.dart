import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradelog_flutter/src/features/authentication/presentation/login_screen.dart';

GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: LoginScreen.location,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ],
);
