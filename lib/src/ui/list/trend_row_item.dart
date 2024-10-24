import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/base/base_Row_Item.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class TrendRowItem extends StatelessWidget {
  final bool short;
  final int flex;

  const TrendRowItem({super.key, 
    required this.short,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return BaseRowItem(
      flex: flex,
      child: Container(
        width: 65,
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          color: short ? const Color(0xFF472526) : const Color(0xFF12382D),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              short ? TradelyIcons.trendDown : TradelyIcons.trendUp,
              color: short ? const Color(0xFFFB4F57) : const Color(0xFF14D39F),
              size: 9,
            ),
            const SizedBox(width: PaddingSizes.xxs),
            Text(
              short ? 'Short' : 'Long',
              style: TextStyles.labelMedium.copyWith(
                color:
                    short ? const Color(0xFFFB4F57) : const Color(0xFF14D39F),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
