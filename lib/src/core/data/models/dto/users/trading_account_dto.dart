import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/linked_account_block.dart';

class TradingAccountDto {
  final int id;
  final int userId;
  final String accountName;
  final double accountBalance;
  final String? cachedUntil;
  final String? accountStatus;

   TradingAccountDto({
    required this.id,
    required this.userId,
    required this.accountName,
    required this.accountBalance,
    this.cachedUntil,
    this.accountStatus
  });

  TradingAccountDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        userId = json['user_id'] as int,
        accountName = json['account_name'] as String,
        accountBalance = json['balance'] as double,
        cachedUntil = json['cached_until'] as String?,
        accountStatus = json['status'] as String;
}
