import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';

class AccountDropdown extends StatefulWidget {
  const AccountDropdown({super.key});

  @override
  State<AccountDropdown> createState() => _AccountDropdownState();
}

class _AccountDropdownState extends State<AccountDropdown>
    with ScreenStateMixin {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: [
        DropdownMenuItem(
          child: Text('Account 1'),
        ),
        DropdownMenuItem(
          child: Text('Account 2'),
        ),
      ],
      onChanged: (value) {},
    );
  }
}
