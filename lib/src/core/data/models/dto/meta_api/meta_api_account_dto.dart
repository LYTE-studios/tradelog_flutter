class MetaApiAccountDto {
  final int id;
  final int userId;
  final String accountName;
  final double accountBalance;

  const MetaApiAccountDto({
    required this.id,
    required this.userId,
    required this.accountName,
    required this.accountBalance,
  });

  MetaApiAccountDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        userId = json['user_id'] as int,
        accountName = json['account_name'] as String,
        accountBalance = json['balance'] as double;
}
