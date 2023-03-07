// ignore_for_file: non_constant_identifier_names, file_names

class FavouriteModel {
  final String idUser, idproduct;

  FavouriteModel(this.idUser, this.idproduct);

  factory FavouriteModel.fromJson(Map<String, dynamic> data) {
    return FavouriteModel(data["idUser"], data["idproduct"]);
  }

  Map<String, dynamic> toJson() => {"idUser": idUser, "idproduct": idproduct};
}
