class TradingAccountDto {
  final int id;
  final int userId;
  final String accountName;
  final double accountBalance;
  final String? cachedUntil;

  const TradingAccountDto({
    required this.id,
    required this.userId,
    required this.accountName,
    required this.accountBalance,
    this.cachedUntil,
  });

  TradingAccountDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        userId = json['user_id'] as int,
        accountName = json['account_name'] as String,
        accountBalance = json['balance'] as double,
        cachedUntil = json['cached_until'] as String?;
}
