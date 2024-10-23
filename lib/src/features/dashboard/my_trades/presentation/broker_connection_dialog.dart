import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/dialogs/base_dialog.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
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
  final TextEditingController tecAccountName = TextEditingController();
  final TextEditingController tecServerName = TextEditingController();
  final TextEditingController tecUserName = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();

  String? error;

  late List<TextEditingController> requiredControllers = [
    tecAccountName,
    tecServerName,
    tecUserName,
    tecPassword,
  ];

  Future<void> linkAccount() async {
    assert(_selectedPlatform != null);

    setLoading(true);

    if (requiredControllers.map((e) => e.text.isEmpty).contains(true)) {
      setState(() {
        error = 'Please fill in all fields';
        loading = false;
      });
      return;
    } else {
      setState(() {
        error = null;
      });
    }

    await Future.delayed(
      const Duration(seconds: 2),
    );

    // await client.metaApi.(
    //   LinkedAccount(
    //     userInfoId: userInfoId,
    //     apiKey: apiKey,
    //     platform: _selectedPlatform!,
    //   ),
    // );

    setLoading(false);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    tecAccountName.dispose();
    tecServerName.dispose();
    tecUserName.dispose();
    tecPassword.dispose();
    super.dispose();
  }

  final PageController _pageController = PageController();
  Platform? _selectedPlatform;

  void _navigateToNextPage(Platform platform) {
    setState(() {
      _selectedPlatform = platform; // Store the selected broker
    });
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  void _navigateToPreviousPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut);
  }

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
          minHeight: 650,
          maxHeight: 650,
        ),
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
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
                  height: PaddingSizes.medium,
                ),
                Text(
                  'Experience effortless trade tracking with the Exchange connection \nfeature. Import your trades securely utilizing read-only APIs for \nmaximum security',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF898989),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                ),
                const SizedBox(
                  height: PaddingSizes.xxl,
                ),
                ...Platform.values.map(
                  (Platform platform) {
                    return _BaseBrokerRow(
                      height: 70,
                      onTap: () => _navigateToNextPage(platform),
                      padding: const EdgeInsets.symmetric(
                        horizontal: PaddingSizes.large,
                      ),
                      color: const Color(0xFF2B2B2B),
                      icon: getIconForBroker(platform),
                      title: platform.name,
                      description: 'Automatic Sync of Completed Trades',
                      isFirst: Platform.values.first == platform,
                      isLast: Platform.values.last == platform,
                    );
                  },
                ),
              ],
            ),
            if (_selectedPlatform != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: PaddingSizes.small,
                  ),
                  _BaseBrokerRow(
                    height: 35,
                    color: Colors.transparent,
                    padding: EdgeInsets.zero,
                    icon: getIconForBroker(_selectedPlatform!),
                    title: _selectedPlatform!.name,
                  ),
                  Text(
                    'Automatically sync with MT5. Save time and effort by seamlessly  \nmanaging and tracking multiple accounts with just one click.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF898989),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                  ),
                  const SizedBox(
                    height: PaddingSizes.xxl,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account name',
                        style: TextStyles.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: PaddingSizes.medium),
                      Material(
                        child: PrimaryTextInput(
                          tec: tecAccountName,
                          isError: error != null && tecAccountName.text.isEmpty,
                          height: 52,
                          width: 420,
                          hint: 'Account name',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: PaddingSizes.xxl),
                  const Divider(
                    height: 0.5,
                    color: Color(0xFF323232),
                  ),
                  const SizedBox(height: PaddingSizes.extraLarge),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your credentials',
                        style: TextStyles.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: PaddingSizes.medium),
                      Material(
                        child: PrimaryTextInput(
                          tec: tecServerName,
                          isError: error != null && tecServerName.text.isEmpty,
                          height: 52,
                          width: 420,
                          hint: 'Server',
                        ),
                      ),
                      const SizedBox(height: PaddingSizes.medium),
                      Material(
                        child: PrimaryTextInput(
                          tec: tecUserName,
                          isError: error != null && tecUserName.text.isEmpty,
                          height: 52,
                          width: 420,
                          hint: 'Login',
                        ),
                      ),
                      const SizedBox(height: PaddingSizes.medium),
                      Material(
                        child: PrimaryTextInput(
                          tec: tecPassword,
                          isError: error != null && tecPassword.text.isEmpty,
                          height: 52,
                          width: 420,
                          hint: 'Investor password',
                        ),
                      ),
                      const SizedBox(height: PaddingSizes.xxl),
                      const Divider(
                        height: 0.5,
                        color: Color(0xFF323232),
                      ),
                      const SizedBox(height: PaddingSizes.xxxl),
                      Row(
                        children: [
                          PrimaryButton(
                            width: 180,
                            onTap: linkAccount,
                            loading: loading,
                            height: 44,
                            text: 'Add exchange',
                            prefixIcon: TradelyIcons.plusCircle,
                          ),
                          const SizedBox(width: PaddingSizes.xxs),
                          Visibility(
                            // Can't go back when loading
                            visible: loading == false,
                            child: PrimaryButton(
                              width: 110,
                              color: Colors.transparent,
                              onTap: _navigateToPreviousPage,
                              height: 44,
                              text: 'Go back',
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _BaseBrokerRow extends StatelessWidget {
  final String icon;
  final Color color;
  final String title;
  final String? description; // Make description optional (nullable)
  final bool isFirst;
  final bool isLast;
  final Function()? onTap;
  final EdgeInsetsGeometry padding;
  final double? height;

  const _BaseBrokerRow({
    required this.icon,
    required this.title,
    required this.color,
    required this.padding,
    required this.height,
    this.description, // Optional description
    this.isFirst = false,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            color: color,
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                height: height,
                child: Padding(
                  padding: padding,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 35,
                          width: 35,
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
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            // Conditionally show description if it's not null
                            if (description != null) ...[
                              const SizedBox(
                                height: PaddingSizes.xxxs,
                              ),
                              Text(
                                description!,
                                style: TextStyles.bodySmall.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ],
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
          const SizedBox(
            height: 13,
          ),
      ],
    );
  }
}
