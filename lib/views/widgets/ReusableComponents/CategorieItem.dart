// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trabendo/models/CategorieModel.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/CategorieItems.dart';

class CategorieItem extends StatelessWidget {
  const CategorieItem({super.key, required this.categorieModel});

  final CategorieModel categorieModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => CategorieItemsScreen(
            categorie: categorieModel.categorieName,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 120,
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  categorieModel.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: PaddingManager.kheight / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  categorieModel.categorieName,
                  style: TextStyleMnager.petitTextGreyBlack,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
