import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabendo/models/productModel.dart';

class FavouriteController extends GetxController {
  var favouriteList = RxList<ProductsModel>([]);

  late SharedPreferences sharedPreferences;

  Future<void> getfavourite() async {
    if (sharedPreferences.getString('favourite') != null) {
      String stringfavourite = sharedPreferences.getString('favourite')!;
      List favouriteListString = jsonDecode(stringfavourite);
      print(favouriteListString);
      for (var i = 0; i < favouriteListString.length; i++) {
        favouriteList.add(ProductsModel.fromMap(favouriteListString[i]));
      }
    }
  }

  void saveFavourite({required ProductsModel productsModel}) {
    favouriteList.add(productsModel);
    List items = favouriteList.map((e) => e.toJson()).toList();
    sharedPreferences.setString('favourite', jsonEncode(items));
  }

  void clearFavourite() async {
    await sharedPreferences.remove("favourite");
  }

  void deleteFavourite({required ProductsModel productsModel}) {
    favouriteList
        .removeWhere((element) => element.idproduct == productsModel.idproduct);
    List items = favouriteList.map((e) => e.toJson()).toList();
    sharedPreferences.setString('favourite', jsonEncode(items));
  }

  bool productExiste({required ProductsModel productsModel}) {
    for (var i = 0; i < favouriteList.length; i++) {
      if (favouriteList[i].idproduct == productsModel.idproduct) {
        return true;
      }
    }
    return false;
  }

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await getfavourite();
    print(favouriteList.length);
    super.onInit();
  }
}
