import 'package:tradelog_flutter/src/core/data/models/dto/users/trading_account_dto.dart';

class TradingAccountListDto {
  final List<TradingAccountDto> accounts;

  const TradingAccountListDto({
    required this.accounts,
  });

  TradingAccountListDto.fromJson(Map<String, dynamic> json)
      : accounts = (json['accounts'] as List?)
                ?.map((account) => TradingAccountDto.fromJson(account))
                .toList() ??
            [];
}
