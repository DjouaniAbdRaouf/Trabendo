// ignore_for_file: file_names, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/models/user_model.dart';
import 'package:trabendo/services/productsServicesDB.dart';
import 'package:trabendo/services/userservicesDB.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductController extends GetxController {
  var isUplaoding = false.obs;
  var useruploaded = false.obs;
  var userForProduct = Rxn<UserModel>();
  var productsUserList = RxList<ProductsModel>([]);
  var searchMyProduct = "".obs;
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

  void deleteProductFromproductList({required ProductsModel productsModel}) {
    productsUserList.remove(productsModel);
    update();
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

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> sendAnSms(String phoneNumber, BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        String uri = 'sms:$phoneNumber?body=${Uri.encodeComponent("Bonjour")}';
        await launchUrl(Uri.parse(uri));
      } else if (Platform.isIOS) {
        String uri = 'sms:$phoneNumber&body=${Uri.encodeComponent("Bonjour")}';
        await launchUrl(Uri.parse(uri));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Some error occurred. Please try again!'),
        ),
      );
    }
  }

  void openWhatsapp(
      {required BuildContext context, required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp + "&text=''";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse('')}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed ")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed ")));
      }
    }
  }
}
