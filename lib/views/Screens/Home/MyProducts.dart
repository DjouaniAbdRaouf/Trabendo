// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_is_empty, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/productsController.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/ReusableComponents/MyProductItem.dart';
import 'package:trabendo/views/widgets/horLigneProfile.dart';

class MyProductScreen extends StatefulWidget {
  MyProductScreen({super.key});

  @override
  State<MyProductScreen> createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  TextEditingController searchediting = TextEditingController();
  String search = '';
  Widget _searchAndFilter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200)),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  search = value.toLowerCase();
                  searchediting.text.toLowerCase();
                });
              },
              controller: searchediting,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 26,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: ColorManager.primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Cherchez par Nom du Produit"),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());
    UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: appbarWidget(text: "Mes Produits"),
      body: Obx(() => userController.isSignIn.value
          ? SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _searchAndFilter(),
                      SizedBox(
                        height: PaddingManager.kheight,
                      ),
                      Obx(() => Text(
                            " Totale des Annonces : ${productController.productsUserList.length}",
                            style: TextStyleMnager.petitTextGreyBlack,
                          )),
                      SizedBox(
                        height: PaddingManager.kheight,
                      ),
                      GetBuilder<ProductController>(
                        init: ProductController(),
                        initState: (_) {},
                        builder: (_) {
                          return _.productsUserList.isNotEmpty
                              ? Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: ListView.builder(
                                    itemCount: _.productsUserList.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (search == "") {
                                        return MyproductItem(
                                            productsModel:
                                                _.productsUserList[index]);
                                      }
                                      if (_.productsUserList[index].name
                                          .startsWith(search)) {
                                        return MyproductItem(
                                            productsModel:
                                                _.productsUserList[index]);
                                      }
                                      return Text("");
                                    },
                                  ),
                                )
                              : Center(
                                  child: SizedBox(
                                  height: 300,
                                  width: double.infinity,
                                  child:
                                      LottieBuilder.asset(ImageManager.empty),
                                ));
                        },
                      ),
                    ],
                  )))
          : horLigneProfile(context)),
    );
  }
}
