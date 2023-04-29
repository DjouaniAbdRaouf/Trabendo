// ignore_for_file: file_names, unused_import, unused_local_variable, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/models/user_model.dart';

class UserServicesDB {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  UserController userController = Get.put(UserController());

  Future<bool> ResetPassword(
      {required String email, required BuildContext context}) async {
    try {
      if (await verifiEmailInFirestore(email: email, context: context)) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        return true;
      }

      return false;
    } on FirebaseException catch (e) {
      debugPrint("error when reseting password $e");
      return false;
    }
  }

  Future<bool> verifiEmailInFirestore(
      {required String email, required BuildContext context}) async {
    try {
      var results = await users.where("email", isEqualTo: email).get();
      if (results.docs.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email non Valide ")));
        return false;
      } else {
        return true;
      }
    } catch (e) {
      debugPrint("error when testing email $e");
      return false;
    }
  }

  Future<bool> addUser({required UserModel userModel}) async {
    try {
      await users.add({
        "displayname": userModel.displayname,
        "id": userModel.id,
        "password": userModel.password,
        "email": userModel.email,
        "phone": userModel.phone,
        "Date": DateTime.now(),
        "adresse": userModel.adresse,
        "pays": userModel.pays
      });
      return true;
    } catch (errors) {
      debugPrint("error when adding user $errors");
      return false;
    }
  }

  Future<String?> getdataforuser({required String id}) async {
    var results = await users.where("id", isEqualTo: id).get();
    if (results.docs.isNotEmpty) {
      var user = results.docs.first;
      return user["displayname"];
    }
    return null;
  }

  Future<UserModel?> getUserForProduct({required String id}) async {
    var results = await users.where("id", isEqualTo: id).get();
    if (results.docs.isNotEmpty) {
      var user = results.docs.first;
      UserModel userModel = UserModel(
          password: "",
          id: user["id"],
          pays: user["pays"],
          phone: user["phone"],
          adresse: user["adresse"],
          displayname: user["displayname"],
          email: user["email"]);
      return userModel;
    }
    return null;
  }

  Future<bool> updateAccount(
      {required UserModel userModel,
      required String pays,
      required String adresse,
      required String displayname}) async {
    var results = await users.where("id", isEqualTo: userModel.id).get();
    if (results.docs.isNotEmpty) {
      var doc = results.docs.first.id;
      try {
        await users.doc(doc).update(
            {"adresse": adresse, "displayname": displayname, "pays": pays});
        userController.currentUserModel.value!.adresse = adresse;
        userController.currentUserModel.value!.pays = pays;
        userController.currentUserModel.value!.displayname = displayname;
        userController.storeData(userController.currentUserModel.value!);
        var user = userController.getData();

        return true;
      } catch (e) {
        debugPrint("error when updating account $e");
        return false;
      }
    }
    return false;
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

  Future<bool> addPhoneNumber(String phone) async {
    try {
      var result = await users
          .where("id", isEqualTo: userController.currentUserModel.value!.id)
          .get();

      var userdoc = result.docs.first.id;
      await users.doc(userdoc).update({"phone": phone});
      userController.currentUserModel.value!.phone = phone;
      userController.storeData(userController.currentUserModel.value!);
      userController.getData();
      return true;
    } catch (e) {
      debugPrint("error$e");
      return false;
    }
  }

  Future<bool> getUserData({required String uid}) async {
    try {
      var results = await users.where("id", isEqualTo: uid).get();
      if (results.docs.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("error $e");
      return false;
    }
  }

  Future<bool> verifyAccountAvailability({required String id}) async {
    var results = await users.where("id", isEqualTo: id).get();

    if (results.docs.isNotEmpty) {
      if (results.docs.first["adresse"] == "" ||
          results.docs.first["pays"] == "" ||
          results.docs.first["phone"] == "") {
        userController.isAccountValide.value = false;
        return false;
      } else {
        userController.currentUserModel.value!.adresse =
            results.docs.first["adresse"];
        userController.currentUserModel.value!.phone =
            results.docs.first["phone"];
        userController.currentUserModel.value!.pays =
            results.docs.first["pays"];

        userController.storeData(userController.currentUserModel.value!);
        userController.getData();
        userController.isAccountValide.value = true;
        return true;
      }
    }
    return false;
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
