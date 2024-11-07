import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/containers/tradely_pro_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/general_info.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/linked_account_list.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class GeneralInfoContainer extends StatefulWidget {
  const GeneralInfoContainer({super.key});

  @override
  State<GeneralInfoContainer> createState() => _GeneralInfoContainerState();
}

class _GeneralInfoContainerState extends State<GeneralInfoContainer> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BaseContainer(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(
          PaddingSizes.xxl,
        ),
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
            LinkedAccountList(),
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
            const TradelyProContainer(
              link: 'https://www.stripe.com',
              period: 'month',
              buttonText: 'Manage subscription',
              buttonColor: Color(0xFF262626),
              price: '29',
            ),
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
              onTap: () async {},
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
      ),
    );
  }
}
