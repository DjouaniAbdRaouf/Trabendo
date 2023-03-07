// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/DetailsProduct.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.productsModel});

  final ProductsModel productsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => DetailProductScreen(
            productsModel: productsModel,
          )),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          elevation: 6.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 220,
            width: 160,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(productsModel.photos[0]),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover)),
                  height: 100,
                  width: 140,
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                Text(
                  productsModel.name,
                  style: TextStyleMnager.petitTextGreyBlack,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${productsModel.price} DZD",
                        style: TextStyleMnager.petitTextPrimary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    productsModel.typeProduct == "CABA"
                        ? Text(
                            "Produit Etranger",
                            style: TextStyleMnager.petitTextGrey,
                          )
                        : Text(
                            "Produit du BLED",
                            style: TextStyleMnager.petitTextGrey,
                          ),
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
