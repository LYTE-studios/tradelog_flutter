import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class ProfitContainer extends StatelessWidget {
  final double? factor;

  final double? profit;
  final double? loss;

  final bool loading;

  const ProfitContainer({
    super.key,
    this.factor,
    this.profit,
    this.loss,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    double total = (profit ?? 0) + (loss ?? 0);

    return BaseDataContainer(
      title: 'Profit Factor',
      toolTip: '',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            width: PaddingSizes.large,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                factor?.toStringAsFixed(2) ?? "-",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 30,
                    ),
              ),
            ],
          ),
          const Spacer(),
          Center(
            child: SizedBox(
              height: 56,
              width: 56,
              child: CircularProgressIndicator(
                value: total == 0 ? 0 : (profit ?? 0) / total,
                color: Theme.of(context).colorScheme.tertiary,
                backgroundColor: Theme.of(context).colorScheme.error,
                strokeCap: StrokeCap.round,
                strokeWidth: 7,
              ),
            ),
          ),
          const SizedBox(
            width: PaddingSizes.large,
          ),
        ],
      ),
    );
  }
}
