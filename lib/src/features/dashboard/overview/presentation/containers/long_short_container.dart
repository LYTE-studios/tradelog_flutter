import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/enums/tradely_enums.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/long_short_color_identifier.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/long_short_gauge.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/data/small_data_list.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

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
    return BaseContainer(
      padding: const EdgeInsets.all(
        PaddingSizes.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Long/short trades",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14,
                ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PaddingSizes.medium,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: PaddingSizes.large,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 200,
                          maxWidth: 256,
                        ),
                        child: const LongShortGauge(),
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: LongShortColorIdentifier(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 64,
            child: SmallDataList(),
          ),
        ],
      ),
    );
  }
}
