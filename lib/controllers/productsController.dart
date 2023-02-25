// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/models/user_model.dart';
import 'package:trabendo/services/productsServicesDB.dart';
import 'package:trabendo/services/userservicesDB.dart';

class ProductController extends GetxController {
  var isUplaoding = false.obs;
  var useruploaded = false.obs;
  var userForProduct = Rxn<UserModel>();
  var productsUserList = RxList<ProductsModel>([]);
  UserController userController = Get.put(UserController());

  void addproduct(ProductsModel productsModel) {
    productsUserList.add(productsModel);
    update();
  }

  // get the specefic user for product
  Future<UserModel?> getuserProduct({required String userID}) async {
    var user = await UserServicesDB().getUserForProduct(id: userID);
    if (user != null) {
      useruploaded.value = true;
      userForProduct.value = user;
      return user;
    }
    return null;
  }

  @override
  void onInit() async {
    if (userController.isSignIn.value) {
      productsUserList.value = await ProductServiceDB().getproductListUser(
          idUser: userController.currentUserModel.value!.id);
      update();
    }

    super.onInit();
  }
}
