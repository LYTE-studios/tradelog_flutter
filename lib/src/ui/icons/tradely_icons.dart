import 'package:flutter/material.dart';

class TradelyIcons {
  /// PRIVATE | Base path for the icons
  static const String _basePath = 'assets/icons';
  static const String _baseLogosPath = 'assets/logos';

  /// Preloads the icon assets
  static Future<void> preload(BuildContext context) async {
    for (String icon in icons) {
      await precacheImage(
        AssetImage(icon),
        context,
      );
    }
  }

  // navigation icons
  static const String account = '$_basePath/account.svg';
  static const String diary = '$_basePath/diary.svg';
  static const String myTrades = '$_basePath/my_trades.svg';
  static const String overview = '$_basePath/overview.svg';
  static const String statistics = '$_basePath/statistics.svg';

  // util icons
  static const String reset = '$_basePath/reset.svg';
  static const String search = '$_basePath/search.svg';
  static const String arrowBack = '$_basePath/arrow_back.svg';
  static const String chevronLeft = '$_basePath/chevron_left.svg';
  static const String chevronRight = '$_basePath/chevron_right.svg';
  static const String ellipsis = '$_basePath/ellipsis.svg';
  static const String ellipsisVertical = '$_basePath/ellipsis_vertical.svg';
  static const String eyeClosed = '$_basePath/eye_closed.svg';
  static const String eyeOpen = '$_basePath/eye_open.svg';

  // ui icons
  static const String trendDown = '$_basePath/trend_down.svg';
  static const String trendUp = '$_basePath/trend_up.svg';
  static const String plusCircle = '$_basePath/plus_circle.svg';
  static const String checkCircle = '$_basePath/check_circle.svg';
  static const String warning = '$_basePath/warning.svg';
  static const String infoCircle = '$_basePath/info_circle.svg';
  static const String slash = '$_basePath/slash-forward.svg';

  // logos
  static const String tradelyLogo = '$_baseLogosPath/tradely_logo.svg';
  static const String tradelyLogoSmall =
      '$_baseLogosPath/tradely_logo_small.svg';
  static const String tradelyLogoInverted =
      '$_baseLogosPath/tradely_logo_inverted.svg';
  static const String tradelyProLogo = '$_baseLogosPath/pro.svg';
  static const String google = '$_baseLogosPath/google.svg';
  static const String apple = '$_baseLogosPath/apple.svg';

  static const List<String> icons = [
    account,
    arrowBack,
    checkCircle,
    chevronLeft,
    chevronRight,
    diary,
    ellipsis,
    ellipsisVertical,
    eyeClosed,
    eyeOpen,
    infoCircle,
    myTrades,
    overview,
    plusCircle,
    reset,
    search,
    statistics,
    trendDown,
    trendUp,
    warning,
    tradelyLogo,
    tradelyLogoSmall,
    slash,
    tradelyProLogo,
    google,
    apple,
  ];
}
