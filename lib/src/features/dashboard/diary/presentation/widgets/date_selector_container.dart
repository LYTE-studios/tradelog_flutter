import 'package:flutter/cupertino.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/input/date_selector.dart';

class DateSelectorContainer extends StatelessWidget {
  const DateSelectorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      child: DateSelector(),
    );
  }
}
