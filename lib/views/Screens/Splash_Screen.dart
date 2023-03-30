// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/controllers/OnboardingController.dart';

import 'package:trabendo/services/routes.dart';
import 'package:trabendo/services/settingsServices.dart';
import 'package:trabendo/themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    OnboardingController onboardingController = Get.put(OnboardingController());

    _timer = Timer(const Duration(seconds: 4), () {
      SettingsServices services = Get.find();
      services.isshowing.isFalse
          ? Navigator.pushReplacementNamed(
              context, RouteManager.onboardingScreen)
          : Navigator.pushReplacementNamed(context, RouteManager.homeScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageManager.logo,
              width: MediaQuery.of(context).size.width * 0.60,
              height: 250,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            )
          ],
        ),
      ),
    );
  }
}
