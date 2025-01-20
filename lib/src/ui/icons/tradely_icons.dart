import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class TradelyIcons {
  /// PRIVATE | Base path for the icons
  static const String _basePath = 'assets/icons';
  static const String _baseLogosPath = 'assets/logos';

  /// Preloads the icon assets
  static Future<void> preload(BuildContext context) async {
    for (String icon in icons) {
      if (icon.contains('.svg')) {
        await precacheImage(
          Svg(icon),
          context,
        );
      } else {
        await precacheImage(
          AssetImage(icon),
          context,
        );
      }
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
  static const String save30 = '$_basePath/save_30.svg';
  static const String check = '$_basePath/check.svg';
  static const String x = '$_basePath/x.svg';
  static const String instagram = '$_basePath/instagram.svg';
  static const String link = '$_basePath/link.svg';
  static const String copied = '$_basePath/copied.svg';
  static const String backDialog = '$_basePath/back_dialog.svg';
  static const String refresh = '$_basePath/refresh.svg';

  // logos
  static const String tradelyLogo = '$_baseLogosPath/tradely_logo.svg';
  static const String tradelySimpleLogo =
      '$_baseLogosPath/tradely_simple_logo.svg';
  static const String tradelyLogoSmall =
      '$_baseLogosPath/tradely_logo_small.svg';
  static const String tradelyLogoInverted =
      '$_baseLogosPath/tradely_logo_inverted.svg';
  static const String tradelyLogoText = '$_baseLogosPath/tradely_logo_text.svg';
  static const String tradelyLogoPro = '$_baseLogosPath/pro.svg';
  static const String google = '$_baseLogosPath/google.svg';
  static const String apple = '$_baseLogosPath/apple.svg';

  // PNG Logos
  static const String metatrader = '$_basePath/metatrader.png';
  static const String tradelocker = '$_basePath/tradelocker.png';
  static const String cTrader = '$_basePath/c_trader.png';

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
    tradelyLogoText,
    tradelySimpleLogo,
    slash,
    tradelyLogoPro,
    google,
    apple,
    metatrader,
    tradelocker,
    save30,
    check,
    x,
    instagram,
    link,
    backDialog,
    refresh,
  ];
}
