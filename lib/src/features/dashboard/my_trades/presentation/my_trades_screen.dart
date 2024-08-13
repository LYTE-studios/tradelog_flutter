import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class MyTradesScreen extends StatelessWidget {
  const MyTradesScreen({super.key});

  static const String route = '/$location';
  static const String location = 'my_trades';

  @override
  Widget build(BuildContext context) {
    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Lorem ipsum dolor sit amet consectetur lorem.",
        icon: TradelyIcons.diary,
        currentRoute: location,
        title: "Your diary 📝",
        buttons: Row(
          children: [
            PrimaryButton(
              onTap: () {},
              height: 42,
              text: "Export list",
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            const SizedBox(
              width: PaddingSizes.large,
            ),
            PrimaryButton(
              onTap: () {},
              height: 42,
              text: "Filter trades",
              prefixIcon: TradelyIcons.diary,
            ),
          ],
        ),
      ),
    );
  }
}
