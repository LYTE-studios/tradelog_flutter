import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class BaseAuthScreen extends StatelessWidget {
  final bool canGoBack;

  final List<Widget> children;

  final Function()? onEnter;

  const BaseAuthScreen({
    super.key,
    this.canGoBack = false,
    required this.children,
    this.onEnter,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingSizes.xxl,
              vertical: PaddingSizes.xxl,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: canGoBack,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ClearInkWell(
                      onTap: router.pop,
                      child: const SvgIcon(
                        TradelyIcons.arrowBack,
                        leaveUnaltered: true,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 430,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: children,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
