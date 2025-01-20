import 'package:tradelog_flutter/src/core/data/models/dto/users/trade_list_item_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/user_dto.dart';

class TradeListDto {
  final UserDto user;
  final List<TradeListItemDto> trades;

  const TradeListDto({
    required this.user,
    required this.trades,
  });

  TradeListDto.fromJson(Map<String, dynamic> json)
      : user = UserDto.fromJson(json['user']),
        trades = (json['trades'] as List)
            .map((account) => TradeListItemDto.fromJson(account))
            .toList();
}
