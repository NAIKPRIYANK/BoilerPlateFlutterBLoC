class UserModel {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String ageGroup;
  final String gender;
  final List<String> interests;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.ageGroup,
    required this.gender,
    required this.interests,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'ageGroup': ageGroup,
      'gender': gender,
      'interests': interests.join(','), // Store interests as a comma-separated string
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      ageGroup: map['ageGroup'],
      gender: map['gender'],
      interests: (map['interests'] as String).split(','), 
    );
  }
}
