import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class ProfitLossLoopRow extends StatelessWidget {
  final bool? isPositive;
  final String weekDay;
  final String? amount;

  const ProfitLossLoopRow({
    super.key,
    required this.weekDay,
    this.isPositive,
    this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (amount == null || amount!.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF232323),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 14,
                    height: 2,
                    decoration: const BoxDecoration(
                      color: Color(0xFF8A8A8A),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weekDay,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16.3,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                    child: Center(
                      child: Container(
                        width: 14,
                        height: 2,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8A8A8A),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 81,
            height: 37,
            decoration: BoxDecoration(
              color: const Color(0xFF1D1D1D),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Center(
              child: Text(
                'GET',
                style: TextStyle(
                  fontFamily: 'Phonk',
                  color: Color(0xFF5C5C5C),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isPositive == true
                    ? const Color(0xFF04261D)
                    : const Color(0xFF280909),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 11,
                  child: SvgIcon(
                    isPositive == true
                        ? TradelyIcons.trendUp
                        : TradelyIcons.trendDown,
                    color: isPositive == true
                        ? const Color(0xFF14D39F)
                        : const Color(0xFFE13232),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weekDay,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 16.3,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 14,
                      height: 7,
                      child: SvgIcon(
                        isPositive == true
                            ? TradelyIcons.trendUp
                            : TradelyIcons.trendDown,
                        color: isPositive == true
                            ? const Color(0xFF14D39F)
                            : const Color(0xFFE13232),
                      ),
                    ),
                    const SizedBox(width: 4.22),
                    Text(
                      (isPositive == true ? '+\$' : '-\$') + amount!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isPositive == true
                            ? const Color(0xFF14D39F)
                            : const Color(0xFFE13232),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 81,
          height: 37,
          decoration: BoxDecoration(
            color: const Color(0xFF0C1942),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Center(
            child: Text(
              'GET',
              style: TextStyle(
                fontFamily: 'Phonk',
                color: Color(0xFF7C9DFF),
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
