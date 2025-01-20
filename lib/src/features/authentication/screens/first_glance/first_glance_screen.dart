import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/login/login_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';

class FirstGlanceScreen extends StatefulWidget {
  const FirstGlanceScreen({super.key});

  static const String route = '/$location';
  static const String location = '';

  @override
  State<FirstGlanceScreen> createState() => _FirstGlanceScreenState();
}

class _FirstGlanceScreenState extends State<FirstGlanceScreen>
    with ScreenStateMixin {
  bool _isLogoVisible = false;
  bool _isGlowVisible = false;

  @override
  void initState() {
    super.initState();
    _startFadeIn();
  }

  Future<void> _startFadeIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _isLogoVisible = true;
    });

    await Future.delayed(const Duration(milliseconds: 750));

    setState(() {
      _isGlowVisible = true;
    });

    await loadData();
  }

  @override
  Future<void> loadData() async {
    if (!mounted) {
      return;
    }
    await Future.delayed(
      const Duration(milliseconds: 3250),
    );

    if (!mounted) {
      return;
    }

    await TradelyIcons.preload(context);

    bool isAuthenticated = await UsersService().isAuthenticated();

    if (!isAuthenticated) {
      router.pushReplacement(LoginScreen.route);
    } else {
      router.pushReplacement(OverviewScreen.route);
    }

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        AnimatedOpacity(
          opacity: _isGlowVisible ? 1.0 : 0.0,
          duration: const Duration(
            milliseconds: 500,
          ),
          child: Center(
            child: Container(
              height: 200,
              width: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(BorderRadii.large),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2D62FE).withOpacity(.2),
                    spreadRadius: 10,
                    blurRadius: 500,
                    blurStyle: BlurStyle.inner,
                  ),
                  BoxShadow(
                    color: const Color(0xFF2D62FE).withOpacity(.2),
                    spreadRadius: 10,
                    blurRadius: 500,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        Center(
          child: AnimatedOpacity(
            opacity: _isLogoVisible ? 1.0 : 0.0,
            duration: const Duration(
              milliseconds: 1000,
            ),
            child: const SvgIcon(
              TradelyIcons.tradelyLogoText,
              size: 90,
              color: Colors.white,
            ),
          ),
        ),
      ]),
      backgroundColor: Colors.black,
    );
  }
}
