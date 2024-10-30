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
  OverlayEntry? entry;

  GlobalKey<OverlayState> overlayKey = GlobalKey();

  /// Builds the entire overlay widget with menu items
  OverlayEntry _buildOverlayEntry(BuildContext context, Offset position) {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: position.dy,
          left: position.dx - 256,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF222222),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: const EdgeInsets.all(7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMenuItem(context, "Edit", Colors.white),
                _buildMenuItem(context, "Clear all trades", Colors.white),
                _buildMenuItem(context, "Disable", Colors.white),
                _buildMenuItem(context, "Delete", Colors.red),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds a single menu item in the list
  Widget _buildMenuItem(BuildContext context, String text, Color textColor) {
    final ThemeData theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(BorderRadii.small),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor: textColor.withOpacity(0.2),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          // onTap: overlayPortalController.hide,
          child: SizedBox(
            width: 150,
            height: 40,
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
    );
  }

  void _toggleOverlay(BuildContext context) {
    if (entry != null) {
      _closeOverlay(context);
      return;
    }

    _showOverlay(context);
  }

  void _closeOverlay(BuildContext context) {
    entry?.remove();

    setState(() {
      entry = null;
    });
  }

  void _showOverlay(BuildContext context) {
    assert(overlayKey.currentState != null);

    OverlayState overlayState = overlayKey.currentState!;

    entry = _buildOverlayEntry(
      context,
      (context.findRenderObject() as RenderBox).localToGlobal(Offset.zero),
    );

    overlayState.insert(entry!);

    setState(() {
      entry = entry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: Stack(
        children: [
          Center(
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => _toggleOverlay(context),
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
          Overlay(
            key: overlayKey,
          ),
        ],
      ),
    );
  }
}
