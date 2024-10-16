import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/managers/authentication_manager.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/forgot_password/forgot_password_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/register/register_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/shared/auth_divider.dart';
import 'package:tradelog_flutter/src/features/authentication/shared/extra_login_options.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/password_text_input.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String route = '/$location';
  static const String location = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ScreenStateMixin {
  final TextEditingController emailTec = TextEditingController();
  final TextEditingController pwTec = TextEditingController();

  @override
  Future<void> loadData() {
    UserInfo? user = sessionManager.signedInUser;

    if (user != null) {
      router.go(OverviewScreen.route);
    }

    return super.loadData();
  }

  Future<void> signIn() async {
    AuthenticationResult result = await AuthenticationManager.signIn(
        email: emailTec.text, password: pwTec.text);

    if (result == AuthenticationResult.success) {
      router.go(OverviewScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: 430,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome back!",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: PaddingSizes.xxl,
            ),
            PrimaryTextInput(
              width: double.infinity,
              tec: emailTec,
              label: "Email",
              hint: "Enter your email address...",
              height: 57,
            ),
            const SizedBox(
              height: PaddingSizes.large,
            ),
            PasswordTextInput(
              tec: pwTec,
              width: double.infinity,
              label: "Password",
              hint: "*****",
              height: 57,
            ),
            const SizedBox(
              height: PaddingSizes.large,
            ),
            ClearInkWell(
              onTap: () {
                context.go(
                  ForgotPasswordScreen.route,
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot password",
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(
              height: PaddingSizes.xxl,
            ),
            PrimaryButton(
              onTap: signIn,
              height: 53,
              text: "Login",
              textStyle: theme.textTheme.titleLarge?.copyWith(
                fontSize: 19,
              ),
            ),
            const SizedBox(
              height: PaddingSizes.xxl,
            ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     'Something went wrong, badly, blame backend.',
            //     style: theme.textTheme.titleMedium?.copyWith(
            //       color: theme.colorScheme.error,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: PaddingSizes.extraLarge,
            // ),
            const ExtraLoginOptions(),
            const SizedBox(
              height: PaddingSizes.xxxxl,
            ),
            RichText(
              text: TextSpan(
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  const TextSpan(
                    text: "New here? ",
                  ),
                  TextSpan(
                    text: "Create an account",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        router.go(RegisterScreen.route);
                      },
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
