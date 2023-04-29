// ignore_for_file: file_names

import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool loginLaoding = false.obs;
  var resetPasswordloading = false.obs;
  RxBool passVisible = false.obs;
  RxBool isloadingSignup = false.obs;
}
