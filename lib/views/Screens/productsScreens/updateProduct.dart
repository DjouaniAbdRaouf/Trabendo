// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unused_local_variable, unnecessary_null_comparison, file_names, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
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

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.productsModel});
  static String selectedCat = "";
  static String subCat = "";
  static String typeProduct = "";
  final ProductsModel productsModel;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  ProductController productController = Get.put(ProductController());
  TextEditingController title = TextEditingController();

  TextEditingController description = TextEditingController();

  TextEditingController price = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey();

  UserController userController = Get.find();
  bool status6 = false;

  Widget getText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyleMnager.petitTextGrey,
      ),
    );
  }

  List<String> subCategorie = [
    "TV",
    "Téléphone mobile",
    "Montres",
    "Smart Watch",
  ];
  List<String> typeProductList = ["CABA", "BLED"];

  @override
  void initState() {
    title.text = widget.productsModel.name;
    description.text = widget.productsModel.description;
    price.text = widget.productsModel.price.toString();
    status6 = widget.productsModel.livrasionDispo;
    super.initState();
  }

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
                SizedBox(
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
                          if (await ProductServiceDB().updateItem(
                              userId: widget.productsModel.idUser,
                              productsId: widget.productsModel.idproduct,
                              name: title.text,
                              price: double.parse(price.text),
                              desc: description.text,
                              livraison: status6)) {
                            alertDialog(
                                context: context,
                                title: "Succès",
                                contentType: ContentType.success,
                                message: "Annonce Modifiée");
                          } else {
                            alertDialog(
                                context: context,
                                title: "Alert",
                                contentType: ContentType.failure,
                                message: "Problème de modification");
                          }
                        }
                      },
                      child: Text(
                        "Valider la Modification",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
