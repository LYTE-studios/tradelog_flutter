import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class TradeActivityListItem extends StatelessWidget {
  // final String avatar;
  final String name;
  final String currencyPair;
  final double exchangeRate;
  final int moment;

  const TradeActivityListItem({
    Key? key,
    // required this.avatar,
    required this.name,
    required this.currencyPair,
    required this.exchangeRate,
    required this.moment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currencyImg = currencyPair.split('/');
    final up = exchangeRate > 0 ? true : false;
    if (currencyImg.length < 2) {
      return Text("Invalid currency pair");
    }

    return Stack(children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: const Color.fromARGB(160, 29, 29, 29),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
              child: CircleAvatar(
                // backgroundImage: NetworkImage(
                //   // Replace with your image URL
                //   avatar,
                // ),
                radius: 24,
              ),
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "$name traded",
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   child: Text("$moment ago",
                    //       style: const TextStyle(
                    //           fontSize: 10.0, color: Colors.white24)),
                    // )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 12.0,
                          backgroundImage: AssetImage(
                            'assets/icons/nation/${currencyImg[0]}.png',
                          ),
                        ),
                        Positioned(
                          left: 12.0,
                          child: CircleAvatar(
                            radius: 12.0,
                            backgroundImage: AssetImage(
                              'assets/icons/nation/${currencyImg[1]}.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 18.0),
                    Text(
                      "|",
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 18.0),
                    ),
                    const SizedBox(width: 6.0),
                    up
                        ? SvgIcon(
                            TradelyIcons.trendUp,
                            color: colorScheme.tertiary,
                            size: 10.0,
                          )
                        : SvgIcon(
                            TradelyIcons.trendDown,
                            color: colorScheme.error,
                            size: 10.0,
                          ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "${exchangeRate.abs()}",
                      style: TextStyle(
                          color: (exchangeRate > 0)
                              ? colorScheme.tertiary
                              : colorScheme.error,
                          fontSize: 12.0),
                    ),
                  ],
                ),
              ],
            ),
            // Text("$moment ago",
            //     style: const TextStyle(fontSize: 10.0, color: Colors.white24))
          ],
        ),
      ),
      Positioned(
        right: 24,
        top: 8,
        child: Text(
          "${moment / 60}m ago",
          style: TextStyle(fontSize: 12.0),
        ),
      )
    ]);
  }
}
