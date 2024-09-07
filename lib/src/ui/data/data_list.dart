import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/data/data_list_item.dart';

class DataList extends StatelessWidget {
  const DataList({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      padding: EdgeInsets.zero,
      child: ListView.builder(
        itemCount: 50,
        itemExtent: 40,
        itemBuilder: (BuildContext context, int index) {
          return DataListItem(
            color: index.isEven
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
          );
        },
      ),
    );
  }
}
