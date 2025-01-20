class LoginAccountDto {
  final String email;
  final String password;

  const LoginAccountDto({
    required this.email,
    required this.password,
  });

  LoginAccountDto.fromJson(Map<String, dynamic> json)
      : password = json['password'] as String,
        email = json['username'] as String;

  Map<String, dynamic> toJson() => {
        'username': email,
        'password': password,
      };
}
