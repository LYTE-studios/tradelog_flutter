import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/managers/authentication_manager.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/register/register_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/widgets/auth_error.dart';
import 'package:tradelog_flutter/src/features/authentication/widgets/base_auth_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/widgets/extra_login_options.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/features/forms/presentation/form_overview_screen.dart';
import 'package:tradelog_flutter/src/features/forms/presentation/form_overview_screen_new_users.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
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

  String? error;

  Future<void> signIn() async {
    setLoading(true);

    AuthenticationResult result = await AuthenticationManager.signIn(
      email: emailTec.text,
      password: pwTec.text,
    );

    if (result == AuthenticationResult.authenticated) {
      router.go(OverviewScreen.route);
      setLoading(false);
    } else if (result == AuthenticationResult.failure) {
      setState(() {
        error = 'Email or/and password are not correct';
        loading = false;
      });
    } else if (result == AuthenticationResult.error) {
      setState(() {
        error = 'An unexpected error occurred.';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BaseAuthScreen(
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
          onSave: signIn,
          isError: error != null,
          width: double.infinity,
          tec: emailTec,
          label: "Email",
          hint: "Your email address",
          height: 70,
        ),
        PasswordTextInput(
          onSave: signIn,
          isError: error != null,
          tec: pwTec,
          width: double.infinity,
          label: "Password",
          hint: "Your password",
          height: 50,
        ),
        const SizedBox(
          height: PaddingSizes.medium,
        ),
        ClearInkWell(
          onTap: () {
            router.go(
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
          loading: loading,
          onTap: signIn,
          height: 53,
          text: "Login",
          textStyle: theme.textTheme.titleLarge?.copyWith(
            fontSize: 19,
          ),
        ),
        const SizedBox(height: PaddingSizes.medium),
        PrimaryButton(
          loading: loading,
          onTap: () {
            router.go(
              FormOverviewScreenNewUsers.route,
            );
          },
          height: 53,
          text: "loop",
          textStyle: theme.textTheme.titleLarge?.copyWith(
            fontSize: 19,
          ),
        ),
        const SizedBox(height: PaddingSizes.medium),
        const SizedBox(
          height: PaddingSizes.xxl,
        ),
        AuthError(
          error: error,
        ),
        const ExtraLoginOptions(),
        const SizedBox(
          height: PaddingSizes.xxxxl,
        ),
        Center(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
              children: [
                const TextSpan(
                  text: "New here?  ",
                ),
                TextSpan(
                  text: "Create an account",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      router.go(RegisterScreen.route);
                    },
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
