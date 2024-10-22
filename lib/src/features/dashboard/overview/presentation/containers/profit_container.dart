import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ProfitContainer extends StatelessWidget {
  final int percentage;

  const ProfitContainer({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return BaseContainerExpanded(
      padding: const EdgeInsets.all(
        PaddingSizes.large,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profit Factor",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "$percentage%",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 70,
            height: 70,
            child: CircularProgressIndicator(
              value: 0.45,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              color: Theme.of(context).colorScheme.error,
              strokeCap: StrokeCap.round,
              strokeWidth: 7,
            ),
          ),
        ],
      ),
    );
  }
}
