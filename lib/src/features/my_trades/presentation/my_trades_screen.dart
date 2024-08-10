import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';

class MyTradesScreen extends StatelessWidget {
  const MyTradesScreen({super.key});

  static const String route = '/$location';
  static const String location = 'my_trades';

  @override
  Widget build(BuildContext context) {
    return const BaseTradelyPage();
  }
}
