import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';

class DataContainer extends StatelessWidget {
  final String title;
  final String toolTip;
  final double? value;
  final bool loading;
  final bool isPercentage;
  final int iconNumber; // 1-4 for different icons
  final bool isPositive; // For determining green/red colors

  const DataContainer({
    super.key,
    required this.title,
    required this.toolTip,
    this.value,
    this.loading = false,
    this.isPercentage = false,
    required this.iconNumber,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6), // Reduced margin to make boxes bigger
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 16), // Increased padding
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF272835),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and Title in a Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon on the left
              Container(
                padding: EdgeInsets.zero,
                child: Image.asset(
                  'assets/icons/Icon ($iconNumber).png',
                  width: 37,
                  height: 37,
                ),
              ),
              const SizedBox(height: 8), // Space between icon and title
              // Title below icon
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF666D80),
                  fontSize: 14,
                  fontWeight: FontWeight.normal, // Changed from w500 to normal
                ),
              ),
            ],
          ),
          const Spacer(),
          // Value and percentage indicator
          Row(
            children: [
              Expanded(
                child: Text(
                  isPercentage
                      ? '${value?.toStringAsFixed(1) ?? '0'} %'
                      : TradelyNumberUtils.formatNullableValuta(value),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.normal, // Changed from w600 to normal
                  ),
                ),
              ),
              // Percentage indicator box
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive
                      ? const Color(0xFF14D39F).withOpacity(0.1)
                      : const Color(0xFFE13232).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 14,
                      color: isPositive
                          ? const Color(0xFF14D39F)
                          : const Color(0xFFE13232),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '10.5%',
                      style: TextStyle(
                        color: isPositive
                            ? const Color(0xFF14D39F)
                            : const Color(0xFFE13232),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
