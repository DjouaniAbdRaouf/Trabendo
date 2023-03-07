// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, file_names, no_leading_underscores_for_local_identifiers, unused_element, unnecessary_string_interpolations

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/productsController.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/models/user_model.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key, required this.productsModel});

  final ProductsModel productsModel;

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    productController
        .getuserProduct(userID: widget.productsModel.idUser)
        .then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: "Détails du Produit"),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 300.0,
                    autoPlay: true,
                    viewportFraction: 1,
                    enableInfiniteScroll: false),
                items: widget.productsModel.photos.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: NetworkImage(i),
                              fit: BoxFit.fitHeight,
                              filterQuality: FilterQuality.high),
                        ),
                      );
                    },
                  );
                }).toList(),
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
                      widget.productsModel.name,
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
                          "${widget.productsModel.price} DZD",
                          style: TextStyleMnager.petitTextPrimary2,
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      ],
                    ),
                    Text(
                      "Source du produit : ${widget.productsModel.typeProduct}",
                      style: TextStyleMnager.petitTextGrey,
                    ),
                    SizedBox(
                      height: PaddingManager.kheight,
                    ),
                    SizedBox(
                      height: PaddingManager.kheight / 2,
                    ),
                    Text(
                      widget.productsModel.description,
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
                  ],
                ),
              ),
              Obx(() {
                return productController.useruploaded.value
                    ? _userReferenceWidget(
                        userModel: productController.userForProduct.value!)
                    : Center(
                        child: SizedBox(
                            height: 120,
                            width: 120,
                            child: LottieBuilder.asset(
                                ImageManager.loadingLottie)),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _userReferenceWidget({required UserModel userModel}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: PaddingManager.kheight / 2,
          ),
          Text(
            userModel.displayname,
            style: TextStyleMnager.petitTextGrey,
          ),
          Text(
            "Adresse  : France paris ",
            style: TextStyleMnager.petitTextGrey,
          ),
          Text(
            "Pays : France",
            style: TextStyleMnager.petitTextGrey,
          ),
          Text(
            "Numero de Téléphone : ${userModel.phone ?? "Non Défini"}",
            style: TextStyleMnager.petitTextGrey,
          ),
        ],
      ),
    );
  }
}
