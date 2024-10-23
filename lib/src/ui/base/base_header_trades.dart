import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_Row_Item.dart';

class CustomHeader extends StatelessWidget {
  final List<Widget> children;
  final int flex;
  final double horizontalPadding;

  const CustomHeader({
    super.key,
    required this.children,
    this.flex = 1,
    this.horizontalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: horizontalPadding, right: horizontalPadding, top: 0, bottom: 8),
      child: SizedBox(
        height: 37,
        child: BaseRowItem(
          flex: flex,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}
