import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  static const String route = '/$location';
  static const String location = 'statistics';

  @override
  Widget build(BuildContext context) {
    return const BaseTradelyPage();
  }
}
