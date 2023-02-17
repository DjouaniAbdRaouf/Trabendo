// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:trabendo/themes.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "https://photos6.spartoo.com/photos/229/22977049/22977049_350_B.jpg",
                    ),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high),
              ),
            ),
            SizedBox(
              height: PaddingManager.kheight,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Survetement Sport",
                    style: TextStyleMnager.getstyle(
                        fontWeight: FontWeight.bold,
                        fontsize: 30,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: PaddingManager.kheight / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "2000 D.A",
                        style: TextStyleMnager.petitTextPrimary2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: PaddingManager.kheight / 2,
                  ),
                  Text(
                    "Les survêtements pour homme nous permettent de pratiquer notre discipline favorite avec style. De l'ensemble pantalon et veste zippée pour le football",
                    style: TextStyleMnager.petitTextGrey,
                  ),
                  SizedBox(
                    height: PaddingManager.kheight,
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
                  Text(
                    "Numero de Téléphone : +213699314941",
                    style: TextStyleMnager.petitTextPrimary,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
