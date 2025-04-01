class LocalUserModel {
  int? id;
  String? username;
  String? email;
  String? password;
  String? ageGroup;
  String? gender;
  List<String>? interests;
  String? jwt; // Token (if applicable)

  LocalUserModel({
    this.id,
    this.username,
    this.email,
    this.password,
    this.ageGroup,
    this.gender,
    this.interests,
    this.jwt,
  });

  factory LocalUserModel.fromJson(Map<String, dynamic> map) {
    return LocalUserModel(
      id: map['id'] ?? 0,
      username: map['username'] ?? "Unknown",
      email: map['email'] ?? "No Email",
      password: map['password'] ?? "",
      ageGroup: map['ageGroup'] ?? "Unknown",
      gender: map['gender'] ?? "Unknown",
      interests: (map['interests'] as List<dynamic>?)
              ?.map((e) => e.toString()) // Ensures List<String>
              .toList() ??
          [], // Default to empty list instead of ""
      jwt: map['jwt'],
    );
  }

  ///  **Convert object to Map for storage**
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'ageGroup': ageGroup,
      'gender': gender,
      'interests': interests,
      'jwt': jwt,
    };
  }
}
