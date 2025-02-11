import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trading_account_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/trading_account_list_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
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

  AccountStatus getAccountStatus(TradingAccountDto linkedAccount) {
    if (linkedAccount.cachedUntil == null) {
      return AccountStatus.pending;
    }
    if (linkedAccount.accountBalance == 0) {
      return AccountStatus.failed;
    }
    print(linkedAccount.accountStatus);
    if (linkedAccount.isDisabled == true) {
      print(AccountStatus.disabled);
      return AccountStatus.disabled;
    }
    return AccountStatus.active;
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
                        status: getAccountStatus(linkedAccount),
                        balance: linkedAccount.accountBalance,
                        isDisabled: linkedAccount.isDisabled!,
                        delete: () async {
                          setLoading(true);
                          try {
                            await UsersService().unlinkAccount(
                              linkedAccount.id,
                            );
                            await loadData();
                          } finally {
                            setLoading(false);
                          }
                        },
                        toggleAccountStatus: () async {
                          setLoading(true);
                          try {
                            await UsersService().toggleAccountStatus(
                              linkedAccount.id,
                            );
                            await loadData();
                          } finally {
                            setLoading(false);
                          }
                        },
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
