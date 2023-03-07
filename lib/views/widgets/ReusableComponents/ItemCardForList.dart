// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/DetailsProduct.dart';

class CardItemForList extends StatelessWidget {
  const CardItemForList({super.key, required this.productsModel});
  final ProductsModel productsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => DetailProductScreen(
            productsModel: productsModel,
          )),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18)),
                      image: DecorationImage(
                          image: NetworkImage(productsModel.photos[0]),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high)),
                ),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                Text(
                  "  ${productsModel.name}",
                  style: TextStyleMnager.petitTextGreyBlack,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                Text(
                  "  Produit :${productsModel.typeProduct}",
                  style: TextStyleMnager.petitTextGreyBlack,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "  Livraison : ",
                      style: TextStyleMnager.petitTextGreyBlack,
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
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                Text(
                  "  ${productsModel.price} DZD",
                  style: TextStyleMnager.petitTextPrimary2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
