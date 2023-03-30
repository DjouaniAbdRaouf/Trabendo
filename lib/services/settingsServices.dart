import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsServices extends GetxService {
  late SharedPreferences sharedPreferences;

  var isshowing = false.obs;
  Future<SettingsServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isshowing.value = IsShowing();
    return this;
  }

  bool IsShowing() {
    if (sharedPreferences.getBool("isshowing") == null ||
        sharedPreferences.getBool("isshowing") == false) {
      sharedPreferences.setBool("isshowing", true);
      return false;
    } else {
      return true;
    }
  }
}
