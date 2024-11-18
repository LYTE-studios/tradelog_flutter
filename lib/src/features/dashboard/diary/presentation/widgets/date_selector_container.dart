import 'package:flutter/cupertino.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/input/date_selector.dart';

class DateSelectorContainer extends StatelessWidget {
  final Function(DateTime)? onDateChanged;

  /// base container with a [DateSelector]
  /// Date selector has a fixed height of 380
  const DateSelectorContainer({
    super.key,
    this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: DateSelector(
        onDateChanged: onDateChanged,
      ),
    );
  }
}
