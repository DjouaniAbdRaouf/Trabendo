// ignore_for_file: file_names

import 'package:trabendo/themes.dart';

class CategorieModel {
  final String categorieName, image;

  CategorieModel(this.categorieName, this.image);

  static List<CategorieModel> mesCategories = [
    CategorieModel("Santé", ImageManager.health),
    CategorieModel("Technologies", ImageManager.technology),
    CategorieModel("Sport", ImageManager.sports),
    CategorieModel("Beauty", ImageManager.beauty),
  ];

  static var names = ["Santé", "Technologies", "Sport", "Beauty"];

  static List<String> nameCategories() {
    List<String> nameCategoriesList = [];
    for (var i = 0; i < mesCategories.length; i++) {
      nameCategoriesList[i] = mesCategories[i].categorieName;
    }
    return nameCategoriesList;
  }
}
