import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class NetDailyPLChart extends StatelessWidget {
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
                      "Net Daily P&L",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      backgroundColor: const Color(0xFF1B1B1B),
                      barGroups: _getBarGroups(),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 100,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value == 0
                                    ? "\$0.00"
                                    : "\$${value.toStringAsFixed(0)}",
                                style: const TextStyle(color: Color(0xffCCCCCC), fontSize: 12, fontWeight: FontWeight.w500),
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
                              final labels = ["03/09/24", "04/09/24", "05/09/24", "06/09/24"];
                              if (value.toInt() < 0 || value.toInt() >= labels.length) return const SizedBox();
                              return Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  labels[value.toInt()],
                                  style: const TextStyle(color: Color(0xff898989), fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 100, // Ensures all lines are drawn
                        getDrawingHorizontalLine: (value) {
                          return const FlLine(
                            color: Colors.white24, // Dotted line color
                            strokeWidth: 0.8,
                            dashArray: [2, 2], // Dotted line effect
                          );
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      maxY: 400,
                      minY: -400,
                    ),
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


  List<BarChartGroupData> _getBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 100,
            color: Colors.greenAccent,
            width: 25,
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 300,
            color: Colors.greenAccent,
            width: 25,
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: -200,
            color: Colors.redAccent,
            width: 25,
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 200,
            color: Colors.greenAccent,
            width: 25,
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
    ];
  }
}
