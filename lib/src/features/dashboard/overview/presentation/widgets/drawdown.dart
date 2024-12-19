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
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(12),
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
                const SizedBox(height: 30),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      minY: -400,
                      maxY: 0,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 50,
                        getDrawingHorizontalLine: (value) {
                          return const FlLine(
                            color: Colors.white24,
                            strokeWidth: 0.8,
                            dashArray: [2, 2],
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 50,
                            reservedSize: 60,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '\$${value.toInt().toString()}.0',
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
                            reservedSize: 25,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              final labels = [
                                "03/09/24",
                                "04/09/24",
                                "05/09/24",
                                "06/09/24",
                              ];
                              if (value >= 0 && value < labels.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
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
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 0),
                            FlSpot(1, 0),
                            FlSpot(2, 0),
                            FlSpot(3, 0),
                            FlSpot(4, -250),
                            FlSpot(5, -300),
                            FlSpot(6, -350),
                          ],
                          isCurved: false,
                          color: Colors.redAccent,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          aboveBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.redAccent.withOpacity(0.3),
                                Colors.redAccent.withOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ],
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
}