// ignore_for_file: non_constant_identifier_names, must_be_immutable, file_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:trabendo/themes.dart';

class DropDownGest extends StatelessWidget {
  DropDownGest(
      {Key? key,
      required this.ListForMapping,
      required this.selectedValue,
      required this.GetSelected,
      required this.textHint})
      : super(key: key);

  final List ListForMapping;
  final String textHint;
  String selectedValue;
  Function GetSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Text(
        textHint,
        style: const TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal),
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: ColorManager.primaryColor,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        border: Border.all(color: ColorManager.primaryColor),
        borderRadius: BorderRadius.circular(15),
      ),
      items: ListForMapping.map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          )).toList(),
      validator: (value) {
        if (value == null) {
          return 'Champ Obligatoire';
        }
        return null;
      },
      onChanged: (value) {
        GetSelected(value);
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
    );
  }
}
