import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/first_glance/first_glance_screen.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

ValueNotifier<List<Widget>> errorWidgets = ValueNotifier([]);

class DashboardScreen extends StatefulWidget {
  final Widget child;

  const DashboardScreen({super.key, required this.child});

  static Future<void> showError(Widget widget) async {
    errorWidgets.value = [...errorWidgets.value, widget];

    await Future.delayed(const Duration(seconds: 2));

    List<Widget> newList = [...errorWidgets.value];

    newList.remove(widget);

    errorWidgets.value = newList;
  }

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with ScreenStateMixin {
  bool extended = true;

  @override
  Future<void> loadData() async {
    bool isAuthenticated = await UsersService().isAuthenticated();

    if (!isAuthenticated) {
      router.pushReplacement(FirstGlanceScreen.route);
    }

    await UsersService().refreshAccount(forceRefresh: false);

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Sidebar(
                extended: extended,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double height = constraints.maxHeight;
                    double width = constraints.maxWidth;

                    if (width < 1000) {
                      width = 1000;
                    }

                    if (height < 810) {
                      height = 810;
                    } else if (height > 1200) {
                      height = 1200;
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        height: height,
                        width: width,
                        child: widget.child,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Sidebar.animationDuration,
            left: extended
                ? Sidebar.extendedLength - 11
                : Sidebar.closedLength - 11,
            top: PaddingSizes.xxxl,
            child: Container(
              height: 22,
              width: 22,
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: CircleBorder(
                  side: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
              child: ClearInkWell(
                onTap: () {
                  setState(() {
                    extended = !extended;
                  });
                },
                child: Center(
                  child: SvgIcon(
                    size: 14,
                    extended
                        ? TradelyIcons.chevronLeft
                        : TradelyIcons.chevronRight,
                    leaveUnaltered: true,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: AnimatedSize(
              alignment: Alignment.centerRight,
              duration: kThemeAnimationDuration,
              reverseDuration: kThemeAnimationDuration,
              curve: Curves.fastLinearToSlowEaseIn,
              child: ValueListenableBuilder(
                valueListenable: errorWidgets,
                builder: (context, errors, child) {
                  return SizedBox(
                    height: 96,
                    child: Row(
                      children: errorWidgets.value,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
