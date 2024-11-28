import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/features/dashboard/leaderboard/models/leaderboard_entry.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class CurrencyPairDisplay extends StatelessWidget {
  final String currencyPair;
  final double exchangeRate;

  const CurrencyPairDisplay({
    Key? key,
    required this.currencyPair,
    required this.exchangeRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currencyImg = currencyPair.toLowerCase().split('/');
    return Container(
      // width: 150.0,
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.white24),
          borderRadius: BorderRadius.circular(24.0)),
      padding: EdgeInsets.only(top: 8.0),
      height: 70,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Row(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.circular(20.0)),
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundImage: AssetImage(
                    'assets/icons/nation/' + currencyImg[0] + ".png",
                  ),
                ),
              ),
              Transform(
                  transform: Matrix4.translationValues(-16.0, -16.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: CircleAvatar(
                      radius: 14.0,
                      backgroundImage: AssetImage(
                        'assets/icons/nation/' + currencyImg[1] + ".png",
                      ),
                    ),
                  ))
            ]),
          ),

          // Expanded(
          Transform(
            transform: Matrix4.translationValues(-16.0, -6.0, 0.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      currencyPair,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // const SizedBox(height: 4.0),
                  Row(
                    children: [
                      SvgIcon(
                        TradelyIcons.arrowDown,
                        color: (exchangeRate > 0)
                            ? colorScheme.tertiary
                            : colorScheme.error,
                      ),
                      Text(
                        '\$${exchangeRate.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: (exchangeRate > 0)
                              ? colorScheme.tertiary
                              : colorScheme.error,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
