class RegisterAccountDto {
  final String email;
  final String password;

  const RegisterAccountDto({
    required this.email,
    required this.password,
  });

  RegisterAccountDto.fromJson(Map<String, dynamic> json)
      : password = json['password'] as String,
        email = json['email'] as String;

  Map<String, dynamic> toJson() => {
        'username': email,
        'email': email,
        'password': password,
      };
}
