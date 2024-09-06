import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/long_short_buttons.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/long_short_color_identifier.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/long_short_gauge.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/data/small_data_list.dart';

class LongShortContainer extends StatelessWidget {
  const LongShortContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      flex: 3,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Long/short trades",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: LongShortGauge(),
                  ),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LongShortButtons(),
                  LongShortColorIdentifier(),
                ],
              ),
            ],
          ),
          const Spacer(),
          const Expanded(
            child: SmallDataList(),
          ),
        ],
      ),
    );
  }
}
