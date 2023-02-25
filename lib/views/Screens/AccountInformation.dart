// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/services/AuthServices.dart';
import 'package:trabendo/services/routes.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/productsScreens/addProduct.dart';
import 'package:trabendo/views/Screens/reset_password.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';

class AccountInformation extends StatelessWidget {
  AccountInformation({super.key});
  UserController userController = Get.put(UserController());

  Widget _accountInformation({required BuildContext context}) {
    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: AssetImage(ImageManager.avatar),
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high)),
                          ),
                          Positioned(
                            bottom: 3,
                            right: 3,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                Text(
                  userController.currentUserModel.value!.displayname,
                  style: TextStyleMnager.petitTextGreyBlack,
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                Text(
                  userController.currentUserModel.value!.email,
                  style: TextStyleMnager.petitTextGrey,
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          Get.to(() => AddProductScreen());
                        },
                        icon: Icon(Icons.add_card),
                        label: Text(
                          "Ajouter un nouveau Produit",
                          style: TextStyleMnager.petitTextWithe,
                        ))),
                SizedBox(
                  height: PaddingManager.kheight2,
                ),
                _rowInformationButton(
                  iconData: Icons.card_giftcard,
                  title: "Mes Produits",
                ),
                _rowInformationButton(
                  iconData: Icons.account_balance,
                  title: "Profile",
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => ResetPassword());
                  },
                  child: _rowInformationButton(
                    iconData: Icons.info,
                    title: "Confidentialité",
                  ),
                ),
                _rowInformationButton(
                  iconData: Icons.settings,
                  title: "Paramètres",
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                InkWell(
                  onTap: () {
                    AuthServices().logout();
                    userController.removeData();
                    Navigator.pushReplacementNamed(
                        context, RouteManager.homeScreen);
                  },
                  child: _rowInformationButton(
                    iconData: Icons.logout,
                    title: "Deconnecter",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _horLigneProfile(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                height: 300,
                width: double.infinity,
                child: LottieBuilder.asset(
                  ImageManager.horligneprofile,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "vous ètes en mode hors ligne !",
                  style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 33,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "vous devez Inscriver pour ètre un membre avec",
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0.0,
                    ),
                    onPressed: () async {
                      Navigator.pushNamed(context, RouteManager.loginScreen);
                    },
                    child: Text(
                      "Connecter",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(text: "Mon Compte Trabendo"),
        body: Obx(() => userController.isSignIn.value
            ? _accountInformation(context: context)
            : _horLigneProfile(context)));
  }

  Widget _rowInformationButton({
    required String title,
    required IconData iconData,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade200),
            height: 40,
            width: 40,
            child: Icon(iconData),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: TextStyleMnager.petitTextGrey,
          ),
          Spacer(),
          Icon(
            Icons.arrow_right,
            color: Colors.grey,
            size: 30,
          )
        ],
      ),
    );
  }
}
