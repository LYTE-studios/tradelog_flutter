import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/authentication/forgot_password/forgot_password_screen.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/password_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  static const String route = '/$location';
  static const String location = 'new_password';

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController pwTec = TextEditingController();
  final TextEditingController confirmPwTec = TextEditingController();

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
                    ForgotPasswordScreen.route,
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
                    PasswordTextInput(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: PaddingSizes.extraLarge,
                        // why does xxxl doe weird shit?
                        vertical: PaddingSizes.xxxxl,
                      ),
                      tec: pwTec,
                      width: double.infinity,
                      label: "Password",
                      height: 57,
                    ),
                    const SizedBox(
                      height: PaddingSizes.large,
                    ),
                    PasswordTextInput(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: PaddingSizes.extraLarge,
                        // why does xxxl doe weird shit?
                        vertical: PaddingSizes.xxxxl,
                      ),
                      tec: confirmPwTec,
                      width: double.infinity,
                      label: "Confirm password",
                      height: 57,
                    ),
                    const SizedBox(
                      height: PaddingSizes.xxl,
                    ),
                    PrimaryButton(
                      onTap: () {},
                      height: 53,
                      text: "Reset password",
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
