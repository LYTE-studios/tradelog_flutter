import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

class SidebarFooter extends StatelessWidget {
  final bool extended;

  const SidebarFooter({
    super.key,
    required this.extended,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          width: extended ? null : 48,
          align: extended ? MainAxisAlignment.start : MainAxisAlignment.center,
          onTap: () {},
          height: 48,
          padding: extended ? null : EdgeInsets.zero,
          prefixIconPadding: extended ? null : EdgeInsets.zero,
          text: extended ? "Add new trade" : null,
          prefixIcon: TradelyIcons.plusCircle,
          prefixIconSize: 22,
        ),
        const SizedBox(
          height: PaddingSizes.extraSmall,
        ),
        ClearInkWell(
          child: BaseContainer(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadii.small,
            height: 48,
            width: extended ? null : 48,
            child: Row(
              children: [
                const SvgIcon(TradelyIcons.eyeClosed),
                if (extended)
                  Text(
                    "Link exchange",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: TextStyles.bodyColor,
                        ),
                  ),
              ],
            ),
          ),
          onTap: () {},
        ),
        const SizedBox(
          height: PaddingSizes.large,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: PaddingSizes.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Robin Monseré",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 17,
                      ),
                ),
                const SizedBox(
                  height: PaddingSizes.xxs,
                ),
                Text(
                  "robin@lyestudios.app",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
