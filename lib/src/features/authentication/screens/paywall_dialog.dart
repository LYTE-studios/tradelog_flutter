import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/containers/tradely_pro_container.dart';
import 'package:tradelog_flutter/src/ui/dialogs/base_dialog.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class PaywallDialog extends StatefulWidget {
  const PaywallDialog({super.key});

  @override
  State<PaywallDialog> createState() => _PaywallDialogState();
}

class _PaywallDialogState extends State<PaywallDialog> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BaseDialog(
      showCloseButton: true,
      opacity: 0.5,
      enableBlur: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose your plan to continue.',
              style: theme.textTheme.titleLarge?.copyWith(fontSize: 37),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 485,
                  height: 397,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      BorderRadii.large,
                    ),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.05),
                      width: 1.5,
                    ),
                    color: const Color(0xFF111111),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 10,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Monthly',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  height: PaddingSizes.xxs,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Enjoy the flexibility of canceling whenever',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(
                                          0.4,
                                        ),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'you want.',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.4,
                                            ),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const Text(
                                          '14-day free trial',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: PaddingSizes.extraLarge,
                        ),
                        TradelyProContainer(
                          link: 'https://buy.stripe.com/fZefZ8bOEfj7cSs6or',
                          price: '29',
                          period: 'month',
                          buttonText: 'Start my subscription',
                          buttonColor: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: PaddingSizes.xxl),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 485,
                  height: 397,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      BorderRadii.large,
                    ),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.05),
                      width: 1.5,
                    ),
                    color: const Color(0xFF111111),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 10,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Yearly',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius: BorderRadius.circular(
                                          30,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 13),
                                        child: Text(
                                          'Best Value',
                                          style: theme.textTheme.titleSmall,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: PaddingSizes.xxs,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Save yourself some trading capital and',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(
                                          0.4,
                                        ),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'choose for yearly!',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.4,
                                            ),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        const Text(
                                          '28-day free trial',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: PaddingSizes.extraLarge,
                        ),
                        TradelyProContainer(
                          link: 'https://buy.stripe.com/8wMbISg4U5IxdWwaEF',
                          price: '280',
                          period: 'year',
                          buttonText: 'Start my subscription',
                          buttonColor: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
