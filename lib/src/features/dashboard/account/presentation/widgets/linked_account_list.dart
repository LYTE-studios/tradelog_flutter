import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return TradelyLoadingSwitcher(
      loading: loading,
      child: SizedBox(
        height: 156,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: []
              .map(
                (linkedAccount) => LinkedAccountBlock(
                  refresh: () {},
                  selectable: widget.selectable,
                  selected: false,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
