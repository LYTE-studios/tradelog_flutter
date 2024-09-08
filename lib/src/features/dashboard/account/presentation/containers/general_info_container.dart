import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/general_info.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/linked_accounts.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';

class GeneralInfoContainer extends StatelessWidget {
  const GeneralInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BaseContainer(
      width: 870,
      child: Column(
        children: [
          GeneralInfo(
            onEdit: () {},
            warningText: "Please verify your email address",
          ),
          const Spacer(),
          Divider(
            height: 1,
            color: colorScheme.outline,
          ),
          const Spacer(),
          const LinkedAccounts(),
        ],
      ),
    );
  }
}
