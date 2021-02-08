class UserModel {
  String name, password, email, token;

  UserModel(this.name, this.password, this.email, this.token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json["name"] ?? "",
      json["password"] ?? "",
      json["email"] ?? "",
      json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": name,
        "password": password,
        "email": email,
        "token": token,
      };
}
