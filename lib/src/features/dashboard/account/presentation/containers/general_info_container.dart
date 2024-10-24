import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/general_info.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/linked_accounts.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class GeneralInfoContainer extends StatelessWidget {
  const GeneralInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BaseContainer(
      child: Column(
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
          const LinkedAccounts(),
        ],
      ),
    );
  }
}
