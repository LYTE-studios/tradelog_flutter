import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/managers/authentication_manager.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/login/login_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/new_password/new_password_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/widgets/auth_error.dart';
import 'package:tradelog_flutter/src/features/authentication/widgets/base_auth_screen.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String route = '${LoginScreen.route}/$location';
  static const String location = 'forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailTec = TextEditingController();

  String? error;

  Future<void> resetPassword() async {
    AuthenticationResult result =
        await AuthenticationManager.startPasswordReset(
      emailTec.text,
    );

    if (result == AuthenticationResult.success) {
      router.go(NewPasswordScreen.route);
    } else if (result == AuthenticationResult.failure) {
      setState(() {
        error = 'No Account could be found for this email address';
      });
    } else if (result == AuthenticationResult.error) {
      setState(() {
        error = 'An unexpected error occurred.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BaseAuthScreen(
      canGoBack: true,
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
          isError: error != null,
          width: double.infinity,
          tec: emailTec,
          label: "Email Address",
          height: 57,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: PaddingSizes.extraLarge,
            vertical: PaddingSizes.xxxxl,
          ),
        ),
        const SizedBox(
          height: PaddingSizes.xxl,
        ),
        PrimaryButton(
          onTap: resetPassword,
          height: 53,
          text: "Send reset link",
          textStyle: theme.textTheme.titleLarge?.copyWith(
            fontSize: 19,
          ),
        ),
        AuthError(
          error: error,
        ),
      ],
    );
  }
}
