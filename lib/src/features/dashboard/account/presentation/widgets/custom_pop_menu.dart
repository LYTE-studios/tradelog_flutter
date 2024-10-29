import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';

class CustomPopupMenu extends StatefulWidget {
  final Function(String)? onSelected;

  const CustomPopupMenu({Key? key, this.onSelected}) : super(key: key);

  @override
  _CustomPopupMenuState createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  bool isMenuOpen = false;
  OverlayEntry? _overlayEntry;
  final GlobalKey _menuKey = GlobalKey();

  String? _hoveredItem;

  OverlayEntry _buildOverlayEntry() {
    RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        final ThemeData theme = Theme.of(context);

        return Stack(
          children: [
            GestureDetector(
              onTap: _closeMenu,
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: offset.dx + renderBox.size.width - 325,
              top: offset.dy + renderBox.size.height + 1,
              child: Material(
                color: Colors.transparent,
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
                      _buildMenuItem("Edit", Colors.white),
                      _buildMenuItem("Clear all trades", Colors.white),
                      _buildMenuItem("Disable", Colors.white),
                      _buildMenuItem("Delete", theme.colorScheme.error),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  ValueNotifier<String?> _hoveredItemNotifier = ValueNotifier<String?>(null);

  Widget _buildMenuItem(String text, Color textColor) {
    final ThemeData theme = Theme.of(context);

    Color effectiveTextColor =
        text == "Delete" ? theme.colorScheme.error : textColor;

    return GestureDetector(
      onTap: () {
        widget.onSelected?.call(text);
        _closeMenu();
      },
      child: MouseRegion(
        onEnter: (_) => _hoveredItemNotifier.value = text,
        onExit: (_) => _hoveredItemNotifier.value = null,
        child: ValueListenableBuilder<String?>(
          valueListenable: _hoveredItemNotifier,
          builder: (context, hoveredItem, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(BorderRadii.small),
                color: hoveredItem == text
                    ? (text == "Delete"
                        ? const Color(0xFF2E2425)
                        : const Color(0xFF2B2B2B))
                    : Colors.transparent,
              ),
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
                      color: effectiveTextColor,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openMenu() {
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      isMenuOpen = true;
    });
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    setState(() {
      isMenuOpen = false;
      _hoveredItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _menuKey,
      onTap: () {
        if (isMenuOpen) {
          _closeMenu();
        } else {
          _openMenu();
        }
      },
      child: Icon(Icons.more_vert, color: Colors.white),
    );
  }
}
