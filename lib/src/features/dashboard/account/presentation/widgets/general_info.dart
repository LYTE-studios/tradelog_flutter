import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/login/login_screen.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/text/tooltip_title.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class GeneralInfo extends StatefulWidget {
  const GeneralInfo({
    super.key,
  });

  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> with ScreenStateMixin {
  TextEditingController firstNameTec = TextEditingController();
  TextEditingController lastNameTec = TextEditingController();
  TextEditingController emailTec = TextEditingController();
  TextEditingController dateTec = TextEditingController();

  bool isEditing = false;

  TradelyProfile? profile;

  Future<void> updateInfo() async {
    assert(profile != null);

    setLoading(true);

    profile!.firstName = firstNameTec.text;
    profile!.lastName = lastNameTec.text;

    await client.profile.updateProfile(profile!);

    await loadData();

    toggleEditing();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      loading = false;
    });
  }

  @override
  Future<void> loadData() async {
    profile = await client.profile.getProfile();

    setState(() {
      profile = profile;
    });

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    firstNameTec.text = profile?.firstName ?? '';
    lastNameTec.text = profile?.lastName ?? '';
    emailTec.text = sessionManager.signedInUser?.email ?? '';

    return LayoutBuilder(builder: (context, constraints) {
      double columnWidth = constraints.maxWidth;
      double inputWidth = min((columnWidth - PaddingSizes.xxxl) / 2, 350);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "General info",
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(height: PaddingSizes.xxs),

                  // Visibility(
                  //   visible: widget.warningText != null,
                  //   child: Row(
                  //     children: [
                  //       const SvgIcon(
                  //         TradelyIcons.warning,
                  //         leaveUnaltered: true,
                  //       ),
                  //       Text(
                  //         widget.warningText!,
                  //         style: textTheme.titleSmall?.copyWith(
                  //           color: colorScheme.onError,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              PrimaryButton(
                color: colorScheme.errorContainer,
                onTap: () async {
                  await sessionManager.signOut();

                  router.pushReplacement(LoginScreen.route);
                },
                height: 38,
                text: "Delete Account",
                textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colorScheme.error,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: PaddingSizes.medium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PrimaryTextInput(
                readOnly: !isEditing,
                width: inputWidth,
                label: "First Name",
                tec: firstNameTec,
                hint: "",
              ),
              const SizedBox(
                width: PaddingSizes.extraLarge,
              ),
              PrimaryTextInput(
                readOnly: !isEditing,
                width: inputWidth,
                label: "Last Name",
                tec: lastNameTec,
                hint: "",
              ),
            ],
          ),
          const SizedBox(
            height: PaddingSizes.extraLarge,
          ),
          Row(
            children: [
              PrimaryTextInput(
                suffixIcon: const SizedBox(
                  width: 42,
                  child: Center(
                    child: TooltipIcon(
                      tooltipText:
                          'To edit your email address, please contact Tradely support.',
                    ),
                  ),
                ),
                readOnly: true,
                width: inputWidth,
                label: "Your email",
                tec: emailTec,
                hint: "hello@tradely.io",
              ),
              const SizedBox(
                width: PaddingSizes.extraLarge,
              ),
              PrimaryTextInput(
                readOnly: true,
                width: inputWidth,
                label: "Date of birth",
                tec: dateTec,
                hint: "",
              ),
            ],
          ),
          const SizedBox(
            height: PaddingSizes.extraLarge,
          ),
          if (isEditing)
            Row(
              children: [
                PrimaryButton(
                  loading: loading,
                  onTap: updateInfo,
                  width: 150,
                  height: 42,
                  text: "Save changes",
                  color: colorScheme.primaryContainer,
                ),
                const SizedBox(
                  width: PaddingSizes.xxs,
                ),
                PrimaryButton(
                  onTap: toggleEditing,
                  width: 100,
                  height: 42,
                  text: "Cancel",
                  textStyle: textTheme.titleMedium,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ],
            ),
          if (!isEditing)
            PrimaryButton(
              onTap: toggleEditing,
              width: 150,
              height: 42,
              text: "Edit info",
              color: colorScheme.primaryContainer,
            ),
        ],
      );
    });
  }
}
