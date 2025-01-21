import 'package:tradelog_flutter/src/core/data/models/enums/trade_enums.dart';

class TradeListItemDto {
  final TradeOption option;
  final String? symbol;
  final double? quantity;
  final double? price;
  final double? profit;
  final DateTime? openTime;
  final DateTime? closeTime;
  final double? gain;

  const TradeListItemDto({
    required this.option,
    required this.symbol,
    this.quantity,
    this.price,
    this.profit,
    this.openTime,
    this.closeTime,
    this.gain,
  });

  TradeListItemDto.fromJson(Map<String, dynamic> json)
      : option = (json['trade_type'] as String?)?.toLowerCase() == 'buy'
            ? TradeOption.long
            : TradeOption.short,
        symbol = json['symbol'] as String?,
        quantity = json['quantity'] as double?,
        price = json['price'] as double?,
        profit = json['profit'] as double?,
        openTime = DateTime.parse(json['trade_date'] as String),
        closeTime = json['close_date'] == null
            ? null
            : DateTime.tryParse(json['close_date'] as String),
        gain = json['gain'] as double?;
}
