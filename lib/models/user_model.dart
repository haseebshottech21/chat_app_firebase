class UserModel {
  String? uid;
  String? fullName;
  String? email;
  String? profilePic;

  UserModel({
    this.uid,
    this.fullName,
    this.email,
    this.profilePic,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    fullName = map['fullname'];
    email = map['email'];
    profilePic = map['profilepic'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullname': fullName,
      'email': email,
      'profilepic': profilePic,
    };
  }
}
