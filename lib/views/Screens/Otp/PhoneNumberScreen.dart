// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:trabendo/services/routes.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});

  Widget _buidTextIntro() {
    return Column(
      children: [
        Text(
          "Votre Numéro de Téléphone mobile",
          style: TextStyleMnager.getstyle(
              fontWeight: FontWeight.bold, fontsize: 24, color: Colors.black),
        ),
        SizedBox(
          height: PaddingManager.kheight + 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: PaddingManager.kheight),
          child: Text(
            "Entrer Votre Numéro de Téléphone pour verifier votre Compte",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        )
      ],
    );
  }

  Widget _buildPhoneFormField() {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              height: 70,
              child: IntlPhoneField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.phone_android,
                      color: ColorManager.primaryColor,
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.transparent,
                      size: 26,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorManager.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Numéro de Téléphone"),
                initialCountryCode: 'DZ',
                onChanged: (phone) {},
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: PaddingManager.kheight2,
              ),
              _buidTextIntro(),
              SizedBox(
                height: PaddingManager.kheight3,
              ),
              _buildPhoneFormField(),
              SizedBox(
                height: PaddingManager.kheight3,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16)),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouteManager.phoneVerification);
                      },
                      child: Text(
                        "Suivant",
                        style: TextStyleMnager.petitTextWithe,
                      )),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
