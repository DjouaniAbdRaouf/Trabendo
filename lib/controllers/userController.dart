// ignore_for_file: file_names

import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabendo/models/user_model.dart';
import 'package:trabendo/services/userservicesDB.dart';

class UserController extends GetxController {
  var isoasswordchanging = false.obs;
  var currentUserModel = Rxn<UserModel>();
  var isSignIn = false.obs;
  var isAccountValide = false.obs;
  late SharedPreferences sharedPreferences;
  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await verifySession();
    if (isSignIn.value) {
      if (await UserServicesDB()
          .verifyAccountAvailability(id: currentUserModel.value!.id)) {
        isAccountValide.value = true;
      }
    }

    super.onInit();
  }

  Future<bool> verifySession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("userdata") != null) {
      getData();
      isSignIn.value = true;
      return true;
    }
    isSignIn.value = false;
    return false;
  }

  bool verifyValidateAccount() {
    if (currentUserModel.value!.adresse == null ||
        currentUserModel.value!.phone == null ||
        currentUserModel.value!.adresse == null) {
      return false;
    }
    return true;
  }

  void storeData(UserModel userModel) async {
    String userdata = jsonEncode(userModel);
    isSignIn.value = true;
    await sharedPreferences.setString("userdata", userdata);
  }

  UserModel getData() {
    String user = sharedPreferences.getString("userdata")!;
    Map<String, dynamic> userdatajson = jsonDecode(user);
    UserModel userModel = UserModel.fromJson(userdatajson);
    currentUserModel.value = userModel;
    return userModel;
  }

  void removeData() async {
    await sharedPreferences.remove("userdata");
    isSignIn.value = false;
  }
}
