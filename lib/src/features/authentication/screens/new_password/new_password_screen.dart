import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/widgets/auth_error.dart';
import 'package:tradelog_flutter/src/features/authentication/widgets/base_auth_screen.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/input/password_text_input.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  static const String route = '${ForgotPasswordScreen.route}/$location';
  static const String location = 'new_password';

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController codeTec = TextEditingController();
  final TextEditingController pwTec = TextEditingController();
  final TextEditingController confirmPwTec = TextEditingController();

  String? error;

  // Future<void> resetPassword() async {
  //   if (pwTec.text != confirmPwTec.text) {
  //     setState(() {
  //       error = 'Passwords don\'t match';
  //     });
  //     return;
  //   }
  //
  //   AuthenticationResult result =
  //       await AuthenticationManager.resetPassword(codeTec.text, pwTec.text);
  //
  //   if (result == AuthenticationResult.success) {
  //     router.pushReplacement(LoginScreen.route);
  //   } else if (result == AuthenticationResult.failure) {
  //     setState(() {
  //       error = 'Verification code was incorrect';
  //     });
  //   } else if (result == AuthenticationResult.error) {
  //     setState(() {
  //       error = 'An unexpected error occured.';
  //     });
  //   }
  // }

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
          tec: codeTec,
          label: "Code",
          hint: "Your verification code",
          height: 57,
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
        AuthError(
          error: error,
        ),
      ],
    );
  }
}
