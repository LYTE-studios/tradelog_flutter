import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/password_text_input.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  static const String route = '/$location';
  static const String location = 'overview';

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Discover all your performance metrics & progress.",
        icon: TradelyIcons.overview,
        currentRoute: location,
        title: "Good morning, Robin! 👋",
        buttons: PrimaryButton(
          onTap: () {},
          height: 42,
          text: "Add new trade",
          prefixIcon: TradelyIcons.plusCircle,
          prefixIconSize: 22,
        ),
      ),
      child: ListView(
        children: [
          const BaseContainer(
            child: ToolTipTitle(
              toolTipText:
                  'The total realized net profit and loss for all closed trades. The total realized net profit and loss for all closed trades. The total realized net profit and loss for all closed trades.',
              titleText: 'test',
            ),
          ),
          PrimaryButton(
            height: 42,
            onTap: () {},
            text: "Primary button",
            width: 500,
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryButton(
            expand: false,
            align: MainAxisAlignment.start,
            height: 42,
            onTap: () {},
            text: "Primary button icon",
            prefixIcon: TradelyIcons.diary,
          ),
          const SizedBox(
            height: 10,
          ),
          PrimaryTextInput(
            label: "Test",
            hint: "hint",
            tec: TextEditingController(),
          ),
          const SizedBox(
            height: 100,
          ),
          PrimaryTextInput(
            height: 200,
            isError: true,
            label: "error",
            hint: "error",
            tec: TextEditingController(),
          ),
          const SizedBox(
            height: 100,
          ),
          PasswordTextInput(
            label: "password",
            tec: TextEditingController(),
          ),
        ],
      ),
    );
  }
}
