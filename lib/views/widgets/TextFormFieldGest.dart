// ignore_for_file: prefer_const_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:trabendo/themes.dart';

class TextFormGest extends StatelessWidget {
  TextFormGest(
      {Key? key,
      required this.controller,
      required this.errormessage,
      this.icon,
      this.obscure = false,
      this.textInputtype = TextInputType.text,
      this.coloprefix,
      this.colorFill = Colors.white,
      this.colosuffixIcon,
      required this.hinttext,
      required this.suffixIcon})
      : super(key: key);

  final TextEditingController controller;
  final String errormessage;
  final IconData? icon;
  final IconData suffixIcon;
  final Color colorFill;
  final Color? colosuffixIcon;
  final Color? coloprefix;
  final String hinttext;
  TextInputType? textInputtype;
  bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorFill, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        obscureText: obscure,
        controller: controller,
        keyboardType: textInputtype,
        validator: (value) {
          if (value == "") {
            return "Champ Obligatoire";
          }
          return null;
        },
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
              borderSide:
                  BorderSide(width: 1, color: ColorManager.primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: hinttext),
      ),
    );
  }
}
