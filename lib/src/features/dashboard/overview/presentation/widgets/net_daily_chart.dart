import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // Make sure the chart takes available space
            child: _buildNetDailyPLChart(),
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
        "value": 19800,
        "percentage": 55
      },
      {
        "name": "Australia",
        "category": "Fashion, Electronics...",
        "value": 2300,
        "percentage": 20
      },
      {
        "name": "Philippines",
        "category": "Fashion and Computer",
        "value": 8800,
        "percentage": 25
      },
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Most traded pairs",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: pairs.length,
              itemBuilder: (context, index) {
                final item = pairs[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item["name"],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    Text(item["category"],
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[500])),
                    const SizedBox(height: 6),
                    Stack(
                      children: [
                        Container(
                          height: 6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        Container(
                          height: 6,
                          width: (item["percentage"] as int) *
                              2.0, // Adjust bar width dynamically
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetDailyPLChart() {
    return const NetDailyChart();
  }
}

class NetDailyChart extends StatelessWidget {
  const NetDailyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        backgroundColor: Colors.transparent,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 150,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey[800]!,
              strokeWidth: 0.5,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: Colors.grey[800]!, width: 1),
            left: BorderSide(color: Colors.grey[800]!, width: 1),
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 150,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const labels = ["03/09/25", "04/09/25", "05/09/25", "06/09/25"];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    labels[value.toInt() % labels.length],
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        maxY: 300,
        minY: -150,
        barGroups: [
          _makeBarGroup(0, 250, -100),
          _makeBarGroup(1, 150, -50),
          _makeBarGroup(2, 200, -80),
          _makeBarGroup(3, 180, -120),
        ],
        barTouchData: BarTouchData(enabled: false),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 6,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.blue[400],
          width: 16,
          borderRadius: BorderRadius.zero,
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.red[400],
          width: 16,
          borderRadius: BorderRadius.zero,
        ),
      ],
    );
  }
}
