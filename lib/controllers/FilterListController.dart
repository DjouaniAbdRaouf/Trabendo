// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:trabendo/controllers/allProductControllers.dart';
import '../models/productModel.dart';

class FilterController extends GetxController {
  var isFiltred = false.obs;
  var filtredList = RxList<ProductsModel>([]);
  AllProductController allProductController = Get.put(AllProductController());

  void getfiltreddata(
      {required double min, required double max, required String cat}) {
    filtredList.value = allProductController.allproductsUserList
        .where((element) =>
            element.price >= min &&
            element.price <= max &&
            element.categorie == cat)
        .toList();
  }
}
