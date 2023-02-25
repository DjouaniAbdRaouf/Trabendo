// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorManager {
  static Color primaryColor = const Color(0xFF364FD4);
  static Color primaryWithOpacity75 = const Color(0xBF364FD4);
  static Color textColor = Colors.white;
  static Color greyLight = Colors.grey.shade300;
}

class ImageManager {
  static String client = "assets/images/client.svg";
  static String vendors = "assets/images/vendors.svg";
  static String quiSommeNous = "assets/images/quisommesnous.svg";
  static String waves = "assets/images/wave.svg";
  static String googleIcons = "assets/icons/googleIcon.svg";
  static String phoneIcons = "assets/icons/phoneNumber.svg";
  static String phoneLottie = "assets/Lottie/phoneNumber.json";
  static String loadingLottie = "assets/Lottie/loading.json";
  static String resetPassword = "assets/Lottie/resetPassword.json";
  static String pickphotos = "assets/Lottie/pickphotos.json";

  static String horligneprofile = "assets/Lottie/horligneprofile.json";
  static String technology = "assets/icons/technology.png";
  static String beauty = "assets/icons/beauty.png";
  static String health = "assets/icons/health.png";
  static String sports = "assets/icons/sport.png";
  static String avatar = "assets/images/avatar.png";
}

class PaddingManager {
  static double kheight = 20;
  static double kheight2 = 40;
  static double kheight3 = 60;
}

class TextStyleMnager {
  //for trabendo logo
  static TextStyle lobster = GoogleFonts.lobster(
      color: ColorManager.textColor, fontSize: 60, fontWeight: FontWeight.bold);

  static TextStyle lora2 = GoogleFonts.lora(
      color: ColorManager.textColor, fontSize: 40, fontWeight: FontWeight.w800);

  //text with primary color
  static TextStyle petitTextPrimary = TextStyle(
      color: ColorManager.primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w600);
  static TextStyle petitTextPrimary2 = TextStyle(
      color: ColorManager.primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.w600);
  static TextStyle petitTextWithe = const TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600);
  static TextStyle petitTextGreyBlack = TextStyle(
      color: Colors.grey.shade900, fontSize: 16, fontWeight: FontWeight.w600);
  static TextStyle petitTextGrey = TextStyle(
      color: Colors.grey.shade600, fontSize: 14, fontWeight: FontWeight.w600);

  static TextStyle getstyle(
      {required FontWeight fontWeight,
      required double fontsize,
      required Color color}) {
    return TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis);
  }
}

class LottieManager {}
