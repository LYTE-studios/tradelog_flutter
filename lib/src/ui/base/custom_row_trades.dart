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
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 14,
      ),
      child: Column(
        children: [
          Row(
            children: rowItems,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Divider(
              color: Color(0xFF15161E),
              thickness: 1.5,
            ),
          )
        ],
      ),
    );
  }
}
