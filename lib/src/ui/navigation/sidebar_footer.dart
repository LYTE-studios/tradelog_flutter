import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/broker_connection_dialog.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class SidebarFooter extends StatelessWidget {
  final bool extended;

  const SidebarFooter({
    super.key,
    required this.extended,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Sidebar.animationDuration,
      child: Column(
        children: [
          PrimaryButton(
            width: extended ? null : 48,
            align:
                extended ? MainAxisAlignment.start : MainAxisAlignment.center,
            onTap: () {},
            height: 48,
            padding: extended ? null : EdgeInsets.zero,
            prefixIconPadding: extended ? null : EdgeInsets.zero,
            text: extended ? "Add new trade" : null,
            prefixIcon: TradelyIcons.plusCircle,
            prefixIconSize: 22,
          ),
          const SizedBox(
            height: PaddingSizes.small,
          ),
          PrimaryButton(
            onTap: () => BrokerConnectionDialog.show(context),
            height: 42,
            align: MainAxisAlignment.start,
            padding: extended
                ? const EdgeInsets.symmetric(
                    horizontal: PaddingSizes.large,
                  )
                : const EdgeInsets.symmetric(
                    horizontal: 9,
                  ),
            prefixChild: Padding(
              padding: EdgeInsets.only(right: extended ? 3 : 0),
              child: const _RotatingIcons(
                icons: [
                  TradelyIcons.tradelocker,
                  TradelyIcons.metatrader,
                ],
              ),
            ),
            outlined: true,
            color: Colors.transparent,
            borderColor: Theme.of(context).colorScheme.outline,
            textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: TextStyles.mediumTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
            text: extended ? "Link exchange" : null,
          ),
          // if (extended)
          //   const SizedBox(
          //     height: PaddingSizes.large,
          //   ),
          // if (extended)
          //   Align(
          //     alignment: Alignment.centerLeft,
          //     child: Padding(
          //       padding: const EdgeInsets.only(
          //         left: PaddingSizes.medium,
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             sessionManager.signedInUser?.fullName ?? '',
          //             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          //                   fontSize: 17,
          //                 ),
          //           ),
          //           const SizedBox(
          //             height: PaddingSizes.xxs,
          //           ),
          //           Text(
          //             sessionManager.signedInUser?.email ?? '',
          //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //                   fontSize: 15,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}

class _RotatingIcons extends StatefulWidget {
  final List<String> icons;

  const _RotatingIcons({
    required this.icons,
  });

  @override
  State<_RotatingIcons> createState() => _RotatingIconsState();
}

class _RotatingIconsState extends State<_RotatingIcons> {
  late PageController controller = PageController();

  Future<void> syncController() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    while (context.mounted) {
      int total = widget.icons.length - 1;

      int current = ((controller.page ?? 0) + 1).toInt();

      if (current > total) {
        current = 0;
      }

      controller.animateToPage(
        current,
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
      );

      await Future.delayed(
        const Duration(seconds: 3),
      );
    }
  }

  @override
  void initState() {
    syncController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: PaddingSizes.xxs,
        right: PaddingSizes.xxs,
      ),
      child: SizedBox(
        height: 21,
        width: 21,
        child: PageView(
          controller: controller,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          children: widget.icons
              .map(
                (icon) => Center(
                  child: SizedBox(
                    width: 21,
                    height: 21,
                    child: Image.asset(
                      icon,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
