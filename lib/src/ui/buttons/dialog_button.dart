import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class DialogButton extends StatefulWidget {
  final Function() onTap;
  final double height;
  final String? text;
  final String? prefixIcon;
  final bool? leaveIconUnaltered;
  final Widget dialog;

  const DialogButton({
    super.key,
    required this.onTap,
    required this.height,
    this.text,
    this.prefixIcon,
    this.leaveIconUnaltered,
    required this.dialog,
  });

  @override
  State<DialogButton> createState() => _DialogButtonState();
}

class _DialogButtonState extends State<DialogButton> {
  OverlayEntry? _overlayEntry;

  // Method to create the OverlayEntry (dialog)
  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size; // size of the button
    var offset = renderBox.localToGlobal(Offset.zero);
    double width = MediaQuery.sizeOf(context).width;

    return OverlayEntry(
      builder: (context) => Positioned(
        right: width - offset.dx - size.width,
        top: offset.dy + widget.height + PaddingSizes.large,
        child: widget.dialog,
      ),
    );
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onTap: _toggleOverlay,
      height: widget.height,
      text: widget.text,
      prefixIcon: widget.prefixIcon,
    );
  }
}
