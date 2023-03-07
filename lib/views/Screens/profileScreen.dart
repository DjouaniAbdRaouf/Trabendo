// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/controllers/profileController.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/services/userservicesDB.dart';
import 'package:trabendo/themes.dart';
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

  @override
  Widget build(BuildContext context) {
    email.text = userController.currentUserModel.value!.email;
    adresse.text =
        userController.currentUserModel.value!.adresse ?? "Non Défini";
    displayname.text = userController.currentUserModel.value!.displayname;
    phone.text = userController.currentUserModel.value!.phone ?? "Non defini";
    pays.text = userController.currentUserModel.value!.pays ?? "Non Défini";

    return Scaffold(
      appBar: appbarWidget(text: "Mon Profile"),
      body: Obx(() => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(PaddingManager.kheight),
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
                          child: Obx(() => profileController.edit.value
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
                  !userController.verifyValidateAccount()
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
                  SizedBox(
                    height: PaddingManager.kheight,
                  ),
                  TextFormGest(
                    colorFill: !profileController.edit.value
                        ? Colors.grey.shade100
                        : Colors.grey.shade200,
                    controller: email,
                    errormessage: "",
                    hinttext: "Email",
                    icon: Icons.email,
                    readOnly: true,
                    suffixIcon: Icons.lock_outline,
                    coloprefix: ColorManager.primaryColor,
                  ),
                  SizedBox(
                    height: PaddingManager.kheight,
                  ),
                  TextFormGest(
                    colorFill: !profileController.edit.value
                        ? Colors.grey.shade100
                        : Colors.grey.shade200,
                    controller: phone,
                    errormessage: "",
                    hinttext: "Téléphone",
                    icon: Icons.person,
                    readOnly: true,
                    suffixIcon: Icons.lock_outline,
                    coloprefix: ColorManager.primaryColor,
                  ),
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryColor,
                      ),
                      onPressed: () async {
                        if (await UserServicesDB().updateAccount(
                            userModel: userController.currentUserModel.value!,
                            pays: pays.text,
                            adresse: adresse.text,
                            displayname: displayname.text)) {
                          alertDialog(
                              context: context,
                              title: "Succès",
                              contentType: ContentType.success,
                              message: "Votre compte Trabendo Activé");
                          userController.isAccountValide.value = true;
                        } else {
                          alertDialog(
                              context: context,
                              title: "Alert",
                              contentType: ContentType.failure,
                              message: "Problème d'activation");
                        }
                      },
                      child: Text(
                        "Sauvgarder",
                        style: TextStyleMnager.petitTextWithe,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
