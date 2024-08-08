import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';


final tradelyTheme = ThemeData(
  scaffoldBackgroundColor: HexColor.fromHex("#111111"),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: HexColor.fromHex('#2D62FE'),
    onPrimary: HexColor.fromHex('#FFFFFF'),
    secondary: HexColor.fromHex('#5FD5EC'),
    onSecondary: HexColor.fromHex('#FFFFFF'),
    tertiary: HexColor.fromHex('#14D39F'),
    error: HexColor.fromHex('#E13232'),
    onError: HexColor.fromHex('#FFFFFF'),
    surface: HexColor.fromHex('#242424'),
    onSurface: HexColor.fromHex('#CCCCCC'),
    secondaryContainer: HexColor.fromHex('#1A1A1A'),
    onSecondaryContainer:HexColor.fromHex('#CCCCCC'),
  ),
);