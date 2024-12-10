class TradelockerCredentialsDto {
  final String email;
  final String password;
  final String server;
  final bool demoStatus;
  final String accountName;

  const TradelockerCredentialsDto({
    required this.email,
    required this.password,
    required this.server,
    required this.demoStatus,
    required this.accountName,
  });

  TradelockerCredentialsDto.fromJson(Map<String, dynamic> json)
      : password = json['password'] as String,
        email = json['email'] as String,
        server = json['server'] as String,
        demoStatus = json['demo_status'] as bool,
        accountName = json['account_name'] as String;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'server': server,
        'demo_status': demoStatus,
        'account_name': accountName,
      };
}
