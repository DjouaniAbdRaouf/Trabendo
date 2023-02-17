// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:trabendo/themes.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    super.key,
    required this.path,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(path), fit: BoxFit.cover)),
              ),
              SizedBox(
                width: PaddingManager.kheight / 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Television Samsung ",
                    style: TextStyleMnager.getstyle(
                        fontWeight: FontWeight.bold,
                        fontsize: 20,
                        color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reference Vendeur :",
                        style: TextStyleMnager.petitTextGreyBlack,
                      ),
                      Icon(
                        Icons.admin_panel_settings,
                        color: ColorManager.primaryColor,
                        size: 35,
                      )
                    ],
                  ),
                  SizedBox(
                    height: PaddingManager.kheight / 2,
                  ),
                  Text(
                    "Djouani Abd Raouf",
                    style: TextStyleMnager.petitTextGrey,
                  ),
                  Text(
                    "Type de Produit : CABA",
                    style: TextStyleMnager.petitTextGrey,
                  ),
                  Text(
                    "Pays : France",
                    style: TextStyleMnager.petitTextGrey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
