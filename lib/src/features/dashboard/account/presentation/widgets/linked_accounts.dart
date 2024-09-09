import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/linked_account.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class LinkedAccounts extends StatelessWidget {
  const LinkedAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Linked accounts",
          style: textTheme.titleSmall?.copyWith(
            fontSize: 19,
          ),
        ),
        Text(
          "Click to see more",
          style: textTheme.titleMedium,
        ),
        const SizedBox(
          height: PaddingSizes.extraLarge,
        ),
        SizedBox(
          height: 135,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              LinkedAccount(),
              LinkedAccount(),
              LinkedAccount(),
              LinkedAccount(),
              LinkedAccount(),
              LinkedAccount(),
            ],
          ),
        ),
        const SizedBox(
          height: PaddingSizes.xxl,
        ),
        PrimaryButton(
          onTap: () {},
          height: 42,
          text: "See all accounts",
          expand: false,
          color: colorScheme.secondaryContainer,
        )
      ],
    );
  }
}
