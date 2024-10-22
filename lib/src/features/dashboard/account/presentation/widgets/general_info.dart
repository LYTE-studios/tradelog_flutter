import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/routing/router.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/login/login_screen.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';
import 'package:tradelog_flutter/src/ui/input/primary_text_input.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class GeneralInfo extends StatefulWidget {
  final String? warningText;

  final Function onEdit;

  const GeneralInfo({
    super.key,
    this.warningText,
    required this.onEdit,
  });

  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> {
  TextEditingController firstNameTec = TextEditingController();
  TextEditingController lastNameTec = TextEditingController();
  TextEditingController emailTec = TextEditingController();

  // todo make this a real date input field
  TextEditingController dateTec = TextEditingController();

  bool isEditing = false;

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    final TextEditingController firstNameTec = TextEditingController();

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
                  Visibility(
                    visible: widget.warningText != null,
                    child: Row(
                      children: [
                        const SvgIcon(
                          TradelyIcons.warning,
                          leaveUnaltered: true,
                        ),
                        Text(
                          widget.warningText!,
                          style: textTheme.titleSmall?.copyWith(
                            color: colorScheme.onError,
                          ),
                        ),
                      ],
                    ),
                  ),
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
            height: PaddingSizes.extraLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PrimaryTextInput(
                readOnly: !isEditing,
                width: inputWidth,
                label: "First Name",
                tec: firstNameTec,
                hint: "Robin",
              ),
              const SizedBox(
                width: PaddingSizes.xxxl,
              ),
              PrimaryTextInput(
                readOnly: !isEditing,
                width: inputWidth,
                label: "Last Name",
                tec: lastNameTec,
                hint: "Monseré",
              ),
            ],
          ),
          const SizedBox(
            height: PaddingSizes.extraLarge,
          ),
          Row(
            children: [
              PrimaryTextInput(
                readOnly: !isEditing,
                width: inputWidth,
                label: "Your email",
                tec: emailTec,
                hint: "monsere.robin@gmail.com",
              ),
              const SizedBox(
                width: PaddingSizes.xxxl,
              ),
              PrimaryTextInput(
                readOnly: !isEditing,
                width: inputWidth,
                label: "Date of birth",
                tec: dateTec,
                hint: "07/03/2003",
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
                  onTap: toggleEditing,
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
