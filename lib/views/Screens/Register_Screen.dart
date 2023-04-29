// ignore_for_file: prefer_const_constructors, implementation_imports, prefer_const_literals_to_create_immutables, file_names, must_be_immutable, use_build_context_synchronously, unused_local_variable

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController username = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  UserController userController = Get.put(UserController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(text: "Inscription"),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingManager.kheight),
            child: Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: PaddingManager.kheight,
                  ),

                  Text(
                    "Email",
                    style: TextStyleMnager.petitTextGreyBlack,
                  ),
                  SizedBox(
                    height: PaddingManager.kheight / 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade100),
                    child: TextFormField(
                      controller: email,
                      validator: (val) {
                        if (val == "") {
                          return "Champ Obligatoire";
                        }
                        // if (!AuthServices().validateEmail(val!)) {
                        //   return "Email non Valide";
                        // }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: ColorManager.primaryColor,
                            size: 26,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: "Entrer votre Email"),
                    ),
                  ),

                  // TextFormGest(
                  //     colorFill: Colors.grey.shade100,
                  //     controller: email,
                  //     errormessage: "Champs Obligatoire",
                  //     icon: Icons.email,
                  //     suffixIcon: Icons.admin_panel_settings,
                  //     hinttext: "Entrer votre Email"),
                  SizedBox(
                    height: PaddingManager.kheight,
                  ),
                  Text(
                    "Nom d'utilisateur",
                    style: TextStyleMnager.petitTextGreyBlack,
                  ),
                  SizedBox(
                    height: PaddingManager.kheight / 2,
                  ),
                  TextFormGest(
                      colorFill: Colors.grey.shade100,
                      controller: username,
                      coloprefix: ColorManager.primaryColor,
                      errormessage: "Champs Obligatoire",
                      icon: Icons.person,
                      suffixIcon: Icons.admin_panel_settings,
                      colosuffixIcon: Colors.transparent,
                      hinttext: "Entrer votre Nom d'utilisateur"),
                  SizedBox(
                    height: PaddingManager.kheight,
                  ),

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
                            } else if (val!.length <= 8) {
                              return "Mot de passe doit ètre au moins 8 caractères";
                            }
                          },
                          obscureText: authController.isloadingSignup.value,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: () {
                                    authController.isloadingSignup.value =
                                        !authController.isloadingSignup.value;
                                  },
                                  child: Icon(
                                      authController.isloadingSignup.value
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
                          if (globalKey.currentState!.validate()) {
                            var uuid = Uuid();
                            authController.isloadingSignup.value = true;

                            var userCredential = await AuthServices().signup(
                                email: email.text, password: password.text);
                            if (userCredential != null) {
                              UserModel userModel = UserModel(
                                  id: userCredential.user!.uid,
                                  password: password.text.trim(),
                                  displayname: username.text,
                                  pays: "",
                                  adresse: "",
                                  phone: "",
                                  email: email.text.trim());
                              if (await UserServicesDB()
                                  .addUser(userModel: userModel)) {
                                await userController.storeData(userModel);
                                userController.getData();
                                await UserServicesDB()
                                    .verifyAccountAvailability(
                                        id: userModel.id);
                                alertDialog(
                                    context: context,
                                    contentType: ContentType.success,
                                    title: "Inscription réussite",
                                    message:
                                        "vous pouvez maintenant confimer l'inscription par numero de telephone");
                                authController.isloadingSignup.value = false;

                                Get.offAll(() => HomeScreen());
                              }
                            } else {
                              authController.isloadingSignup.value = false;

                              alertDialog(
                                  context: context,
                                  contentType: ContentType.failure,
                                  title: "Verifiez vos données",
                                  message: "reésseyé autre fois");
                            }
                          }
                        },
                        child: Text(
                          "Inscriver",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        )),
                  ),
                  SizedBox(
                    height: PaddingManager.kheight / 2,
                  ),
                  Obx(() => authController.isloadingSignup.value
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                              width: double.infinity,
                              child: LinearProgressIndicator(
                                color: ColorManager.primaryColor,
                              )),
                        )
                      : Text("")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: 150,
                        color: Colors.grey.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Ou",
                          style: TextStyleMnager.petitTextGrey,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 150,
                        color: Colors.grey.shade300,
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
                    ],
                  ),
                  SizedBox(
                    height: PaddingManager.kheight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Si vous avez un compte",
                        style: TextStyleMnager.petitTextGrey,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteManager.loginScreen);
                          },
                          child: Text(
                            "Connecter",
                            style: TextStyleMnager.petitTextPrimary,
                          ))
                    ],
                  ),

                  // SizedBox(
                  //   height: 400,
                  //   child: Stack(
                  //     children: [
                  //       SizedBox(
                  //         width: double.infinity,
                  //         child: SvgPicture.asset(
                  //           ImageManager.waves,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //       Positioned(
                  //           top: 50,
                  //           left: 30,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 "T",
                  //                 style: TextStyleMnager.lobster,
                  //               ),
                  //               Text(
                  //                 "-rabendo",
                  //                 style: TextStyleMnager.lora2,
                  //               ),
                  //             ],
                  //           )),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
