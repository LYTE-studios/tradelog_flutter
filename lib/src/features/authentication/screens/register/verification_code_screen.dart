import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/register/register_screen.dart';
import 'package:tradelog_flutter/src/features/authentication/widgets/base_auth_screen.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;

  const VerificationCodeScreen({
    super.key,
    required this.email,
  });

  static const String route = '${RegisterScreen.route}/$location';
  static const String location = 'verification-code';

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen>
    with ScreenStateMixin {
  final TextEditingController codeTec = TextEditingController();

  // Future<void> verifyAccount() async {
  //   if (codeTec.text.isEmpty) {
  //     return;
  //   }
  //
  //   AuthenticationResult result = await AuthenticationManager.verifyAccount(
  //     email: widget.email,
  //     code: codeTec.text,
  //   );
  //
  //   if (result == AuthenticationResult.success) {
  //     router.go(OverviewScreen.route);
  //     return;
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
            "A verification code has been sent to your mailbox!",
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
          tec: codeTec,
          label: "Code",
          hint: "Your verification code",
          height: 57,
        ),
        const SizedBox(
          height: PaddingSizes.xxl,
        ),
        PrimaryButton(
          onTap: () {},
          height: 53,
          text: "Verify Code",
          textStyle: theme.textTheme.titleLarge?.copyWith(
            fontSize: 19,
          ),
        ),
      ],
    );
  }
}
