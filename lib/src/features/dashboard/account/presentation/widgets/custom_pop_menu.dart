import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';
import 'package:tradelog_flutter/src/ui/theme/tradely_theme.dart';

class CustomPopupMenu extends StatefulWidget {
  final Function(String)? onSelected;

  const CustomPopupMenu({super.key, this.onSelected});

  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  /// Builds a single menu item in the list
  List<PopupMenuEntry> _buildMenuItem(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return [
      PopupMenuItem(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(BorderRadii.extraSmall),
            child: Material(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: InkWell(
                hoverColor: Colors.red.withOpacity(0.2),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  widget.onSelected?.call("Delete");
                },
                child: SizedBox(
                  height: 42,
                  width: 128,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Delete",
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: tradelyTheme.copyWith(
        hoverColor: Colors.transparent,
      ),
      child: PopupMenuButton(
        menuPadding: const EdgeInsets.all(0),
        padding: const EdgeInsets.all(0),
        itemBuilder: _buildMenuItem,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        enableFeedback: false,
        splashRadius: 0,
        borderRadius: BorderRadius.circular(
          BorderRadii.large,
        ),
        child: Center(
          child: ClipOval(
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
    );
  }
}
