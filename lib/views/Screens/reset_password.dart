// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/services/userservicesDB.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/DialogWidget.dart';
import 'package:trabendo/views/widgets/TextFormFieldGest.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  TextEditingController pass = TextEditingController();
  TextEditingController confirmationpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: "Confidentialité"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(PaddingManager.kheight),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: LottieBuilder.asset(
                    ImageManager.resetPassword,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormGest(
                    controller: pass,
                    errormessage: "champ obligatoire",
                    hinttext: "Entrer le Mot de passe",
                    suffixIcon: Icons.password,
                    colosuffixIcon: Colors.transparent,
                    coloprefix: ColorManager.primaryColor,
                    icon: Icons.lock,
                  ),
                ),
                SizedBox(
                  height: PaddingManager.kheight2,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormGest(
                    controller: newpass,
                    errormessage: "champ obligatoire",
                    hinttext: "Entrer le Nouveau mot de passe",
                    suffixIcon: Icons.password,
                    colosuffixIcon: Colors.transparent,
                    coloprefix: ColorManager.primaryColor,
                    icon: Icons.lock,
                  ),
                ),
                SizedBox(
                  height: PaddingManager.kheight2,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormGest(
                    controller: confirmationpass,
                    errormessage: "champ obligatoire",
                    hinttext: "Confimation du nouveau mot de passe",
                    suffixIcon: Icons.password,
                    colosuffixIcon: Colors.transparent,
                    coloprefix: ColorManager.primaryColor,
                    icon: Icons.lock,
                  ),
                ),
                SizedBox(
                  height: PaddingManager.kheight2,
                ),
                Obx(() => !userController.isoasswordchanging.value
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0.0,
                            ),
                            onPressed: () async {
                              if (globalKey.currentState!.validate()) {
                                if (pass.text ==
                                    userController
                                        .currentUserModel.value!.password) {
                                  if (newpass.text.length > 6) {
                                    if (confirmationpass.text == newpass.text) {
                                      userController.isoasswordchanging.value =
                                          true;
                                      if (await UserServicesDB().resetPassword(
                                          userController
                                              .currentUserModel.value!,
                                          confirmationpass.text)) {
                                        UserServicesDB().changePassword(
                                            confirmationpass.text);
                                        userController
                                            .isoasswordchanging.value = false;
                                        alertDialog(
                                            context: context,
                                            title: "Bravo",
                                            contentType: ContentType.success,
                                            message:
                                                "votre mot de passe a été modifié avec succès");
                                      }
                                    } else {
                                      alertDialog(
                                          context: context,
                                          title:
                                              "La confirmation et le mot de passe non identique",
                                          contentType: ContentType.failure,
                                          message:
                                              "Confirmer votre mot de passe d'une façon correcte");
                                    }
                                  } else {
                                    alertDialog(
                                        context: context,
                                        title: "mot de passe trop court",
                                        contentType: ContentType.failure,
                                        message:
                                            "Vous devez entrer un mot de passe plus de 6 caractères");
                                  }
                                } else {
                                  alertDialog(
                                      context: context,
                                      title: "Mot de passe actuel non correct",
                                      contentType: ContentType.failure,
                                      message:
                                          "Vous devez entrer votre mot de passe actuel correct");
                                }
                              }
                            },
                            child: Text(
                              "Changer le Mot de Passe",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            )),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: LottieBuilder.asset(
                              ImageManager.loadingLottie,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )),
                // Obx(() => !userController.isoasswordchanging.value
                //     ? Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           SizedBox(
                //             height: 150,
                //             width: 150,
                //             child: LottieBuilder.asset(
                //               ImageManager.loadingLottie,
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ],
                //       )
                //     : Text(""))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
