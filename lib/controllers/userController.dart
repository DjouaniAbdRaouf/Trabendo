// ignore_for_file: file_names

import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabendo/models/user_model.dart';

class UserController extends GetxController {
  var currentUserModel = Rxn<UserModel>();
  RxBool isSignIn = false.obs;
  late SharedPreferences sharedPreferences;
  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    super.onInit();
  }

  void storeData(UserModel userModel) async {
    String userdata = jsonEncode(userModel);
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
