// ignore_for_file: file_names

import 'package:trabendo/themes.dart';

class CategorieModel {
  final String categorieName, image;

  CategorieModel(this.categorieName, this.image);

  static List<CategorieModel> mesCategories = [
    CategorieModel("Cuisine & Maison", ImageManager.home),
    CategorieModel("Accessoires", ImageManager.accessories),
    CategorieModel("vêtements", ImageManager.suits),
    CategorieModel("Bébé et Puériculture", ImageManager.bebe),
    CategorieModel("Santé", ImageManager.health),
    CategorieModel("Technologies", ImageManager.technology),
    CategorieModel("Sport", ImageManager.sports),
    CategorieModel("Beauty", ImageManager.beauty),
    CategorieModel("automobile et Pièces", ImageManager.cars),
    CategorieModel("Autres", ImageManager.other),
  ];

  static var names = [
    "Santé",
    "Technologies",
    "Sport",
    "beauté",
    "Cuisine & Maison",
    "Bébé et Puériculture",
    "vêtements",
    "Accessoires",
    "automobile et Pièces",
    "Autres"
  ];

  static List<String> nameCategories() {
    List<String> nameCategoriesList = [];
    for (var i = 0; i < mesCategories.length; i++) {
      nameCategoriesList[i] = mesCategories[i].categorieName;
    }
    return nameCategoriesList;
  }
}
