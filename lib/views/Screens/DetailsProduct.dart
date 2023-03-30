// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, file_names, no_leading_underscores_for_local_identifiers, unused_element, unnecessary_string_interpolations

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/favouritController.dart';
import 'package:trabendo/controllers/productsController.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/models/user_model.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/productFromSpesificUser.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key, required this.productsModel});

  final ProductsModel productsModel;

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  ProductController productController = Get.put(ProductController());
  FavouriteController favouriteController = Get.put(FavouriteController());

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
                padding: EdgeInsets.symmetric(horizontal: 15),
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
                        Expanded(
                          child: Text(
                            "${widget.productsModel.price} DZD",
                            style: TextStyleMnager.petitTextPrimary2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (favouriteController.productExiste(
                                productsModel: widget.productsModel)) {
                              favouriteController.deleteFavourite(
                                  productsModel: widget.productsModel);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //     content: Text(
                              //         'Produit retiré de la liste des favoris'),
                              //   ),
                              // );
                            } else {
                              favouriteController.saveFavourite(
                                  productsModel: widget.productsModel);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //     content: Text(
                              //         'Produit ajouté à la liste des favoris'),
                              //   ),
                              // );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Obx(() => Icon(
                                  !favouriteController.productExiste(
                                          productsModel: widget.productsModel)
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: Colors.red,
                                  size: 34,
                                )),
                          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
          if (userModel.adresse != null)
            Text(
              "Adresse  : ${userModel.adresse}",
              style: TextStyleMnager.petitTextGrey,
            ),
          if (userModel.pays != null)
            Text(
              "Pays : ${userModel.pays}",
              style: TextStyleMnager.petitTextGrey,
            ),
          Text(
            "Numero de Téléphone : ${userModel.phone ?? ""}",
            style: TextStyleMnager.petitTextGrey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Contacter le vendeur : ",
                style: TextStyleMnager.petitTextGrey,
              ),
              IconButton(
                  onPressed: () {
                    productController.makePhoneCall(userModel.phone!);
                  },
                  icon: Icon(
                    Icons.call,
                    color: ColorManager.primaryColor,
                    size: 30,
                  )),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () {
                    productController.openWhatsapp(
                        context: context, number: userModel.phone!);
                  },
                  icon: Image.asset(
                    ImageManager.whatsapp,
                    width: 100,
                    height: 100,
                  )),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () {
                    productController.sendAnSms(userModel.phone!, context);
                  },
                  icon: Icon(
                    Icons.sms,
                    color: ColorManager.primaryColor,
                    size: 30,
                  )),
            ],
          ),
          SizedBox(
            height: PaddingManager.kheight,
          ),
          MaterialButton(
            onPressed: () {
              Get.to(() => ProductForSpesificUserScreen(userModel: userModel));
            },
            child: Text(
              "Produits de cet vendeur",
              style: TextStyleMnager.petitTextWithe,
            ),
            color: ColorManager.primaryColor,
          )
        ],
      ),
    );
  }
}
