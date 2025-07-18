class UserAuthModel {
  final String uId;
  final String username;
  final String email;

  UserAuthModel({
    required this.uId,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> tomap() {
    return {'uId': uId, 'username': username, 'email': email};
  }

  factory UserAuthModel.frommap(Map<String, dynamic> json) {
    return UserAuthModel(
      uId: json['uId'],
      username: json['username'],
      email: json['email'],
    );
  }
}
