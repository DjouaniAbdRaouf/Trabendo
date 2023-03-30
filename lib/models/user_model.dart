class UserModel {
  String id;
  String displayname;
  String password;
  String email;
  String? phone, adresse, pays;

  UserModel(
      {required this.id,
      required this.email,
      required this.password,
      required this.displayname,
      this.adresse,
      this.pays,
      this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      displayname: json["displayname"],
      password: json["password"],
      email: json["email"],
      phone: json["phone"],
      adresse: json["adresse"],
      pays: json["pays"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "displayname": displayname,
        "password": password,
        "adresse": adresse,
        "phone": phone,
        "email": email,
        "pays": pays,
      };
}
