// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, unused_element, must_be_immutable, unnecessary_null_comparison, use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:trabendo/services/userservicesDB.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/profileScreen.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/DialogWidget.dart';

import '../productsScreens/addProduct.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  String otpcode = "";
  String verifiId = "";

  Widget _buidTextIntro() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Vérification du Téléphone",
          style: TextStyleMnager.getstyle(
              fontWeight: FontWeight.bold, fontsize: 24, color: Colors.black),
        ),
        SizedBox(
          height: PaddingManager.kheight + 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: PaddingManager.kheight),
          child: Text(
            "Entrer le Code envoyé a votre téléphone",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        )
      ],
    );
  }

  PinCodeTextField _pincodeWidget(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: TextStyle(
        color: ColorManager.primaryColor,
        fontWeight: FontWeight.bold,
      ),
      length: 6,
      obscureText: false,
      obscuringCharacter: '*',
      obscuringWidget: Icon(
        Icons.done,
        color: ColorManager.primaryColor,
      ),
      blinkWhenObscuring: true,
      animationType: AnimationType.scale,
      validator: (v) {
        if (v!.length < 3) {
          return "I'm from validator";
        } else {
          return null;
        }
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        borderRadius: BorderRadius.circular(20),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
      ),
      cursorColor: ColorManager.primaryColor,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: false,
      controller: TextEditingController(),
      keyboardType: TextInputType.number,
      onCompleted: (v) {
        otpcode = v;
        debugPrint("Completed");
      },
      onTap: () {
        print("Pressed");
      },
      onChanged: (value) {
        debugPrint(value);
      },
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }

  @override
  void initState() {
    verifyNumber(phonenumber: widget.phoneNumber, context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 250,
                child: LottieBuilder.asset(
                  ImageManager.phoneLottie,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              _buidTextIntro(),
              SizedBox(
                height: PaddingManager.kheight / 2,
              ),
              Text(
                "+${widget.phoneNumber}",
                style: TextStyleMnager.petitTextPrimary,
              ),
              SizedBox(
                height: PaddingManager.kheight / 2,
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: PaddingManager.kheight),
                  child: _pincodeWidget(context)),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              Text(
                "Patientez SVP  ....... !",
                style: TextStyleMnager.petitTextPrimary,
              ),
              SizedBox(
                height: PaddingManager.kheight / 2,
              ),
              InkWell(
                onTap: () {
                  verifyNumber(
                      phonenumber: widget.phoneNumber, context: context);
                },
                child: RichText(
                  text: TextSpan(
                      text: "Vous n'avais pas recu le Code ? ",
                      style: TextStyleMnager.petitTextGrey,
                      children: <TextSpan>[
                        TextSpan(
                            text: "Re-envoyé le Code",
                            style: TextStyleMnager.petitTextPrimary)
                      ]),
                ),
              ),
              SizedBox(
                height: PaddingManager.kheight2,
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
                    onPressed: () {
                      if (otpcode.length < 6) {
                        alertDialog(
                            context: context,
                            title: "Alert",
                            contentType: ContentType.failure,
                            message: "Entrer le code OTP");
                      } else {
                        verifyOTP();
                      }
                    },
                    child: Text(
                      "Continue",
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

  Future<void> verifyOTP() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verifiId,
          smsCode: otpcode,
        ),
      )
          .then((value) async {
        if (value.user != null) {
          await UserServicesDB().addPhoneNumber(widget.phoneNumber);
          Get.off(() => ProfileScreen());
          alertDialog(
              context: context,
              title: "Succès",
              contentType: ContentType.success,
              message: "Numéro de telepone vérifié");
        } else {
          alertDialog(
              context: context,
              title: "Alert",
              contentType: ContentType.failure,
              message: "OTP incorrect");
        }
      });
    } catch (e) {
      alertDialog(
          context: context,
          title: "Alert",
          contentType: ContentType.failure,
          message: "OTP incorrect");
    }
  }

  verifyNumber(
      {required String phonenumber, required BuildContext context}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+$phonenumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        alertDialog(
            context: context,
            title: "succès",
            contentType: ContentType.failure,
            message: "Verification Complete");
        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.to(() => const AddProductScreen());
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          alertDialog(
              context: context,
              title: "Erreur",
              contentType: ContentType.failure,
              message: "Numéro invalide ou code incorrecte");
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        verifiId = verificationId;
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
