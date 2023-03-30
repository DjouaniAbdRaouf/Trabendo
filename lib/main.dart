// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/controllers/allProductControllers.dart';
import 'package:trabendo/controllers/favouritController.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/services/routes.dart';
import 'package:trabendo/services/settingsServices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialSettings();
  runApp(MyApp());
}

Future initialSettings() async {
  await Get.putAsync(() => SettingsServices().init());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  UserController userController = Get.put(UserController());
  AllProductController allProductController = Get.put(AllProductController());
  FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteManager.routemanager,
      initialRoute: RouteManager.splashScreen,
      title: "Trabendo",
    );
  }
}
