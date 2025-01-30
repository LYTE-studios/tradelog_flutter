import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_Row_Item.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderRowItem extends StatelessWidget {
  final String text;
  final int flex;
  final String? icon;

  const HeaderRowItem({
    required this.text,
    this.flex = 1,
    super.key,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return BaseRowItem(
      flex: flex,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyles.titleSmall.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFA2A2AA),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          if (icon != null)
            SvgPicture.asset(
              icon!,
              width: 15,
              height: 15,
              color: const Color(0xFFA2A2AA),
            )
        ],
      ),
    );
  }
}
