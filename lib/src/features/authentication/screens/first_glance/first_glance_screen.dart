import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/login/login_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class FirstGlanceScreen extends StatefulWidget {
  const FirstGlanceScreen({super.key});

  static const String route = '/$location';
  static const String location = '';

  @override
  State<FirstGlanceScreen> createState() => _FirstGlanceScreenState();
}

class _FirstGlanceScreenState extends State<FirstGlanceScreen>
    with ScreenStateMixin {
  @override
  Future<void> loadData() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    await TradelyIcons.preload(context);

    if (!sessionManager.isSignedIn) {
      router.pushReplacement(LoginScreen.route);
    } else {
      router.pushReplacement(OverviewScreen.route);
    }

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
