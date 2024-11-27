import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class CustomPopupMenu extends StatefulWidget {
  final Function(String)? onSelected;

  const CustomPopupMenu({super.key, this.onSelected});

  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  MenuController controller = MenuController();

  /// Builds a single menu item in the list
  Widget _buildMenuItem(BuildContext context, String text, Color textColor) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(BorderRadii.extraSmall),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            hoverColor: textColor.withOpacity(0.2),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              widget.onSelected?.call(text);
            },
            child: SizedBox(
              width: 146,
              height: 36,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    text,
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: controller,
      menuChildren: [
        // _buildMenuItem(context, "Edit", Colors.white),
        // _buildMenuItem(context, "Clear all trades", Colors.white),
        _buildMenuItem(context, "Disable", Colors.white),
        _buildMenuItem(context, "Delete", Colors.red),
      ],
      style: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(
          Color(0xFF222222),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BorderRadii.small),
          ),
        ),
      ),
      child: Center(
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => controller.open(position: Offset.zero),
              child: Padding(
                padding: const EdgeInsets.all(PaddingSizes.xxs),
                child: Center(
                  child: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).colorScheme.onSecondary,
                    size: 21,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
