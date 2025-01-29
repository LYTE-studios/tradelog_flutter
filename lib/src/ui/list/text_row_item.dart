import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_Row_Item.dart';
import 'package:tradelog_flutter/src/ui/list/flag_overlay.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class TextRowItem extends StatelessWidget {
  final String text;
  final int flex;
  final bool? showFlags;

  const TextRowItem({
    required this.text,
    this.flex = 1,
    super.key,
    this.showFlags,
  });

  @override
  Widget build(BuildContext context) {
    return BaseRowItem(
      flex: flex,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: PaddingSizes.extraSmall,
          ),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // FlagOverlay(),
                showFlags == true ? FlagOverlay() : Container(),
                SizedBox(
                  width: 3,
                ),
                Text(
                  text,
                  softWrap: true,
                  style: TextStyles.titleSmall.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFCCCCCC),
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
