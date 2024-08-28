import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/authentication/login/login_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/new_password/new_password_screen.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String route = '/$location';
  static const String location = 'forgot_password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailTec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ClearInkWell(
                onTap: () {
                  context.go(
                    LoginScreen.route,
                  );
                },
                child: const SvgIcon(
                  TradelyIcons.arrowBack,
                  leaveUnaltered: true,
                  size: 40,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 430,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Reset your password",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(
                      height: PaddingSizes.xxl,
                    ),
                    PrimaryTextInput(
                      width: double.infinity,
                      tec: emailTec,
                      label: "Email Address",
                      height: 57,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: PaddingSizes.extraLarge,
                        // why does xxxl doe weird shit?
                        vertical: PaddingSizes.xxxxl,
                      ),
                    ),
                    const SizedBox(
                      height: PaddingSizes.xxl,
                    ),
                    PrimaryButton(
                      onTap: () {
                        context.go(
                          NewPasswordScreen.route,
                        );
                      },
                      height: 53,
                      text: "Send reset link",
                      textStyle: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
