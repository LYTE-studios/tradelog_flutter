import 'package:tradelog_flutter/src/core/data/models/dto/meta_api/meta_api_account_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/tradelocker/tradelocker_account_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/user_dto.dart';

class TradingAccountListDto {
  final UserDto user;
  final List<TradelockerAccountDto> tradelockerAccounts;
  final List<MetaApiAccountDto> metaApiAccounts;

  const TradingAccountListDto({
    required this.user,
    required this.tradelockerAccounts,
    required this.metaApiAccounts,
  });

  TradingAccountListDto.fromJson(Map<String, dynamic> json)
      : user = UserDto.fromJson(json['user']),
        tradelockerAccounts = (json['trade_locker_accounts'] as List)
            .map((account) => TradelockerAccountDto.fromJson(account))
            .toList(),
        metaApiAccounts = (json['meta_trade_accounts'] as List)
            .map((account) => MetaApiAccountDto.fromJson(account))
            .toList();
}
