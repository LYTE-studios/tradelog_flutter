import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/containers/general_info_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/containers/tradely_pro_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const String route = '/$location';
  static const String location = 'account';

  @override
  Widget build(BuildContext context) {
    return const BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Lorem ipsum dolor sit amet consectetur lorem.",
        icon: 'assets/emojis/Gear.png',
        currentRoute: location,
        title: "Account details",
      ),
      child: Row(
        children: [
          GeneralInfoContainer(),
          TradelyProContainer(),
        ],
      ),
    );
  }
}
