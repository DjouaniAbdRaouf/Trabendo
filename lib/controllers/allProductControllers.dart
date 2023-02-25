// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/services/productsServicesDB.dart';

class AllProductController extends GetxController {
  var allproductsUserList = RxList<ProductsModel>([]);

  @override
  void onInit() async {
    allproductsUserList.value = await ProductServiceDB().getAllproducts();
    super.onInit();
  }
}
