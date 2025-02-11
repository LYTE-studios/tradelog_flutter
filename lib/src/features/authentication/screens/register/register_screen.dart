import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/authentication/account_credentials_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/authentication/register_account_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/authentication_service.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/login/login_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/widgets/base_auth_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/input/password_text_input.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String route = '${LoginScreen.route}/$location';
  static const String location = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ScreenStateMixin {
  final TextEditingController emailTec = TextEditingController();
  final TextEditingController pwTec = TextEditingController();
  final TextEditingController confirmPwTec = TextEditingController();

  String? errorText;

  Future<void> registerUser() async {
    setLoading(true);
    if (pwTec.text != confirmPwTec.text) {
      setState(() {
        errorText = 'Please make sure your passwords match';
      });
    }
    try {
      AccountCredentialsDto? credentialsDto =
          await AuthenticationService().register(
        RegisterAccountDto(
          email: emailTec.text,
          password: pwTec.text,
        ),
      );
      setLoading(false);
      if (credentialsDto != null) {
        router.pushReplacement(OverviewScreen.route);
        return;
      }
    } catch (e) {
      setLoading(false);

      setState(() {
        errorText = 'Account could not be created. You may not be whitelisted';
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
            "Welcome to Tradely!",
            style: theme.textTheme.titleLarge,
          ),
        ),
        const SizedBox(
          height: PaddingSizes.xxl,
        ),
        PrimaryTextInput(
          onSave: registerUser,
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
          onSave: registerUser,
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
          loading: loading,
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
        // const ExtraLoginOptions(),
      ],
    );
  }
}
