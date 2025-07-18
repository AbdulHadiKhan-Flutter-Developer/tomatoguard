class UserprofileModel {
  final String uid;
  final String username;
  final String useremail;
  final String userfarmingexperience;
  final String userimage;

  UserprofileModel({
    required this.uid,
    required this.username,
    required this.useremail,
    required this.userfarmingexperience,
    required this.userimage,
  });

  factory UserprofileModel.fromMap(Map<String, dynamic> data) {
    return UserprofileModel(
      uid: data['uid'] ?? '',
      username: data['username'] ?? '',
      useremail: data['useremail'] ?? '',
      userfarmingexperience: data['userfarmingexperience'] ?? '',
      userimage: data['userimage'] ?? '',
    );
  }
}
