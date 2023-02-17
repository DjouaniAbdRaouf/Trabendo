// ignore_for_file: file_names, body_might_complete_normally_nullable, avoid_print, unnecessary_new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trabendo/views/Screens/Home/HomeScreen.dart';
import 'package:trabendo/views/Screens/Login_Screen.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection("users");

  //SignIn with Email Function
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credantial = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credantial);
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
}
