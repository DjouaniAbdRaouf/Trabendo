// ignore_for_file: file_names, unused_import, unused_local_variable, unused_element

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
        "displayname": userModel.displayname,
        "id": userModel.id,
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

  Future<UserModel?> getUserForProduct({required String id}) async {
    var results = await users.where("id", isEqualTo: id).get();
    if (results.docs.isNotEmpty) {
      var user = results.docs.first;
      UserModel userModel = UserModel(
          password: user["password"],
          id: user["id"],
          displayname: user["displayname"],
          email: user["email"]);
      return userModel;
    }
    return null;
  }

  void changePassword(String password) {
    //Create an instance of the current user.
    User user = FirebaseAuth.instance.currentUser!;

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) {
      debugPrint("Successfully changed password");
    }).catchError((error) {
      debugPrint("Password can't be changed$error");
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  Future<bool> resetPassword(UserModel userModel, String newPassword) async {
    try {
      var results = await users.where("id", isEqualTo: userModel.id).get();
      var docId = results.docs.first.id;
      await users.doc(docId).update({"password": newPassword});
      userController.currentUserModel.value!.password = newPassword;
      userController.storeData(userModel);
      userController.getData();
      return true;
    } catch (e) {
      debugPrint("error when adding user $e");
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
            displayname: user["displayname"],
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
