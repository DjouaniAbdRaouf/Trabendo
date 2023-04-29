// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/profileController.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/services/userservicesDB.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/AccountInformation.dart';
import 'package:trabendo/views/Screens/Otp/PhoneNumberScreen.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/DialogWidget.dart';
import 'package:trabendo/views/widgets/TextFormFieldGest.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  TextEditingController displayname = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController pays = TextEditingController();

  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  ProfileController profileController = Get.put(ProfileController());
  UserController userController = Get.put(UserController());
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    displayname.text = userController.currentUserModel.value!.displayname;
    adresse.text = userController.currentUserModel.value!.adresse ?? "";
    pays.text = userController.currentUserModel.value!.pays ?? "";
    phone.text = userController.currentUserModel.value!.phone ?? "";
    email.text = userController.currentUserModel.value!.email;

    return Scaffold(
      appBar: appbarWidget(text: "Mon Profile"),
      body: Obx(() => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(PaddingManager.kheight),
              child: Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: PaddingManager.kheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Données du Profile",
                          style: TextStyleMnager.petitTextGreyBlack,
                        ),
                        InkWell(
                          onTap: () {
                            profileController.edit.value =
                                !profileController.edit.value;
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorManager.primaryColor),
                            alignment: Alignment.center,
                            child: Obx(() => !profileController.edit.value
                                ? Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 24,
                                  )
                                : Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 24,
                                  )),
                          ),
                        ),
                      ],
                    ),
                    !userController.isAccountValide.value
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: 200,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 8),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 8),
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
                      height: PaddingManager.kheight,
                    ),
                    Text(
                      "Pour Completer votre Inscription vous devez saisir les champs vides",
                      style: TextStyleMnager.petitTextGrey,
                    ),
                    SizedBox(
                      height: PaddingManager.kheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Téléphone :",
                          style: TextStyleMnager.petitTextGreyBlack,
                        ),
                        SizedBox(
                          width: PaddingManager.kheight / 2,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: PaddingManager.kheight / 2,
                              vertical: PaddingManager.kheight / 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorManager.primaryColor),
                          child: phone.text.isNotEmpty
                              ? Text(
                                  phone.text,
                                  style: TextStyleMnager.petitTextWithe,
                                )
                              : InkWell(
                                  onTap: () =>
                                      Get.to(() => PhoneNumberScreen()),
                                  child: Text(
                                    "Ajouter numéro de téléphone",
                                    style: TextStyleMnager.petitTextWithe,
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: PaddingManager.kheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Email :",
                          style: TextStyleMnager.petitTextGreyBlack,
                        ),
                        SizedBox(
                          width: PaddingManager.kheight / 2,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: PaddingManager.kheight / 2,
                              vertical: PaddingManager.kheight / 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorManager.primaryColor),
                          child: Text(
                            email.text,
                            style: TextStyleMnager.petitTextWithe,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: PaddingManager.kheight,
                    ),

                    TextFormGest(
                      colorFill: !profileController.edit.value
                          ? Colors.grey.shade100
                          : Colors.grey.shade200,
                      controller: displayname,
                      errormessage: "",
                      readOnly: profileController.edit.value,
                      hinttext: "Displayname",
                      icon: Icons.person,
                      coloprefix: ColorManager.primaryColor,
                    ),

                    // TextFormGest(
                    //   colorFill: !profileController.edit.value
                    //       ? Colors.grey.shade100
                    //       : Colors.grey.shade200,
                    //   controller: email,
                    //   errormessage: "",
                    //   hinttext: "Email",
                    //   icon: Icons.email,
                    //   readOnly: true,
                    //   suffixIcon: Icons.lock_outline,
                    //   coloprefix: ColorManager.primaryColor,
                    // ),

                    // TextFormGest(
                    //   colorFill: !profileController.edit.value
                    //       ? Colors.grey.shade100
                    //       : Colors.grey.shade200,
                    //   controller: phone,
                    //   errormessage: "",
                    //   hinttext: "Téléphone",
                    //   icon: Icons.person,
                    //   readOnly: true,
                    //   suffixIcon: Icons.lock_outline,
                    //   coloprefix: ColorManager.primaryColor,
                    // ),
                    SizedBox(
                      height: PaddingManager.kheight,
                    ),
                    TextFormGest(
                      colorFill: !profileController.edit.value
                          ? Colors.grey.shade100
                          : Colors.grey.shade200,
                      controller: adresse,
                      errormessage: "",
                      hinttext: "Adresse",
                      icon: Icons.location_city,
                      readOnly: profileController.edit.value,
                      coloprefix: ColorManager.primaryColor,
                    ),
                    SizedBox(
                      height: PaddingManager.kheight,
                    ),
                    TextFormGest(
                      colorFill: !profileController.edit.value
                          ? Colors.grey.shade100
                          : Colors.grey.shade200,
                      controller: pays,
                      errormessage: "",
                      hinttext: "Pays",
                      icon: Icons.location_searching,
                      readOnly: profileController.edit.value,
                      coloprefix: ColorManager.primaryColor,
                    ),
                    SizedBox(
                      height: PaddingManager.kheight,
                    ),
                    Obx(() => profileController.isloading.value
                        ? Center(
                            child: Center(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: LottieBuilder.asset(
                                    ImageManager.loadingLottie),
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.primaryColor,
                              ),
                              onPressed: () async {
                                if (globalKey.currentState!.validate()) {
                                  profileController.isloading(true);
                                  if (await UserServicesDB().updateAccount(
                                      userModel: userController
                                          .currentUserModel.value!,
                                      pays: pays.text,
                                      adresse: adresse.text,
                                      displayname: displayname.text)) {
                                    var varifyResult = await UserServicesDB()
                                        .verifyAccountAvailability(
                                            id: userController
                                                .currentUserModel.value!.id);
                                    if (varifyResult) {
                                      userController.isAccountValide(true);
                                    }
                                    profileController.isloading(false);

                                    alertDialog(
                                        context: context,
                                        title: "Succès",
                                        contentType: ContentType.success,
                                        message: "Modifications Sauvgardées");
                                    Get.offAll(() => AccountInformation());
                                  } else {
                                    profileController.isloading(false);

                                    alertDialog(
                                        context: context,
                                        title: "Alert",
                                        contentType: ContentType.failure,
                                        message: "Problème de connexion");
                                  }
                                }
                              },
                              child: Text(
                                "Sauvgarder",
                                style: TextStyleMnager.petitTextWithe,
                              ),
                            ),
                          ))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
