import 'package:flutter/cupertino.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/overview_statistics_dto.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/input/charted_date_selector.dart';
import 'package:tradelog_flutter/src/ui/input/date_selector.dart';

class DateSelectorContainer extends StatelessWidget {
  final Function(DateTime)? onDateChanged;

  final Map<DateTime, DayPerformanceDto>? chartData;

  /// base container with a [DateSelector]
  /// Date selector has a fixed height of 380
  const DateSelectorContainer({
    super.key,
    this.onDateChanged,
    this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: ChartedDateSelector(
        onDateChanged: onDateChanged,
        chartData: chartData,
      ),
    );
  }
}
