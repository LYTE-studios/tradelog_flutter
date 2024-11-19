import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/buttons/copy_link_button.dart';
import 'package:tradelog_flutter/src/ui/dialogs/base_dialog.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class CopyLinkDialog extends StatefulWidget {
  const CopyLinkDialog({super.key});

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const CopyLinkDialog(),
    );
  }

  @override
  State<CopyLinkDialog> createState() => _CopyLinkDialogState();
}

class _CopyLinkDialogState extends State<CopyLinkDialog> {
  bool _isStep2 = false; // Track whether we are on Step 1 or Step 2

  void _goToStep2() {
    setState(() {
      _isStep2 = true;
    });
  }

  void _goToStep1() {
    setState(() {
      _isStep2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BaseDialog(
      constraints: const BoxConstraints(
        maxWidth: 340,
        maxHeight: 220,
      ),
      showCloseButton: false,
      opacity: 1,
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 25,
            bottom: 16,
          ),
          child: Center(
            child: Column(
              children: [
                if (_isStep2) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _goToStep1, // Go back to Step 1
                          child: const SvgIcon(
                            TradelyIcons.backDialog,
                            color: Color(0xFF9F9F9F),
                            size: 17,
                          ),
                        ),
                        const SizedBox(
                          width: 86,
                        ),
                        Text(
                          'Step 2',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Click the button & paste\nthe link on the placeholder.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 23),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 58,
                      width: 275,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D62FE),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SHARE ON',
                              style: TextStyle(
                                fontFamily: 'Phonk',
                                color: Colors.white,
                                fontSize: 17.8,
                              ),
                            ),
                            SizedBox(width: 7),
                            SvgIcon(
                              TradelyIcons.instagram,
                              color: Colors.white,
                              size: 26,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Text(
                    'Step 1',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Copy the link by \nclicking the button',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 23),
                  CopyLinkButton(onLinkCopied: _goToStep2), // Trigger Step 2
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
