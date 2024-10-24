import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final List<Widget> rowItems;
  final double horizontalPadding;

  const CustomRow({
    required this.rowItems,
    this.horizontalPadding = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 14),
      child: Row(
        children: rowItems,
      ),
    );
  }
}
