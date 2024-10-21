import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/ui/dialogs/base_dialog.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BrokerConnectionDialog extends StatefulWidget {
  const BrokerConnectionDialog({super.key});

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const BrokerConnectionDialog(),
    );
  }

  @override
  State<BrokerConnectionDialog> createState() => _BrokerConnectionDialogState();
}

class _BrokerConnectionDialogState extends State<BrokerConnectionDialog>
    with ScreenStateMixin {
  String getIconForBroker(Platform platform) {
    switch (platform) {
      case Platform.Metatrader:
        return TradelyIcons.metatrader;
      case Platform.Tradelocker:
        return TradelyIcons.tradelocker;
      default:
    }

    return TradelyIcons.tradelyLogoSmall;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 100,
      ),
      child: BaseDialog(
        padding: const EdgeInsets.all(
          PaddingSizes.xxl,
        ),
        constraints: const BoxConstraints(
          maxWidth: 620,
          minWidth: 360,
          maxHeight: 650,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: PaddingSizes.small,
            ),
            Text(
              'Exchange Connection',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 21),
            ),
            const SizedBox(
              height: PaddingSizes.xxl,
            ),
            Text(
              'Experience effortless trade tracking with the Exchange connection \nfeature. Import your trades securely utilizing read-only APIs for \nmaximum security',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                  ),
            ),
            ...Platform.values.map(
              (Platform platform) {
                return _BaseBrokerRow(
                  icon: getIconForBroker(platform),
                  title: platform.name,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _BaseBrokerRow extends StatelessWidget {
  final String icon;

  final String title;

  const _BaseBrokerRow({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      child: Row(
        children: [],
      ),
    );
  }
}
