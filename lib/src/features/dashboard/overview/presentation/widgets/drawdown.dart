import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DrawdownChart extends StatelessWidget {
  const DrawdownChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 350,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B), // Dark background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Chart and Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white54, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "Drawdown",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Chart Section
                Expanded(
                  child: LineChart(
                    LineChartData(
                      minY: -400, // Minimum Y value
                      maxY: 0, // Maximum Y value
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
                            interval: 50, // Interval for left labels
                            reservedSize: 36,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 10,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 20,
                            interval: 1, // Ensures alignment with FlSpots
                            getTitlesWidget: (value, meta) {
                              final labels = [
                                "03/09/24",
                                "04/09/24",
                                "05/09/24",
                                "06/09/24"
                              ];
                              if (value.toInt() >= 0 && value.toInt() < labels.length) {
                                return Center(
                                  child: Text(
                                    labels[value.toInt()],
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: const Color(0xFF444444),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 0),
                            FlSpot(1, 0),
                            FlSpot(2, -250),
                            FlSpot(3, -300),
                          ],
                          isCurved: false,
                          color: Colors.redAccent,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false), // No dots on the line
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.redAccent.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Burger Menu Icon at the Top Right
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
}
