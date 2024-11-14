import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class CopyLinkButton extends StatefulWidget {
  final VoidCallback onLinkCopied;

  const CopyLinkButton({super.key, required this.onLinkCopied});

  @override
  State<CopyLinkButton> createState() => _CopyLinkButtonState();
}

class _CopyLinkButtonState extends State<CopyLinkButton> {
  bool _isCopied = false;

  void _handleTap() {
    setState(() {
      _isCopied = true;
    });

    // Trigger the callback after 2 seconds
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isCopied = false;
      });
      widget.onLinkCopied(); // Notify parent to move to the next step
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: 58,
        width: 275,
        decoration: BoxDecoration(
          color: _isCopied ? const Color(0xFF2F2F2F) : const Color(0xFF2D62FE),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isCopied ? 'LINK COPIED' : 'COPY LINK',
                style: const TextStyle(
                  fontFamily: 'Phonk',
                  color: Colors.white,
                  fontSize: 17.8,
                ),
              ),
              const SizedBox(width: 7),
              if (_isCopied)
                const SvgIcon(
                  TradelyIcons.copied,
                  color: Colors.white,
                  size: 17,
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: PaddingSizes.large,
                  ),
                  child: SvgIcon(
                    TradelyIcons.link,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
