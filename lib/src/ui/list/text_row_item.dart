import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_Row_Item.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class TextRowItem extends StatelessWidget {
  final String text;
  final int flex;

  const TextRowItem({
    required this.text,
    this.flex = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseRowItem(
      flex: flex,
      child: Text(
        text,
        style: TextStyles.titleSmall.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFCCCCCC),
        ),
      ),
    );
  }
}
