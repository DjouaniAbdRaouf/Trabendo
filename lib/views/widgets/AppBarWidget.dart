// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabendo/themes.dart';

AppBar appbarWidget({required String text}) {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
    foregroundColor: Colors.grey.shade900,
    backgroundColor: Colors.grey.shade100,
    elevation: 0.0,
    centerTitle: true,
    title: Text(
      text,
      style: TextStyleMnager.getstyle(
          fontWeight: FontWeight.w500,
          fontsize: 22,
          color: Colors.grey.shade800),
    ),
  );
}
