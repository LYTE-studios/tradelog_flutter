class TradelockerAccountDto {
  final String id;
  final String accountName;
  final String currency;
  final String accNum;
  final double accountBalance;

  const TradelockerAccountDto({
    required this.id,
    required this.accountName,
    required this.currency,
    required this.accNum,
    required this.accountBalance,
  });

  TradelockerAccountDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        accountName = json['account_name'] as String,
        currency = json['currency'] as String,
        accNum = json['accNum'] as String,
        accountBalance = double.parse(json['accountBalance'] as String);
}
