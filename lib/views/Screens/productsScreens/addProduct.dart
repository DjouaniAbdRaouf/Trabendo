// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unused_local_variable, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/productsController.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/models/CategorieModel.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/services/productsServicesDB.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/DialogWidget.dart';
import 'package:trabendo/views/widgets/TextFormFieldGest.dart';
import 'package:trabendo/views/widgets/dropdownGest.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static String selectedCat = "";
  static String subCat = "";
  static String typeProduct = "";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  ProductController productController = Get.put(ProductController());
  TextEditingController title = TextEditingController();

  TextEditingController description = TextEditingController();

  TextEditingController price = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey();

  UserController userController = Get.find();
  bool status6 = false;
  List<File> images = [];
  final picker = ImagePicker();

  Widget getText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyleMnager.petitTextGrey,
      ),
    );
  }

  List<String> typeProductList = ["CABA", "BLED"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: "Espace des Produits"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText("Intitulé"),
                TextFormGest(
                    controller: title,
                    icon: Icons.add_box,
                    coloprefix: ColorManager.primaryColor,
                    colosuffixIcon: Colors.transparent,
                    errormessage: "chanp obligatoire",
                    hinttext: "Entrer le Nom du Produit",
                    suffixIcon: Icons.add_box),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                getText("Categorie"),
                DropDownGest(
                    ListForMapping: CategorieModel.names,
                    selectedValue: AddProductScreen.selectedCat,
                    GetSelected: (v) {
                      AddProductScreen.selectedCat = v;
                    },
                    textHint: "la categorie du produit"),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                // getText("Sous-Categorie"),
                // DropDownGest(
                //     ListForMapping: subCategorie,
                //     selectedValue: AddProductScreen.selectedCat,
                //     GetSelected: (v) {
                //       AddProductScreen.subCat = v;
                //     },
                //     textHint: "la sous categorie du produit"),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                getText("Source"),
                DropDownGest(
                    ListForMapping: typeProductList,
                    selectedValue: AddProductScreen.typeProduct,
                    GetSelected: (v) {
                      AddProductScreen.typeProduct = v;
                    },
                    textHint: "le type du produit"),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                getText("Le Prix"),
                TextFormGest(
                    controller: price,
                    icon: Icons.price_change,
                    coloprefix: ColorManager.primaryColor,
                    colosuffixIcon: Colors.transparent,
                    textInputtype: TextInputType.number,
                    errormessage: "chanp obligatoire",
                    hinttext: "Entrer le prix du Produit en D.A",
                    suffixIcon: Icons.add_box),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                SizedBox(
                  height: 200,
                  child: TextFormGest(
                      controller: description,
                      icon: Icons.description,
                      coloprefix: ColorManager.primaryColor,
                      colosuffixIcon: Colors.transparent,
                      errormessage: "chanp obligatoire",
                      textLine: 10,
                      hinttext: "Entrer une description du produit",
                      suffixIcon: Icons.description),
                ),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                Obx(() => productController.isUplaoding.value
                    ? Container()
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Choisir des photos pour votre Produit\nMax = 3",
                              style: TextStyleMnager.petitTextGreyBlack,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Vous avez choisi = ${images.length}",
                                  style: TextStyleMnager.petitTextGrey,
                                ),
                                IconButton(
                                    onPressed: () {
                                      clearListImages();
                                    },
                                    icon: Icon(
                                      Icons.recycling,
                                      color: Colors.red,
                                      size: 34,
                                    ))
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                chooseImage();
                              },
                              child: SizedBox(
                                height: 150,
                                width: 200,
                                child: LottieBuilder.asset(
                                  ImageManager.pickphotos,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                SizedBox(
                  height: PaddingManager.kheight,
                ),

                SizedBox(
                  height: PaddingManager.kheight,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Livraison Disponible  :",
                      style: TextStyleMnager.petitTextGrey,
                    ),
                    FlutterSwitch(
                      activeText: "Oui Disponible",
                      inactiveText: "Non Disponible",
                      value: status6,
                      valueFontSize: 10.0,
                      width: 110,
                      borderRadius: 30.0,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          status6 = val;
                        });
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height: PaddingManager.kheight,
                ),

                Obx(() => productController.isUplaoding.value
                    ? Center(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child:
                              LottieBuilder.asset(ImageManager.loadingLottie),
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 0.0,
                            ),
                            onPressed: () async {
                              if (globalKey.currentState!.validate()) {
                                productController.isUplaoding.value = true;
                                if (images.isNotEmpty) {
                                  var listImagesref = await ProductServiceDB()
                                      .uploadPhotos(photos: images);
                                  var idproduct = Uuid().v1();
                                  ProductsModel productsModel = ProductsModel(
                                      name: title.text.toLowerCase(),
                                      categorie: AddProductScreen.selectedCat,
                                      subCategorie: AddProductScreen.subCat,
                                      price: double.parse(price.text),
                                      photos: listImagesref!,
                                      idUser: userController
                                          .currentUserModel.value!.id,
                                      idproduct: idproduct,
                                      typeProduct: AddProductScreen.typeProduct,
                                      description: description.text,
                                      date: DateTime.now(),
                                      livrasionDispo: status6);

                                  await ProductServiceDB()
                                      .addProduct(productsModel: productsModel);
                                  productController.addproduct(productsModel);

                                  alertDialog(
                                      context: context,
                                      title: "Succès",
                                      contentType: ContentType.success,
                                      message: "Annonce publiée");
                                  title.clear();
                                  description.clear();
                                  price.clear();
                                  productController.isUplaoding.value = false;
                                } else {
                                  productController.isUplaoding.value = false;

                                  alertDialog(
                                      context: context,
                                      title: "Alert",
                                      contentType: ContentType.failure,
                                      message:
                                          "Choisir au moin une photo de votre produit");
                                }
                              }
                            },
                            // },
                            child: Text(
                              "Valider le Produit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            )),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  clearListImages() {
    setState(() {
      images.clear();
    });
  }

  chooseImage() async {
    if (images.length < 3) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          images.add(File(pickedFile.path));
        });
        if (pickedFile.path == null) retrieveLostData();
      }
    } else {
      alertDialog(
          context: context,
          title: "Alert",
          contentType: ContentType.help,
          message: "Nombre de Photos max");
    }
  }

  Future<void> retrieveLostData() async {
    LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        images.add(File(response.file!.path));
      });
    } else {
      debugPrint(response.file.toString());
    }
  }
}
