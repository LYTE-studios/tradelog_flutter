import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/data/data_list_item.dart';

class DataList extends StatelessWidget {
  final Map<String, String> values;

  final bool loading;

  const DataList({
    super.key,
    required this.values,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      loading: loading,
      padding: EdgeInsets.zero,
      child: ListView.builder(
        primary: false,
        itemCount: values.length,
        itemExtent: 40,
        itemBuilder: (BuildContext context, int index) {
          return DataListItem(
            label: values.keys.toList()[index],
            value: values.values.toList()[index],
            color: index.isEven
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
          );
        },
      ),
    );
  }
}
