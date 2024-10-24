import 'package:flutter/material.dart';

class BaseRowItem extends StatelessWidget {
  final Widget child;
  final int flex;

  const BaseRowItem({
    required this.child,
    this.flex = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Align(alignment: Alignment.center, child: child),
    );
  }
}
