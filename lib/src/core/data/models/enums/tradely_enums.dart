enum ProFrequency {
  monthly,
  yearly,
}

enum AddTradeType {
  manual,
  file,
}

enum PlanType {
  free,
  proMonthly,
  proYearly,
}

enum TradingPlatform {
  metaTrader4,
  metaTrader5,
  tradelockerDemo,
  tradelockerLive,
}

extension TradingPlatformExtension on TradingPlatform {
  String getName() {
    switch (this) {
      case TradingPlatform.metaTrader4:
        return 'MetaTrader 4';
      case TradingPlatform.metaTrader5:
        return 'MetaTrader 5';
      case TradingPlatform.tradelockerDemo:
        return 'Tradelocker Demo';
      case TradingPlatform.tradelockerLive:
        return 'Tradelocker Live';
      default:
        return '';
    }
  }
}
