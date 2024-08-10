import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:tradelog_flutter/src/ui/theme/text_styles.dart';

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
      surface: HexColor.fromHex('#111111'),
      onSurface: HexColor.fromHex('#FFFFFF'),
      primaryContainer: HexColor.fromHex('#242424'),
      onPrimaryContainer: HexColor.fromHex('#CCCCCC'),
      secondaryContainer: HexColor.fromHex('#1A1A1A'),
      onSecondaryContainer: HexColor.fromHex('#CCCCCC'),

      /// borders
      outline: HexColor.fromHex("#1B1B1B"),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyles.titleLarge,
      titleMedium: TextStyles.titleMedium,
      titleSmall: TextStyles.titleSmall,
      bodyLarge: TextStyles.bodyLarge,
      bodyMedium: TextStyles.bodyMedium,
      bodySmall: TextStyles.bodySmall,
      labelLarge: TextStyles.labelLarge,
    ));
