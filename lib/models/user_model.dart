class UserModel {
  UserModel(
      {required this.id,
      required this.email,
      required this.password,
      required this.displayname,
      this.phone});

  String id;
  String displayname;
  String password;
  String email;
  String? phone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      displayname: json["displayname"],
      password: json["password"],
      email: json["email"],
      phone: json["phone"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "displayname": displayname,
        "password": password,
        "email": email,
      };
}
