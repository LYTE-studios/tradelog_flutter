import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class TextStyles {
  static Color mediumTitleColor = HexColor.fromHex("#898989");
  static Color selectedMediumTitleColor = HexColor.fromHex("#CCCCCC");

  // --------------------------------------
  // Title
  static TextStyle titleLarge = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 28,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: 17,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    height: 0.07,
    color: mediumTitleColor,
  );

  static TextStyle titleSmall = TextStyle(
    fontFamily: 'Inter',
  );

  // --------------------------------------
  // body
  static TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: 'Inter',
  );

  // --------------------------------------
  // label
  static TextStyle labelLarge = TextStyle(
    fontFamily: 'Inter',
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: 'Inter',
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: 'Inter',
  );
}
