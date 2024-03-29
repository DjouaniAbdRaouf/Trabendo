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
          password: "",
          phone: "",
          pays: "",
          adresse: "",
          displayname: userCredential.user!.displayName!);
      UserServicesDB().verifyAccountAvailability(id: userCredential.user!.uid);
      await userController.storeData(userModel);
      userController.getData();
      Get.offAll(() => HomeScreen());
      if (!await UserServicesDB().getUserData(uid: userCredential.user!.uid)) {
        print("added to firestore");
        await UserServicesDB().addUser(userModel: userModel);
      } else {
        print("exist");
      }
    }
  }

  //Determine if the user is authenticate
  Future<Widget> handlStateAuth() async {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
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
}
