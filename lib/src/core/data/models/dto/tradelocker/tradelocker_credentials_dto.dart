class TradelockerCredentialsDto {
  final String email;
  final String password;
  final String server;
  final bool demoStatus;

  const TradelockerCredentialsDto({
    required this.email,
    required this.password,
    required this.server,
    required this.demoStatus,
  });

  TradelockerCredentialsDto.fromJson(Map<String, dynamic> json)
      : password = json['password'] as String,
        email = json['email'] as String,
        server = json['server'] as String,
        demoStatus = json['demo_status'] as bool;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'server': password,
        'demo_status': demoStatus,
      };
}
