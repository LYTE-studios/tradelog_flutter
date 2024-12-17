import 'package:tradelog_flutter/src/core/data/models/enums/trade_enums.dart';

class TradeListItemDto {
  final TradeOption option;
  final String symbol;
  final double? quantity;
  final double? price;
  final double? profit;
  final DateTime? openTime;

  const TradeListItemDto({
    required this.option,
    required this.symbol,
    this.quantity,
    this.price,
    this.profit,
    this.openTime,
  });

  TradeListItemDto.fromJson(Map<String, dynamic> json)
      : option = (json['trade_type'] as String).toLowerCase() == 'buy'
            ? TradeOption.long
            : TradeOption.short,
        symbol = json['symbol'] as String,
        quantity = json['quantity'] as double?,
        price = json['price'] as double?,
        profit = json['profit'] as double?,
        // For now
        openTime = null;
}
