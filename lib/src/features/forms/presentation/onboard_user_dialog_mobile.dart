import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/buttons/copy_link_button.dart';
import 'package:tradelog_flutter/src/ui/buttons/send_email_button.dart';
import 'package:tradelog_flutter/src/ui/dialogs/base_dialog.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';

class OnboardUserDialogMobile extends StatefulWidget {
  const OnboardUserDialogMobile({super.key});

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const OnboardUserDialogMobile(),
    );
  }

  @override
  State<OnboardUserDialogMobile> createState() => _CopyLinkDialogState();
}

class _CopyLinkDialogState extends State<OnboardUserDialogMobile> {
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
      borderColor: const Color(0xFF242424),
      borderRadius: 24,
      enableBlur: true,
      constraints: const BoxConstraints(
        maxWidth: 340,
        maxHeight: 230,
      ),
      showCloseButton: false,
      opacity: 1,
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
          ),
          child: Center(
            child: Column(
              children: [
                if (_isStep2) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _goToStep1,
                          child: const SvgIcon(
                            TradelyIcons.backDialog,
                            color: Color(0xFF9F9F9F),
                            size: 17,
                          ),
                        ),
                        const SizedBox(
                          width: 27,
                        ),
                        Text(
                          'Check your email inbox\non your desktop',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Open the email on your desktop\nto get started.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF666666),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xFF31B61A),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'EMAIL SENT',
                              style: TextStyle(
                                fontFamily: 'Phonk',
                                color: Colors.white,
                                fontSize: 17.8,
                              ),
                            ),
                            SizedBox(width: 7),
                            SvgIcon(
                              TradelyIcons.check,
                              color: Colors.white,
                              size: 17,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Text(
                    "What's your email?",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Fill in your email to continue',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF666666),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 19,
                    ),
                    child: TextField(
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(
                          18,
                        ),
                        hintText: 'example@mail.com',
                        hintStyle: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8B8B8B),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF313334),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF767676),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                        ),
                        fillColor: Color(0xFF181818),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: _goToStep2,
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D62FE),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SEND EMAIL',
                              style: TextStyle(
                                fontFamily: 'Phonk',
                                color: Colors.white,
                                fontSize: 17.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
