import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/managers/authentication_manager.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/shared/auth_divider.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/overview_screen.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ExtraLoginOptions extends StatelessWidget {
  const ExtraLoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        const AuthDivider(),
        const SizedBox(
          height: PaddingSizes.extraLarge,
        ),
        PrimaryButton(
          onTap: () async {
            AuthenticationResult result =
                await AuthenticationManager.googleSignIn();

            if (result == AuthenticationResult.success) {
              router.go(OverviewScreen.route);
            }
          },
          height: 53,
          color: theme.colorScheme.primaryContainer,
          text: "Login with Google",
          prefixIcon: TradelyIcons.google,
          leaveIconUnaltered: true,
        ),
      ],
    );
  }
}
