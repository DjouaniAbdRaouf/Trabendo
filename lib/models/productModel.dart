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
  final double price;
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
        subCategorie: json["sous-cat"],
        price: json["price"],
        photos: json["photos"].cast<String>(),
        idUser: json["idUser"],
        idproduct: json["idproduct"],
        typeProduct: json["type"],
        description: json["desc"],
        date: json["Date"].toDate(),
        livrasionDispo: json["livrasionDispo"]);
  }

  Map<String, dynamic> toJson(ProductsModel productsModel) {
    return {
      "idproduct": productsModel.idproduct,
      "idUser": productsModel.idUser,
      "name": productsModel.name,
      "categorie": productsModel.categorie,
      "subcategorie": productsModel.subCategorie,
      "price": productsModel.idproduct,
      "photos": productsModel.photos,
      "type": productsModel.typeProduct,
    };
  }
}
