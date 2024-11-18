import 'package:flutter/material.dart';
import 'package:tradelog_client/tradelog_client.dart';
import 'package:tradelog_flutter/src/core/data/client.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/linked_account_block.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_switcher.dart';

class LinkedAccountList extends StatefulWidget {
  final bool selectable;

  final Function(LinkedAccountDto?)? onUpdateSelectedAccount;

  const LinkedAccountList({
    super.key,
    this.selectable = false,
    this.onUpdateSelectedAccount,
  });

  @override
  State<LinkedAccountList> createState() => _LinkedAccountListState();
}

class _LinkedAccountListState extends State<LinkedAccountList>
    with ScreenStateMixin {
  List<LinkedAccountDto> accounts = [];

  LinkedAccountDto? selected;

  @override
  Future<void> loadData() async {
    accounts = await client.account.fetchAccounts();

    setState(() {
      accounts = accounts;
    });

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return TradelyLoadingSwitcher(
      loading: loading,
      child: SizedBox(
        height: 156,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: accounts
              .map(
                (linkedAccount) => LinkedAccountBlock(
                  selectable: widget.selectable,
                  selected: selected == linkedAccount,
                  onTap: () {
                    LinkedAccountDto? newSelected =
                        selected == linkedAccount ? null : linkedAccount;

                    setState(() {
                      selected = newSelected;
                    });

                    widget.onUpdateSelectedAccount?.call(selected);
                  },
                  linkedAccount: linkedAccount,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
