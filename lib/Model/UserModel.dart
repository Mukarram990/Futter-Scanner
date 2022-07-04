class UserModel {
  String? username;
  String? email;
  String? pass;

  UserModel({this.username, this.email, this.pass});

  factory UserModel.fromMap(map) {
    return UserModel(
      username: map['username'],
      email: map['email'],
      pass: map['pass'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'pass': pass,
    };
  }
}
