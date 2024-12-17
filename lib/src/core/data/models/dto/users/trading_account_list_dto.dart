import 'package:tradelog_flutter/src/core/data/models/dto/meta_api/meta_api_account_dto.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/tradelocker/tradelocker_account_dto.dart';

class TradingAccountListDto {
  final List<TradelockerAccountDto> tradelockerAccounts;
  final List<MetaApiAccountDto> metaApiAccounts;

  const TradingAccountListDto({
    required this.tradelockerAccounts,
    required this.metaApiAccounts,
  });

  TradingAccountListDto.fromJson(Map<String, dynamic> json)
      : tradelockerAccounts = [] ??
            (json['trade_locker_accounts'] as List)
                .map((account) => TradelockerAccountDto.fromJson(account))
                .toList(),
        metaApiAccounts = (json['meta_accounts'] as List)
            .map((account) => MetaApiAccountDto.fromJson(account))
            .toList();
}
