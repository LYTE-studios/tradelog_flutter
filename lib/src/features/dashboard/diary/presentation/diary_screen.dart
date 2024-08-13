import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  static const String route = '/$location';
  static const String location = 'diary';

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Lorem ipsum dolor sit amet consectetur lorem.",
        icon: TradelyIcons.diary,
        currentRoute: location,
        title: "Your diary 📝",
        buttons: PrimaryButton(
          onTap: () {},
          height: 42,
          text: "Add new trade",
          prefixIcon: TradelyIcons.plusCircle,
          prefixIconSize: 22,
        ),
      ),
    );
  }
}
