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
      this.textLine = 1,
      this.colosuffixIcon,
      required this.hinttext,
      this.suffixIcon,
      this.readOnly = false})
      : super(key: key);

  final TextEditingController controller;
  final String errormessage;
  final IconData? icon;
  final IconData? suffixIcon;
  final Color colorFill;
  final Color? colosuffixIcon;
  final Color? coloprefix;
  final String hinttext;
  final int textLine;
  TextInputType? textInputtype;
  bool obscure;
  bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: colorFill, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        maxLines: textLine,
        obscureText: obscure,
        readOnly: readOnly,
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
