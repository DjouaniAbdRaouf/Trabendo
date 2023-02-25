// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/controllers/allProductControllers.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/services/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  UserController userController = Get.put(UserController());
  AllProductController allProductController = Get.put(AllProductController());

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
