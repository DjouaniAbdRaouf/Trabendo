// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/services/AuthServices.dart';
import 'package:trabendo/services/routes.dart';
import 'package:trabendo/services/userservicesDB.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/Home/MyProducts.dart';
import 'package:trabendo/views/Screens/Login_Screen.dart';
import 'package:trabendo/views/Screens/Otp/PhoneNumberScreen.dart';
import 'package:trabendo/views/Screens/productsScreens/addProduct.dart';
import 'package:trabendo/views/Screens/profileScreen.dart';
import 'package:trabendo/views/Screens/reset_password.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/horLigneProfile.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
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
                                border: Border.all(width: 1),
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: AssetImage(ImageManager.avatar),
                                    fit: BoxFit.contain,
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
                !userController.isAccountValide.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          width: 200,
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.red.shade500,
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          child: Text(
                            "Inscription Incomplete",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          width: 200,
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.green.shade500,
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          child: Text(
                            "Compte Validé",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
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
                          if (!userController.isAccountValide.value) {
                            Get.to(() => PhoneNumberScreen());
                          } else {
                            Get.to(() => AddProductScreen());
                          }
                        },
                        icon: Icon(Icons.add_card),
                        label: Text(
                          "Ajouter un nouveau Produit",
                          style: TextStyleMnager.petitTextWithe,
                        ))),
                SizedBox(
                  height: PaddingManager.kheight2,
                ),
                InkWell(
                  onTap: () => Get.to(() => MyProductScreen()),
                  child: _rowInformationButton(
                    iconData: Icons.card_giftcard,
                    title: "Mes Produits",
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(() => ProfileScreen()),
                  child: _rowInformationButton(
                    iconData: Icons.account_balance,
                    title: "Profile",
                  ),
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

  @override
  void initState() {
    UserServicesDB().verifyAccountAvailability(
        id: userController.currentUserModel.value!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(text: "Mon Compte Trabendo"),
        body: Obx(() => userController.isSignIn.value
            ? _accountInformation(context: context)
            : horLigneProfile(context)));
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
