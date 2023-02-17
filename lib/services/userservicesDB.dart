// ignore_for_file: file_names, unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/models/user_model.dart';

class UserServicesDB {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  UserController userController = Get.put(UserController());

  Future<bool> addUser({required UserModel userModel}) async {
    try {
      await users.add({
        "firstName": userModel.firstName,
        "id": userModel.id,
        "lastName": userModel.lastName,
        "password": userModel.password,
        "email": userModel.email,
        "phone": userModel.phone,
        "Date": DateTime.now()
      });
      return true;
    } catch (errors) {
      debugPrint("error when adding user $errors");
      return false;
    }
  }

  Future<bool> verifyUserLogin(
      {required String email, required String password}) async {
    try {
      var results = await users
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password)
          .get();
      if (results.docs.isNotEmpty) {
        var user = results.docs.first;
        UserModel userModel = UserModel(
            password: user["password"],
            id: user["id"],
            firstName: user["firstName"],
            lastName: user["lastName"],
            email: user["email"]);

        userController.storeData(userModel);
        userController.getData();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("error when getting data user : $e");
      return false;
    }
  }
}