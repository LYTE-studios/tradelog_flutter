import 'package:flutter/material.dart';

class FlagOverlay extends StatelessWidget {
  const FlagOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38, // Increased from 40
      height: 33, // Increased from 24
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom Flag (USA)
          Positioned(
            left: 0,
            top: 0,
            child: ClipOval(
              child: Image.asset(
                'assets/images/usd_flag.png',
                width: 28, // Increased from 20
                height: 28, // Increased from 20
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Top Flag (EU)
          Positioned(
            left: 15, // Adjusted for new sizes
            top: -12,
            child: ClipOval(
              child: Image.asset(
                'assets/images/euro_flag.png',
                width: 32, // Increased from 25
                height: 32, // Increased from 25
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
