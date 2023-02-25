// ignore_for_file: file_names, body_might_complete_normally_nullable, avoid_print, unnecessary_new, use_build_context_synchronously, non_constant_identifier_names
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trabendo/controllers/userController.dart';
import 'package:trabendo/models/user_model.dart';
import 'package:trabendo/services/userservicesDB.dart';
import 'package:trabendo/views/Screens/Home/HomeScreen.dart';
import 'package:trabendo/views/Screens/Login_Screen.dart';
import 'package:trabendo/views/widgets/DialogWidget.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserController userController = Get.find();

  CollectionReference users = FirebaseFirestore.instance.collection("users");

  //SignIn with Email Function
  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser == null) {
      alertDialog(
          context: context,
          title: "Problème d'authentification",
          contentType: ContentType.failure,
          message: "Réessyer autre fois");
    } else {
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credantial = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credantial);
      UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          password: "hideen",
          displayname: userCredential.user!.displayName!);
      userController.storeData(userModel);
      userController.getData();
      await UserServicesDB().addUser(userModel: userModel);
    }
  }

  //Determine if the user is authenticate
  Future<Widget> handlStateAuth() async {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return LoginScreen();
          }
        });
  }

  //SignOut
  logout() async {
    await FirebaseAuth.instance.signOut();
  }

  //verifyEmail
  bool validateEmail(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  //SignUpWithEmailAndPassword
  Future<UserCredential?> signup(
      {required String email, required String password}) async {
    try {
      var user = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  //LoginWithEmailAndPassword
  Future<UserCredential?> signin(
      {required String email, required String password}) async {
    try {
      UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  verifyNumber({required String phonenumber}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+$phonenumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatic handling of the SMS code on Android devices.
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle failure events such as invalid phone numbers or whether the SMS quota has been exceeded.
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = 'xxxx';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }
}
