import 'package:flutter/material.dart';
import 'package:trabendo/themes.dart';

Widget defaultTextFormValidator(
    {required controller,
    required String errormessage,
    required IconData icon,
    bool obscure = false,
    TextInputType textInputtype = TextInputType.text,
    Color? coloprefix,
    required Function validate,
    Color colorFill = Colors.white,
    required String hinttext,
    Color? colosuffixIcon,
    required IconData suffixIcon}) {
  return TextFormField(
    obscureText: obscure,
    controller: controller,
    keyboardType: textInputtype,
    decoration: InputDecoration(
        suffixIcon: Icon(
          suffixIcon,
          color: colosuffixIcon ?? ColorManager.primaryColor,
        ),
        prefixIcon: Icon(
          icon,
          color: coloprefix ?? Colors.transparent,
          size: 26,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: ColorManager.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: hinttext),
  );
}
