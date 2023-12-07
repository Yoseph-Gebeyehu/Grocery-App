class User {
  String? userName;
  String? email;
  String? password;

  User({
    this.userName,
    this.email,
    this.password,
  });

  User.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userName'] = userName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
