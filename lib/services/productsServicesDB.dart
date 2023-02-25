// ignore_for_file: file_names, body_might_complete_normally_nullable, depend_on_referenced_packages, unused_local_variable

import 'dart:io';
// ignore: library_prefixes
import 'package:path/path.dart' as Path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:trabendo/models/productModel.dart';

class ProductServiceDB {
  CollectionReference products =
      FirebaseFirestore.instance.collection("products");

  Future<List<ProductsModel>> getAllproducts() async {
    List<ProductsModel> productList = [];
    var results = await products.get();
    if (results.docs.isNotEmpty) {
      for (var i = 0; i < results.docs.length; i++) {
        ProductsModel productsModel = ProductsModel(
            name: results.docs[i]["title"],
            categorie: results.docs[i]["categorie"],
            subCategorie: results.docs[i]["sous-cat"],
            price: results.docs[i]["price"],
            photos: results.docs[i]["photos"].cast<String>(),
            idUser: results.docs[i]["idUser"],
            idproduct: results.docs[i]["idproduct"],
            typeProduct: results.docs[i]["type"],
            description: results.docs[i]["desc"],
            date: results.docs[i]["Date"].toDate(),
            livrasionDispo: results.docs[i]["livrasionDispo"]);
        productList.add(productsModel);
      }
      return productList;
    }
    return productList;
  }

  Future<bool> addProduct({required ProductsModel productsModel}) async {
    try {
      await products.add({
        "idproduct": productsModel.idproduct,
        "idUser": productsModel.idUser,
        "title": productsModel.name,
        "desc": productsModel.description,
        "categorie": productsModel.categorie,
        "sous-cat": productsModel.subCategorie,
        "price": productsModel.price,
        "photos": productsModel.photos,
        "type": productsModel.typeProduct,
        "livrasionDispo": productsModel.livrasionDispo,
        "Date": DateTime.now()
      });
      return true;
    } catch (errors) {
      debugPrint("error when adding user $errors");
      return false;
    }
  }

  Future<List<ProductsModel>> getproductListUser(
      {required String idUser}) async {
    List<ProductsModel> productList = [];
    var results = await products.where("idUser", isEqualTo: idUser).get();
    if (results.docs.isNotEmpty) {
      for (var i = 0; i < results.docs.length; i++) {
        //    ProductsModel productsModel = ProductsModel.fromJson(results.docs[i]);
        ProductsModel productsModel = ProductsModel(
            name: results.docs[i]["title"],
            categorie: results.docs[i]["categorie"],
            subCategorie: results.docs[i]["sous-cat"],
            price: results.docs[i]["price"],
            photos: results.docs[i]["photos"].cast<String>(),
            idUser: results.docs[i]["idUser"],
            idproduct: results.docs[i]["idproduct"],
            typeProduct: results.docs[i]["title"],
            description: results.docs[i]["desc"],
            date: results.docs[i]["Date"].toDate(),
            livrasionDispo: results.docs[i]["livrasionDispo"]);
        productList.add(productsModel);
      }
      print(productList.length);
      return productList;
    }
    return productList;
  }

  Future<List<String>?> uploadPhotos({required List<File> photos}) async {
    List<String> imagesReferencesProduct = [];

    for (var i = 0; i < photos.length; i++) {
      var ref = FirebaseStorage.instance
          .ref("productsImages")
          .child(Path.basename(photos[i].path));
      await ref.putFile(photos[i]).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imagesReferencesProduct.add(value);
        });
      });
    }
    return imagesReferencesProduct;
  }
}
