import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class LongShortColorIdentifier extends StatelessWidget {
  const LongShortColorIdentifier({super.key});

  Widget buildDot(BuildContext context, Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PaddingSizes.medium,
        vertical: PaddingSizes.extraLarge * 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              buildDot(
                context,
                Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: PaddingSizes.small,
              ),
              Text(
                "Long Trades",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: PaddingSizes.extraSmall,
          ),
          Row(
            children: [
              buildDot(
                context,
                Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(
                width: PaddingSizes.small,
              ),
              Text(
                "Short Trades",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
