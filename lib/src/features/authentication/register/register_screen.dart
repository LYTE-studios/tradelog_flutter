import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/managers/authentication_manager.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/login/login_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/register/verification_code_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/shared/auth_divider.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/password_text_input.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String route = '/$location';
  static const String location = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ScreenStateMixin {
  final TextEditingController emailTec = TextEditingController();
  final TextEditingController pwTec = TextEditingController();
  final TextEditingController confirmPwTec = TextEditingController();

  String? errorText;

  void handleFailure(AuthenticationResult result) {}

  Future<void> registerUser() async {
    setLoading(true);
    if (pwTec.text != confirmPwTec.text) {
      setState(() {
        errorText = 'Please make sure your passwords match';
      });
    }

    AuthenticationResult result = await AuthenticationManager.createAccount(
      email: emailTec.text,
      password: emailTec.text,
    );

    if (result == AuthenticationResult.verificationCodeSent) {
      router.go(VerificationCodeScreen.route, extra: emailTec.text);

      setLoading(false);
      return;
    }

    handleFailure(result);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // todo, ask Tanguy, this sucks.
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
                        "Welcome to Tradely!",
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
                      height: PaddingSizes.large,
                    ),
                    PasswordTextInput(
                      isError: errorText != null,
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
                      isError: errorText != null,
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
                      onTap: registerUser,
                      height: 53,
                      text: "Create account",
                      textStyle: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(
                      height: PaddingSizes.xxl,
                    ),
                    Visibility(
                      visible: errorText != null,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorText ?? '',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: PaddingSizes.extraLarge,
                    ),
                    const AuthDivider(),
                    const SizedBox(
                      height: PaddingSizes.extraLarge,
                    ),
                    PrimaryButton(
                      onTap: () {},
                      height: 53,
                      color: theme.colorScheme.primaryContainer,
                      text: "Login with Google",
                      prefixIcon: TradelyIcons.google,
                      leaveIconUnaltered: true,
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
