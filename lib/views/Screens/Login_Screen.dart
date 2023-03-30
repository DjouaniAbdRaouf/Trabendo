// ignore_for_file: prefer_const_constructors, implementation_imports, prefer_const_literals_to_create_immutables, file_names, use_build_context_synchronously, must_be_immutable, body_might_complete_normally_nullable

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/authController.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/models/user_model.dart';
import 'package:trabendo/services/AuthServices.dart';
import 'package:trabendo/services/routes.dart';
import 'package:trabendo/services/userservicesDB.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/Home/HomeScreen.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/DialogWidget.dart';
import 'package:trabendo/views/widgets/TextFormFieldGest.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  AuthController authController = Get.put(AuthController());
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: "Connexion"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PaddingManager.kheight),
          child: Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: PaddingManager.kheight2,
                  ),
                  Text(
                    "Email",
                    style: TextStyleMnager.petitTextGreyBlack,
                  ),
                  SizedBox(
                    height: PaddingManager.kheight / 2,
                  ),
                  TextFormGest(
                      colorFill: Colors.grey.shade100,
                      controller: email,
                      coloprefix: ColorManager.primaryColor,
                      errormessage: "Champs Obligatoire",
                      icon: Icons.email,
                      colosuffixIcon: Colors.transparent,
                      suffixIcon: Icons.admin_panel_settings,
                      hinttext: "Entrer votre Email"),
                  SizedBox(
                    height: PaddingManager.kheight,
                  ),
                  Text(
                    "Mot de Passe",
                    style: TextStyleMnager.petitTextGreyBlack,
                  ),
                  SizedBox(
                    height: PaddingManager.kheight / 2,
                  ),
                  Obx(() => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade100),
                        child: TextFormField(
                          controller: password,
                          validator: (val) {
                            if (val == "") {
                              return "Champ Obligatoire";
                            }
                          },
                          obscureText: authController.passVisible.value,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () {
                                    authController.passVisible.value =
                                        !authController.passVisible.value;
                                  },
                                  child: Icon(authController.passVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              prefixIcon: Icon(
                                Icons.password,
                                color: ColorManager.primaryColor,
                                size: 26,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: "Mot de Passe"),
                        ),
                      )),
                  SizedBox(
                    height: PaddingManager.kheight,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primaryColor,
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0.0,
                        ),
                        onPressed: () async {
                          // with email and password
                          if (globalKey.currentState!.validate()) {
                            authController.loginLaoding.value = true;
                            var userCredential = await AuthServices().signin(
                                email: email.text.trim(),
                                password: password.text);
                            if (userCredential != null) {
                              if (await UserServicesDB()
                                  .getUserData(uid: userCredential.user!.uid)) {
                                var displayname = await UserServicesDB()
                                    .getdataforuser(
                                        id: userCredential.user!.uid);

                                if (displayname != null) {
                                  UserModel userModel = UserModel(
                                    id: userCredential.user!.uid,
                                    email: userCredential.user!.email!,
                                    password: "",
                                    phone: "",
                                    pays: "",
                                    adresse: "",
                                    displayname: displayname,
                                  );
                                  UserServicesDB().verifyAccountAvailability(
                                      id: userCredential.user!.uid);
                                  userController.storeData(userModel);
                                  userController.getData();
                                  Get.to(() => HomeScreen());
                                  alertDialog(
                                      context: context,
                                      contentType: ContentType.success,
                                      title: "Conexion réussite",
                                      message: "Vous ètes les Bienvenus");
                                  authController.loginLaoding.value = false;
                                  userController.isSignIn.value = true;
                                }
                              }
                            } else {
                              email.clear();
                              password.clear();
                              authController.loginLaoding.value = false;

                              alertDialog(
                                  context: context,
                                  contentType: ContentType.failure,
                                  title: "Verifier vos Informations",
                                  message: "reésseyer autre fois");
                            }
                          }
                        },
                        child: Text(
                          "Connecter",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        )),
                  ),
                  SizedBox(
                    height: PaddingManager.kheight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Ou",
                          style: TextStyleMnager.petitTextGrey,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: PaddingManager.kheight / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 0.0,
                              ),
                              onPressed: () {
                                AuthServices().signInWithGoogle(context);

                                Get.to(() => HomeScreen());
                              },
                              icon: SvgPicture.asset(
                                ImageManager.googleIcons,
                                height: 25,
                                width: 25,
                              ),
                              label: Text("Google",
                                  style: TextStyleMnager.petitTextGrey)),
                        ),
                      ),
                      SizedBox(
                        width: PaddingManager.kheight / 2,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 0.0,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteManager.registerScreen);
                              },
                              icon: Icon(
                                Icons.mail,
                                color: Colors.blue,
                              ),
                              // icon: SvgPicture.asset(
                              //   ImageManager.phoneIcons,
                              //   height: 25,
                              //   width: 25,
                              // ),
                              label: Text("Email",
                                  style: TextStyleMnager.petitTextGrey)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: PaddingManager.kheight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Si vous n'avais pas un compte",
                        style: TextStyleMnager.petitTextGrey,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteManager.registerScreen);
                          },
                          child: Text(
                            "Inscriver Vous",
                            style: TextStyleMnager.petitTextPrimary,
                          ))
                    ],
                  ),
                  Obx(() => authController.loginLaoding.value
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
              )),
        ),
      ),
    );
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: PaddingManager.kheight),
    //       child: Form(
    //         key: globalKey,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [

    //           ],
    //         ),
    //       ),
    //     ),
    //   ),

    // );
  }
}
