import 'package:flutter/material.dart';

class FlagOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, // Fixed width for the overlay
      height: 24, // Fixed height for the overlay
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom Flag (USA)
          Positioned(
            left: 0,
            top: 0,
            child: ClipOval(
              child: Image.asset(
                'assets/images/usd_flag.png', // Replace with your image path
                width: 20, // Defined width
                height: 20, // Defined height
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Top Flag (EU) slightly overlapping
          Positioned(
            left: 12, // Adjusted for overlap
            top: -10,
            child: ClipOval(
              child: Image.asset(
                'assets/images/euro_flag.png', // Replace with your image path
                width: 25, // Defined width
                height: 25, // Defined height
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
