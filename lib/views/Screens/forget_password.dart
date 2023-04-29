// ignore_for_file: must_be_immutable

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/authController.dart';
import 'package:trabendo/services/userservicesDB.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/DialogWidget.dart';
import 'package:trabendo/views/widgets/TextFormFieldGest.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  TextEditingController email = TextEditingController();
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: "Mot de passe oublié"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: PaddingManager.kheight,
              vertical: PaddingManager.kheight2),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: LottieBuilder.asset(ImageManager.forgetPass),
                ),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                TextFormGest(
                    controller: email,
                    errormessage: "Entrer un email valide",
                    hinttext: "Entrer votre email"),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryColor,
                        padding: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 0.0,
                      ),
                      onPressed: () async {
                        authController.resetPasswordloading(true);
                        var rested = await UserServicesDB()
                            .ResetPassword(email: email.text, context: context);
                        if (rested) {
                          alertDialog(
                              context: context,
                              title: 'Succès',
                              contentType: ContentType.success,
                              message: "Verifer le lien envoyé à votre email");
                        }
                      },
                      icon: Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Réinitialiser",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      )),
                ),
                Obx(() => authController.resetPasswordloading.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: LottieBuilder.asset(
                              ImageManager.loadingLottie,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                    : Text(""))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
