// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/DetailsProduct.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    super.key,
    required this.productsModel,
  });

  final ProductsModel productsModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => DetailProductScreen(
            productsModel: productsModel,
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(productsModel.photos[0]),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: PaddingManager.kheight / 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: PaddingManager.kheight,
                    ),
                    Row(
                      children: [
                        Text(
                          productsModel.name,
                          style: TextStyleMnager.getstyle(
                              fontWeight: FontWeight.bold,
                              fontsize: 18,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: PaddingManager.kheight / 2,
                    ),
                    Text(
                      "Type de Produit : ${productsModel.typeProduct}",
                      style: TextStyleMnager.petitTextGrey,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Categorie : ${productsModel.categorie}",
                      style: TextStyleMnager.petitTextGrey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Livraison : ",
                          style: TextStyleMnager.petitTextGrey,
                          overflow: TextOverflow.ellipsis,
                        ),
                        productsModel.livrasionDispo
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 26,
                              )
                            : Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                                size: 26,
                              )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.green.shade500,
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: Text(
                          "${productsModel.price} DZD",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
