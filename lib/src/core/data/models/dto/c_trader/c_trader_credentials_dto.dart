class CTraderCredentialsDto {
  final String username;
  final String password;
  final String server;
  final String accountName;

  const CTraderCredentialsDto({
    required this.username,
    required this.password,
    required this.server,
    required this.accountName,
  });

  Map<String, dynamic> toJson() => {
        'account': username,
        'password': password,
        'server': server,
        'account_name': accountName,
      };
}
