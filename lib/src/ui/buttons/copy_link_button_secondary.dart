import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class CopyLinkButtonSecondary extends StatefulWidget {
  final VoidCallback onLinkCopied;

  const CopyLinkButtonSecondary({super.key, required this.onLinkCopied});

  @override
  State<CopyLinkButtonSecondary> createState() => _CopyLinkButtonState();
}

class _CopyLinkButtonState extends State<CopyLinkButtonSecondary> {
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
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        height: 42,
        width: 140,
        decoration: BoxDecoration(
          color: const Color(0xFF1D1D1D),
          borderRadius: BorderRadius.circular(14.4),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isCopied ? 'Link copied' : 'Share report',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              if (_isCopied)
                const SvgIcon(
                  TradelyIcons.copied,
                  color: Colors.white,
                  size: 12,
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: PaddingSizes.small,
                  ),
                  child: SvgIcon(
                    TradelyIcons.link,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
