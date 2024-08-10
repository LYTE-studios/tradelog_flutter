import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  static const String route = '/$location';
  static const String location = 'diary';

  @override
  Widget build(BuildContext context) {
    return const BaseTradelyPage();
  }
}
