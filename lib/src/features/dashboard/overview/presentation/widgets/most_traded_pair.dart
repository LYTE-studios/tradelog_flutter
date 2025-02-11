import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/list/flag_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MostTradedPairsScreen(),
    );
  }
}

class MostTradedPairsScreen extends StatelessWidget {
  const MostTradedPairsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // Make sure the content is properly expanded
            child: SingleChildScrollView(
              // Add scroll capability if needed
              child: _buildMostTradedPairs(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMostTradedPairs() {
    final List<Map<String, dynamic>> pairs = [
      {
        "name": "EUR/USD",
        "category": "Electronics and Technology",
        "value": "19,800",
        "percentage": 55
      },
      {
        "name": "Australia",
        "category": "Fashion, Electronics...",
        "value": "2,320",
        "percentage": 20
      },
      {
        "name": "Philippines",
        "category": "Fashion and Computer",
        "value": "9,800",
        "percentage": 25
      },
    ];

    return Column(
      children: pairs.map((item) => _buildPairRow(item)).toList(),
    );
  }

  Widget _buildPairRow(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Center align the row contents
        children: [
          _buildFlag(item["name"]), // New method for flag display
          const SizedBox(
              width: 12), // Increased from 8 to accommodate new flag size
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  item["category"],
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF666D80)),
                ),
              ],
            ),
          ),
          _buildProgressBar(item["percentage"]),
        ],
      ),
    );
  }

  Widget _buildFlag(String name) {
    switch (name) {
      case "EUR/USD":
        return const FlagOverlay();
      case "Australia":
        return Container(
          width: 35,
          height: 35,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/icons/australia.png'),
              fit: BoxFit.cover,
            ),
          ),
        );
      case "Philippines":
        return Container(
          width: 35,
          height: 35,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/icons/philippines.png'),
              fit: BoxFit.cover,
            ),
          ),
        );
      default:
        return const SizedBox(width: 35, height: 35);
    }
  }

  Widget _buildProgressBar(int percentage) {
    return SizedBox(
      width: 220, // Increased from 180 for wider overall container
      child: Column(
        children: [
          const SizedBox(height: 2), // Reduced spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "19,800",
                style: TextStyle(
                  color: Color(0xFF666D80), // Using the specified color
                  fontSize: 12, // Increased from 10
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "$percentage%",
                style: const TextStyle(
                  color: Color(0xFF666D80), // Using the specified color
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4), // Reduced from 6
          SizedBox(
            height: 30, // Increased from 35
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                28, // Reduced from 28 bars to make each bar wider
                (index) => Expanded(
                  child: Container(
                    height: 45 * 0.55, // Increased from 0.5 to make bars taller
                    margin: const EdgeInsets.symmetric(
                        horizontal: .6), // Increased from 0.5
                    decoration: BoxDecoration(
                      color: index < (percentage / 100 * 20)
                          ? const Color(0xFF4E57EF) // Primary bar color
                          : const Color(0xFF15161E), // Background bar color
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(2), // Slightly more rounded
                        bottom: Radius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
