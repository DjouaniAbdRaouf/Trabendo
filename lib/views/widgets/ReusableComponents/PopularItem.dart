// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trabendo/themes.dart';

class PopularItem extends StatelessWidget {
  const PopularItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.network(
                    "https://taflout.com/pictures/listing-full/5/21.05.18.01.57-1621299469.7178-88576840.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Air Dots",
                      style: TextStyleMnager.petitTextGreyBlack,
                    ),
                    Text(
                      "2000 D.A",
                      style: TextStyleMnager.petitTextPrimary,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Icon(
                    Icons.admin_panel_settings,
                    color: ColorManager.primaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
