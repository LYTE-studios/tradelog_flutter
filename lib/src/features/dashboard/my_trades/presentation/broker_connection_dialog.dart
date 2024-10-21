import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/ui/dialogs/base_dialog.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

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
          maxHeight: 650,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(
              height: PaddingSizes.xxl,
            ),
            ...Platform.values.map(
              (Platform platform) {
                return _BaseBrokerRow(
                  onTap: () {},
                  icon: getIconForBroker(platform),
                  title: platform.name,
                  description: 'Automatic Sync of Completed Trades',
                  isFirst: Platform.values.first == platform,
                  isLast: Platform.values.last == platform,
                );
              },
            ),
            const SizedBox(
              height: PaddingSizes.medium,
            ),
          ],
        ),
      ),
    );
  }
}

class _BaseBrokerRow extends StatelessWidget {
  final String icon;

  final String title;

  final String description;

  final bool isFirst;

  final bool isLast;

  final Function()? onTap;

  const _BaseBrokerRow({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.isFirst = false,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PaddingSizes.large,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: isFirst
                  ? const Radius.circular(BorderRadii.medium)
                  : Radius.zero,
              topLeft: isFirst
                  ? const Radius.circular(BorderRadii.medium)
                  : Radius.zero,
              bottomLeft: isLast
                  ? const Radius.circular(BorderRadii.medium)
                  : Radius.zero,
              bottomRight: isLast
                  ? const Radius.circular(BorderRadii.medium)
                  : Radius.zero,
            ),
            child: Material(
              child: InkWell(
                onTap: onTap,
                child: SizedBox(
                  height: 64,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: PaddingSizes.large,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 36,
                            width: 36,
                            child: Image.asset(
                              icon,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: PaddingSizes.medium,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: TextStyles.titleMedium.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              const SizedBox(
                                height: PaddingSizes.xxs,
                              ),
                              Text(
                                description,
                                style: TextStyles.bodySmall.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (!isLast)
            Divider(
              thickness: 2,
              height: 0,
              color: Theme.of(context).colorScheme.outline,
            ),
        ],
      ),
    );
  }
}
