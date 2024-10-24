import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/login/login_screen.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/containers/tradely_pro_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/general_info.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/linked_account.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/linked_accounts.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class GeneralInfoContainer extends StatelessWidget {
  const GeneralInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BaseContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GeneralInfo(),
          const SizedBox(
            height: PaddingSizes.extraLarge,
          ),
          Divider(
            height: 1,
            color: colorScheme.outline,
          ),
          const SizedBox(
            height: PaddingSizes.extraLarge,
          ),
          Text(
            "Your accounts",
            style: textTheme.titleSmall?.copyWith(
              fontSize: 18.5,
            ),
          ),
          Text(
            "Manage your linked accounts",
            style: textTheme.titleMedium?.copyWith(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: PaddingSizes.extraLarge,
          ),
          const LinkedAccount(), // make this List of all accounts
          const SizedBox(
            height: PaddingSizes.extraLarge,
          ),
          Divider(
            height: 1,
            color: colorScheme.outline,
          ),
          const SizedBox(
            height: PaddingSizes.extraLarge,
          ),
          Text(
            "Your subscription",
            style: textTheme.titleSmall?.copyWith(
              fontSize: 18.5,
            ),
          ),
          Text(
            "Manage your subscription",
            style: textTheme.titleMedium?.copyWith(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: PaddingSizes.medium,
          ),
          const TradelyProContainer(),
          const SizedBox(
            height: PaddingSizes.extraLarge,
          ),
          Divider(
            height: 1,
            color: colorScheme.outline,
          ),
          const SizedBox(
            height: PaddingSizes.extraLarge,
          ),
          PrimaryButton(
            color: colorScheme.errorContainer,
            onTap: () async {
              await sessionManager.signOut();

              router.pushReplacement(LoginScreen.route);
            },
            height: 38,
            width: 255,
            text: "I want to delete my account",
            textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: colorScheme.error,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}
