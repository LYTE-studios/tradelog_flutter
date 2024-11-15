import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class SendEmailButton extends StatefulWidget {
  final VoidCallback onLinkCopied;

  const SendEmailButton({super.key, required this.onLinkCopied});

  @override
  State<SendEmailButton> createState() => _CopyLinkButtonState();
}

class _CopyLinkButtonState extends State<SendEmailButton> {
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
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          color: _isCopied ? const Color(0xFF31B61A) : const Color(0xFF2D62FE),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isCopied ? 'EMAIL SENT' : 'SEND EMAIL',
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
            ],
          ),
        ),
      ),
    );
  }
}
