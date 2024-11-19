import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/containers/general_info_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const String route = '/$location';
  static const String location = 'account';

  @override
  Widget build(BuildContext context) {
    return const BaseTradelyPage(
      padding: EdgeInsets.only(
        left: PaddingSizes.large,
      ),
      header: BaseTradelyPageHeader(
        subTitle:
            "Manage your personal details, along with other account settings.",
        icon: TradelyIcons.account,
        currentRoute: location,
        title: "Account details",
        titleIconPath: 'assets/images/emojis/cogwheel_emoji.png',
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: PaddingSizes.large,
          ),
          child: GeneralInfoContainer(),
        ),
      ),
    );
  }
}
