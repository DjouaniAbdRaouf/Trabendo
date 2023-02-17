// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: appbarWidget(text: "Paramètres"),
      body: Center(
        child: Text(
          "Settings Screen soon ...",
          style: TextStyleMnager.lobster,
        ),
      ),
    );
  }
}
