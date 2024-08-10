import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  static const String route = '/$location';
  static const String location = 'overview';

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      child: Column(
        children: [
          BaseContainer(
            child: Text("Base container"),
          ),
          PrimaryButton(
            height: 42,
            onTap: () {},
            text: "Primary button",
          ),
          PrimaryButton(
            height: 42,
            onTap: () {},
            text: "Primary button icon",
            prefixIcon: TradelyIcons.diary,
          ),
          SizedBox(
            height: 100,
          ),
          PrimaryTextInput(
            label: "TEST",
            hint: "hint",
            tec: TextEditingController(),
          ),
        ],
      ),
    );
  }
}
