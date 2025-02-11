import 'package:flutter/material.dart';

// NEW: Convert to stateful widget.
class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  // NEW: State variable for last updated time.
  String lastUpdated = "Last updated: ${_formatTime(DateTime.now())}";

  static String _formatTime(DateTime time) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return "${months[time.month - 1]} ${time.day}, ${time.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF272835)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            color: Color(0xFF666D80),
            size: 20,
          ),
          const SizedBox(width: 8),
          // Updated text to use the state variable.
          Text(
            lastUpdated,
            style: const TextStyle(
              color: Color(0xFF666D80),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () async {
              // NEW: Update the lastUpdated variable on tap.
              setState(() {
                lastUpdated = "Last updated: ${_formatTime(DateTime.now())}";
              });
              // ...additional reload logic if needed...
            },
            child: const Icon(
              Icons.sync,
              color: Color(0xFF3F82FF),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
