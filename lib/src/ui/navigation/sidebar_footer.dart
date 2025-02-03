import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/account_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/add_trade_dialog.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/broker_connection_dialog.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class SidebarFooter extends StatelessWidget {
  final bool extended;

  const SidebarFooter({
    super.key,
    required this.extended,
  });

  Widget footerItems(
    BuildContext context, {
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: PaddingSizes.xxs,
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: theme.colorScheme.primaryContainer.withAlpha(51),
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          BorderRadii.small,
        ),
        child: Ink(
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              BorderRadii.small,
            ),
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment:
                extended ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: extended ? PaddingSizes.medium : 0,
                ),
                child: SvgIcon(
                  icon,
                  size: 18,
                  color: const Color(0xFF666D80),
                ),
              ),
              if (extended)
                Padding(
                  padding: const EdgeInsets.only(
                    left: PaddingSizes.small,
                  ),
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      color: const Color(0xFF666D80),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Sidebar.animationDuration,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: PaddingSizes.large,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            footerItems(context,
                title: extended ? "Add new trade" : "",
                icon: TradelyIcons.add_new_trade,
                onTap: () => AddTradeDialog.show(context)),
            footerItems(context,
                title: extended ? "Link exchange" : "",
                icon: TradelyIcons.link_exchange,
                onTap: () => BrokerConnectionDialog.show(context)),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Divider(
                color: Color(0xFF272835),
                thickness: 1,
              ),
            ),
            (extended)
                ? GestureDetector(
                    onTap: () {
                      context.go(
                        AccountScreen.route,
                      );
                    },
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        radius: 16.0,
                        backgroundImage: AssetImage(
                          TradelyIcons.profile,
                        ), // Replace with actual image URL
                      ),
                      title: Text(
                        'Alexandra Andria',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'alexandra@mail.com',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF666D80),
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Color(0xFF808897),
                        size: 24,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      context.go(
                        AccountScreen.route,
                      );
                    },
                    child: CircleAvatar(
                      radius: 16.0,
                      backgroundImage: AssetImage(
                        TradelyIcons.profile,
                      ), // Replace with actual image URL
                    ),
                  ),
          ],
        ),
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
