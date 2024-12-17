import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class DataContainer extends StatelessWidget {
  final String title;

  final String toolTip;

  final double? value;

  final bool loading;

  const DataContainer({
    super.key,
    required this.title,
    required this.toolTip,
    this.value,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BaseDataContainer(
      title: title,
      toolTip: toolTip,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: PaddingSizes.extraSmall,
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 42,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  children: [
                    Text(
                      TradelyNumberUtils.formatNullableValuta(value),
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
