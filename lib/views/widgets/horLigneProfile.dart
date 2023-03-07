import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/Login_Screen.dart';

Widget horLigneProfile(BuildContext context) {
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
                  "vous devez Inscriver pour ètre un membre avec\nTrabendo",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primaryColor,
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0.0,
                  ),
                  onPressed: () async {
                    Get.to(() => LoginScreen());
                  },
                  child: const Text(
                    "Connecter",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  )),
            ),
            SizedBox(
              height: PaddingManager.kheight,
            )
          ],
        ),
      ),
    ),
  );
}
