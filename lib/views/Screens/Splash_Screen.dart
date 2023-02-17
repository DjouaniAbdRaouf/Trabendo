// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unused_field

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:trabendo/services/routes.dart';
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
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RouteManager.onboardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.card_giftcard,
              size: 180,
              color: ColorManager.textColor,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "T",
                  style: TextStyleMnager.lobster,
                ),
                Text(
                  "-rabendo",
                  style: TextStyleMnager.lora2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
