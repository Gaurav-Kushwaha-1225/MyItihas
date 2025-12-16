class UserModel {
  final String email;
  final String name;
  final String password;
  final String? avatarLink;

  UserModel({
    required this.email,
    required this.name,
    required this.password,
    this.avatarLink,
  });

  // Convert to JSON for database insertion
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password, // Note: In production, this should be hashed
      'avatar_link': avatarLink ?? '',
    };
  }

  // Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      avatarLink: json['avatar_link'] as String?,
    );
  }
}

