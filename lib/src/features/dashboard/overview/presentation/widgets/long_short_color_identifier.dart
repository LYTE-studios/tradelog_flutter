import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/border_radii.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class LongShortColorIdentifier extends StatelessWidget {
  const LongShortColorIdentifier({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BorderRadii.extraSmall),
                ),
              ),
            ),
            const SizedBox(
              width: PaddingSizes.small,
            ),
            Text(
              "Long Trades",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        const SizedBox(
          height: PaddingSizes.small,
        ),
        Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BorderRadii.extraSmall),
                ),
              ),
            ),
            const SizedBox(
              width: PaddingSizes.small,
            ),
            Text(
              "Short Trades",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ],
    );
  }
}
