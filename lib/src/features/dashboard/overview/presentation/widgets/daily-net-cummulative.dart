import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyNetCumulativePLChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 350,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B), // Dark background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white54, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "Daily Net Cumulative P&L",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: LineChart(
                    _mainData(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (context) => [
                _buildPopupMenuItem("change_report", "Change Report"),
                _buildPopupMenuItem("remove_widget", "Remove Widget"),
                _buildPopupMenuItemWithSubtitle(
                  "refresh_data",
                  "Refresh Data",
                  "Data from < 1 min ago",
                ),
              ],
              icon: const Icon(Icons.more_vert, color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String value, String label) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(label),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItemWithSubtitle(
      String value, String label, String subtitle) {
    return PopupMenuItem<String>(
      value: value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }

  LineChartData _mainData() {
    final spots = const [
      FlSpot(0, 0),
      FlSpot(1, 180),
      FlSpot(2, -50),
      FlSpot(3, -70),
      FlSpot(4, -160),
      FlSpot(5, 90),
      FlSpot(6, 110),
    ];

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 50, // Ensures all lines are drawn
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white24, // Dotted line color
            strokeWidth: 0.8,
            dashArray: [2, 2], // Dotted line effect
          );
        },
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 50,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                "\$${value.toStringAsFixed(0)}",
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            interval: 1,
            getTitlesWidget: (value, meta) {
              final labels = ["03/09/24", "05/09/24", "07/09/24", "09/09/24"];
              if (value >= 0 && value < labels.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Transform.translate(
                    offset: Offset(40 + (value * 25), 0), // Adds spacing dynamically
                    child: Text(
                      labels[value.toInt()],
                        style: const TextStyle(color: Color(0xff898989), fontSize: 12, fontWeight: FontWeight.w500)
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),

        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          barWidth: 3,
          isStrokeCapRound: true,
          gradient: const LinearGradient(
            colors: [Colors.green, Colors.red],
            stops: [0.5, 0.6],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          aboveBarData: BarAreaData(
            show: true,
            applyCutOffY: true,
            cutOffY: 0.0,
            gradient: LinearGradient(
              colors: [
                Colors.redAccent.withOpacity(0.3),
                Colors.redAccent.withOpacity(0.3),
              ],
              stops: const [1.0, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.topCenter,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            applyCutOffY: true,
            cutOffY: 0.0,
            gradient: LinearGradient(
              colors: [
                Colors.greenAccent.withOpacity(0.3),
                Colors.greenAccent.withOpacity(0.3),
              ],
              stops: const [1.0, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.topCenter,
            ),
          ),
          dotData: const FlDotData(show: false),
        ),
      ],
      minY: -200,
      maxY: 200,
    );
  }

}
