import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/navigation/sidebar.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;

  const DashboardScreen({super.key, required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool extended = true;

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
              Expanded(child: widget.child),
            ],
          ),
          AnimatedPositioned(
            duration: Sidebar.animationDuration,
            left: extended
                ? Sidebar.extendedLength - 11
                : Sidebar.closedLength - 11,
            top: PaddingSizes.xxxl,
            child: ClearInkWell(
              onTap: () {
                setState(() {
                  extended = !extended;
                });
              },
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
          )
        ],
      ),
    );
  }
}
