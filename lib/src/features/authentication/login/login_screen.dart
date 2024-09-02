import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/authentication/forgot_password/forgot_password_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/register/register_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/shared/auth_divider.dart';
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

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTec = TextEditingController();
  final TextEditingController pwTec = TextEditingController();

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
                "Welcome!",
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: PaddingSizes.extraLarge,
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
              onTap: () {
                context.go(
                  OverviewScreen.route,
                );
              },
              height: 53,
              text: "Login",
              textStyle: theme.textTheme.titleLarge?.copyWith(
                fontSize: 19,
              ),
            ),
            const SizedBox(
              height: PaddingSizes.xxl,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Something went wrong, badly, blame backend.',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
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
            const SizedBox(
              height: PaddingSizes.xxxxl,
            ),
            Row(
              children: [
                Text(
                  "New here?",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(
                  width: PaddingSizes.extraSmall,
                ),
                ClearInkWell(
                  onTap: () {
                    context.go(
                      RegisterScreen.route,
                    );
                  },
                  child: Text(
                    "Create an account",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
