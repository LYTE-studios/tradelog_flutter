import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/chart_container.dart'; // Add this import

// Update the TransparentScrollBehavior class to override more behaviors
class TransparentScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }

  @override
  bool shouldNotify(ScrollBehavior oldDelegate) => false;

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class Trade {
  final String symbol;
  final String openTime;
  final String direction;
  final double profitLoss;

  Trade({
    required this.symbol,
    required this.openTime,
    required this.direction,
    required this.profitLoss,
  });
}

class TradesList extends StatelessWidget {
  final List<Trade> trades = List.generate(
    10,
    (index) => Trade(
      symbol: 'EUR/USD',
      openTime: 'Jan 5 10:15 AM',
      direction: 'Buy',
      profitLoss: 3020,
    ),
  );

  TradesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDataContainer(
      title: 'My Trades',
      toolTip: 'Recent trades and their performance',
      titleImage: 'assets/icons/vector.png',
      onViewAllTrades: () {}, // This will trigger the View More button
      buttonText: 'View More', // Specify button text for My Trades
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(
            color: Color(0xFF666D80),
            thickness: 0.2,
          ),
          // Unified header row inside a single rounded rectangle.
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 0, vertical: 8), // increased width
            decoration: BoxDecoration(
              color: const Color(0xFF15161E),
              borderRadius: BorderRadius.circular(9),
            ),
            padding: const EdgeInsets.all(10), // reduced padding
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Symbol',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF666D80),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Open time',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF666D80),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Direction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF666D80),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'P/L',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF666D80),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Spacing between header and data rows.
          const SizedBox(height: 8),
          // Trade rows with styled scrollbar
          Expanded(
            child: RawScrollbar(
              radius: const Radius.circular(4),
              thickness: 4,
              thumbColor: const Color(0xFF666D80).withAlpha(76), // Updated from withOpacity
              trackColor: const Color(0xFF272835).withAlpha(25), // Updated from withOpacity
              trackRadius: const Radius.circular(4),
              trackVisibility: true,
              thumbVisibility: true,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: trades.length,
                itemBuilder: (context, index) {
                  final trade = trades[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 1, vertical: 6), // reduced padding
                    // Set background to transparent.
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            trade.symbol,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            trade.openTime,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            trade.direction,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: trade.direction == 'Buy'
                                  ? const Color(0xFF14D39F)
                                  : const Color(0xFFE13232),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '\$${trade.profitLoss.toStringAsFixed(0)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: trade.profitLoss >= 0
                                  ? const Color(0xFF14D39F)
                                  : const Color(0xFFE13232),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTradesChart extends StatefulWidget {
  final bool loading;
  final VoidCallback onViewAllTrades;

  const MyTradesChart({
    super.key,
    required this.loading,
    required this.onViewAllTrades,
  });

  @override
  State<MyTradesChart> createState() => _MyTradesChartState();
}

class _MyTradesChartState extends State<MyTradesChart> {
  @override
  Widget build(BuildContext context) {
    return ChartContainer(
      title: 'My Trades',
      toolTip: 'Shows your trading activity',
      loading: widget.loading,
      titleImage: 'assets/icons/chart.png',
      onViewAllTrades: widget.onViewAllTrades,
      buttonText: 'View all trades',
      child: Container(), // Add your chart content here
    );
  }
}
