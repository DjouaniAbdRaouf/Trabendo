class UserModel {
  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      this.phone});

  String id;
  String firstName;
  String password;
  String lastName;
  String email;
  String? phone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      password: json["password"],
      email: json["email"],
      phone: json["phone"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "email": email,
      };
}
