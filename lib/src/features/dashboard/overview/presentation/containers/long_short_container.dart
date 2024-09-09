import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/enums/tradely_enums.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/long_short_buttons.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/long_short_color_identifier.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/long_short_gauge.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/data/small_data_list.dart';

class LongShortContainer extends StatefulWidget {
  const LongShortContainer({super.key});

  @override
  State<LongShortContainer> createState() => _LongShortContainerState();
}

class _LongShortContainerState extends State<LongShortContainer> {
  LongShortSelector selected = LongShortSelector.all;

  void setSelected(LongShortSelector value) {
    setState(() {
      selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Long/short trades",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    const SizedBox(
                      height: 160,
                      width: 160,
                      child: LongShortGauge(),
                    ),
                    const Spacer(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LongShortButtons(
                      selected: selected,
                      onChanged: setSelected,
                    ),
                    const Spacer(),
                    const LongShortColorIdentifier(),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
          const Expanded(
            child: SmallDataList(),
          ),
        ],
      ),
    );
  }
}
