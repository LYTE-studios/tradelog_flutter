import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/ui/theme/tradely_theme.dart';

Future<void> main() async {
  await initializeServerpodClient();

  runApp(const TradelyApp());
}

class TradelyApp extends StatelessWidget {
  const TradelyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Tradely',
      theme: tradelyTheme,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
