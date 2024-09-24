import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:tradelog_flutter/src/features/authentication/shared/image_carousel.dart';

class AuthScreen extends StatelessWidget {
  final Widget child;

  const AuthScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ClipRect(
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    opacity: 0.05,
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/images/static_noise.png'),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      HexColor.fromHex('#2D62FE'),
                      HexColor.fromHex('#143599'),
                    ],
                  ),
                ),
                child: const ImageCarousel(),
              ),
            ),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
