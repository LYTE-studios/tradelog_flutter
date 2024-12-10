class AccountCredentialsDto {
  final String accessToken;
  final String refreshToken;

  const AccountCredentialsDto({
    required this.accessToken,
    required this.refreshToken,
  });

  AccountCredentialsDto.fromJson(Map<String, dynamic> json)
      : accessToken = json['access'] as String,
        refreshToken = json['refresh'] as String;

  Map<String, dynamic> toJson() => {
        'access': accessToken,
        'refresh': refreshToken,
      };
}
