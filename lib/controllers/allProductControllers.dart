// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/services/productsServicesDB.dart';

class AllProductController extends GetxController {
  var allproductsUserList = RxList<ProductsModel>([]);
  var activeIndex = 0.obs;
  void changeIndex(int value) {
    activeIndex.value = value;
  }

  @override
  void onInit() async {
    allproductsUserList.value = await ProductServiceDB().getAllproducts();
    super.onInit();
  }
}
