import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ProfitContainer extends StatelessWidget {
  final double? factor;

  const ProfitContainer({
    super.key,
    this.factor,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: const EdgeInsets.all(
        PaddingSizes.large,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: PaddingSizes.large,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profit Factor",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 14),
              ),
              Text(
                factor?.toStringAsFixed(2) ?? "-",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 30,
                    ),
              ),
            ],
          ),
          const Spacer(),
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
