// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:trabendo/models/favouritModel.dart';

class FavouritServicesDB {
  CollectionReference favourite =
      FirebaseFirestore.instance.collection("favourite");

  Future<bool> addFavourite({required FavouriteModel favouriteModel}) async {
    try {
      await favourite.add({
        "idproduct": favouriteModel.idproduct,
        "idUser": favouriteModel.idUser,
        "Date": DateTime.now()
      });
      return true;
    } catch (errors) {
      debugPrint("error when adding user $errors");
      return false;
    }
  }
}
