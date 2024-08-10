import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  static const String route = '/$location';
  static const String location = 'overview';

  @override
  Widget build(BuildContext context) {
    return const BaseTradelyPage(
      child: Column(
        children: [
          BaseContainer(
            child: Text("Base container"),
          ),
        ],
      ),
    );
  }
}
