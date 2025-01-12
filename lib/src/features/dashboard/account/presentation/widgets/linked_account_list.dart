import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trading_account_list_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/linked_account_block.dart';
import 'package:tradelog_flutter/src/ui/loading/tradely_loading_switcher.dart';

class LinkedAccountList extends StatefulWidget {
  final bool selectable;

  const LinkedAccountList({
    super.key,
    this.selectable = false,
  });

  @override
  State<LinkedAccountList> createState() => _LinkedAccountListState();
}

class _LinkedAccountListState extends State<LinkedAccountList>
    with ScreenStateMixin {
  TradingAccountListDto? accountListDto;

  @override
  Future<void> loadData() async {
    accountListDto = await UsersService().fetchAllAccounts();

    setState(() {
      accountListDto = accountListDto;
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
          children: [
            ...accountListDto?.accounts
                    .map(
                      (linkedAccount) => LinkedAccountBlock(
                        name: linkedAccount.accountName,
                        currency: '\$',
                        balance: linkedAccount.accountBalance,
                        delete: () async {},
                        selectable: widget.selectable,
                        selected: false,
                      ),
                    )
                    .toList() ??
                [],
          ],
        ),
      ),
    );
  }
}
