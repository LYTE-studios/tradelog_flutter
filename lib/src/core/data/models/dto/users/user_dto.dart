class UserDto {
  final int id;
  final String email;
  final String username;

  const UserDto({
    required this.id,
    required this.email,
    required this.username,
  });

  UserDto.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        email = json['email'] as String,
        username = json['username'] as String;
}
