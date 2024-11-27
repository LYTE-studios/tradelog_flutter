import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class DataListItem extends StatelessWidget {
  final String value;

  final String label;

  final EdgeInsets? padding;

  final Color? color;

  const DataListItem({
    super.key,
    this.color,
    this.padding,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: PaddingSizes.large,
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
