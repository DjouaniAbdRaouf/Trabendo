// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/productsController.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/ReusableComponents/ItemCard.dart';
import 'package:trabendo/views/widgets/TextFormFieldGest.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});

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
            child: TextFormGest(
                controller: TextEditingController(),
                errormessage: "",
                icon: Icons.abc,
                colorFill: Colors.grey.shade200,
                hinttext: "Cherchez votre Produit",
                colosuffixIcon: Colors.grey.shade400,
                suffixIcon: Icons.search),
          ),
          flex: 3,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.filter_list,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());
    return Scaffold(
      appBar: appbarWidget(text: "Mes Produits"),
      body: SingleChildScrollView(
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
                            child: GridView.builder(
                              itemCount: _.productsUserList.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      childAspectRatio: 0.8),
                              itemBuilder: (BuildContext context, int index) {
                                return ItemCard(
                                    productsModel: _.productsUserList[index]);
                              },
                            ),
                          )
                        : Center(
                            child: SizedBox(
                            height: 200,
                            width: 200,
                            child:
                                LottieBuilder.asset(ImageManager.loadingLottie),
                          ));
                  },
                ),
              ],
            )),
      ),
    );
  }
}
