// ignore_for_file: prefer_const_constructors, file_names, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/controllers/productsController.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/services/productsServicesDB.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/DetailsProduct.dart';
import 'package:trabendo/views/Screens/productsScreens/updateProduct.dart';
import 'package:trabendo/views/widgets/DialogWidget.dart';

class MyproductItem extends StatelessWidget {
  const MyproductItem({
    super.key,
    required this.productsModel,
  });

  final ProductsModel productsModel;
  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());
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
            height: 220,
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
                    ),
                    SizedBox(
                      height: PaddingManager.kheight / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                contentPadding:
                                    EdgeInsets.all(PaddingManager.kheight / 2),
                                title: "Confirmation",
                                middleText:
                                    "Vous voulez Supprimer cette Annonce !",
                                cancel: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: PaddingManager.kheight),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Annuler"),
                                  ),
                                ),
                                confirm: TextButton(
                                  onPressed: () async {
                                    if (await ProductServiceDB().deleteItem(
                                        productsModel: productsModel)) {
                                      productController
                                          .deleteProductFromproductList(
                                              productsModel: productsModel);
                                      alertDialog(
                                          context: context,
                                          title: "Succès",
                                          contentType: ContentType.success,
                                          message: "Annonce supprimée");

                                      Get.back();
                                    } else {
                                      alertDialog(
                                          context: context,
                                          title: "Alert",
                                          contentType: ContentType.failure,
                                          message: "Problème de Suppression");
                                    }
                                  },
                                  child: Text("Confimer"),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.delete_sharp,
                              size: 30,
                              color: Colors.red,
                            )),
                        SizedBox(
                          width: PaddingManager.kheight / 2,
                        ),
                        IconButton(
                            onPressed: () {
                              Get.to(() => UpdateProductScreen(
                                    productsModel: productsModel,
                                  ));
                            },
                            icon: Icon(
                              Icons.update,
                              size: 30,
                              color: Colors.blueGrey,
                            )),
                      ],
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
