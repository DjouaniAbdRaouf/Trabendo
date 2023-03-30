// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  final String idproduct,
      name,
      categorie,
      subCategorie,
      idUser,
      typeProduct,
      description;
  final dynamic price;
  final List<String> photos;
  final DateTime? date;
  final bool livrasionDispo;

  ProductsModel(
      {required this.name,
      required this.categorie,
      required this.subCategorie,
      required this.price,
      required this.photos,
      required this.idUser,
      required this.idproduct,
      required this.typeProduct,
      required this.description,
      this.date,
      required this.livrasionDispo});

  factory ProductsModel.fromJson(DocumentSnapshot json) {
    return ProductsModel(
        name: json["title"],
        categorie: json["categorie"],
        subCategorie: "",
        price: json["price"],
        photos: json["photos"].cast<String>(),
        idUser: json["idUser"],
        idproduct: json["idproduct"],
        typeProduct: json["type"],
        description: json["desc"],
        date: json["Date"].toDate(),
        livrasionDispo: json["livrasionDispo"]);
  }
  factory ProductsModel.fromMap(Map<String, dynamic> json) {
    return ProductsModel(
        name: json["name"],
        categorie: json["categorie"],
        subCategorie: "",
        price: json["price"],
        photos: json["photos"].cast<String>(),
        idUser: json["idUser"],
        idproduct: json["idproduct"],
        typeProduct: json["type"],
        description: json["desc"],
        //   date: json["Date"].toDate(),
        livrasionDispo: json["livrasionDispo"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "idproduct": idproduct,
      "idUser": idUser,
      "name": name,
      "desc": description,
      "categorie": categorie,
      "subcategorie": subCategorie,
      "price": price,
      "photos": photos,
      //  "Date": productsModel.date,
      "type": typeProduct,
      "livrasionDispo": livrasionDispo
    };
  }
}
