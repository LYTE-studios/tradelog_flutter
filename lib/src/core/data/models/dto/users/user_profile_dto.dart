class UserProfileDto {
  final String email;
  final String firstName;
  final String lastName;

  const UserProfileDto({
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
      };

  UserProfileDto.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String,
        firstName = json['first_name'] as String,
        lastName = json['last_name'] as String;
}
