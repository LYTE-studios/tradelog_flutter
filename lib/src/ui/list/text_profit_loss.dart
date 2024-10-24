import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_Row_Item.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class TextProfitLoss extends StatelessWidget {
  final String text;
  final int flex;
  final bool short;

  const TextProfitLoss({
    required this.text,
    required this.short,
    this.flex = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseRowItem(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyles.titleSmall.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: short ? const Color(0xFFDA484E) : const Color(0xFF14D39F),
        ),
      ),
    );
  }
}
