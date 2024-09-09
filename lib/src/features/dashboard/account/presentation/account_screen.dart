import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const String route = '/$location';
  static const String location = 'account';

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: const BaseTradelyPageHeader(
        subTitle: "Lorem ipsum dolor sit amet consectetur lorem.",
        icon: TradelyIcons.account,
        currentRoute: location,
        title: "Account details 💱",
      ),
      child: Row(
        children: [
          PrimaryButton(
            onTap: () {},
            height: 50,
            text: "This is a button",
          ),
          BaseContainer(
            backgroundColor: Colors.orange,
            child: PrimaryButton(
              onTap: () {},
              height: 50,
              text: "This is a button, inside a base container",
            ),
          ),
          ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrimaryButton(
                  onTap: () {},
                  height: 50,
                  text: "This is a button, inside an box decoration",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
