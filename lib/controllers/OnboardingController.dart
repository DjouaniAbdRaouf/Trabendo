// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  var isShowing = false.obs;

  @override
  void onInit() async {
    if (await onboardingShowing() == false) {
      await makeonboardingShowing();
    }
    super.onInit();
  }

  Future<bool> onboardingShowing() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("onboarding") != null) {
      isShowing.value = true;
      return true;
    }
    return false;
  }

  Future<void> makeonboardingShowing() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("onboarding", "true");
    isShowing.value = true;
  }
}
