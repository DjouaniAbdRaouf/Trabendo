// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/favouritController.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/emptyCategory.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/ReusableComponents/ItemCard.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: "Liste des favoris"),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Obx(() => favouriteController.favouriteList.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 0.8),
                          itemBuilder: (context, index) {
                            return ItemCard(
                                productsModel:
                                    favouriteController.favouriteList[index]);
                          },
                          itemCount: favouriteController.favouriteList.length,
                        ),
                      )
                    : EmptyCategory(title: "Aucun Produit"))
              ],
            )),
      ),
    );
  }
}
