import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const String route = '/$location';
  static const String location = 'account';

  @override
  Widget build(BuildContext context) {
    return const BaseTradelyPage();
  }
}
