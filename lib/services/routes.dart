import 'package:flutter/material.dart';
import 'package:trabendo/views/Screens/DetailsProduct.dart';
import 'package:trabendo/views/Screens/Home/HomeScreen.dart';
import 'package:trabendo/views/Screens/Login_Screen.dart';
import 'package:trabendo/views/Screens/OnboardingScreen.dart';
import 'package:trabendo/views/Screens/Otp/PhoneNumberScreen.dart';
import 'package:trabendo/views/Screens/Otp/PhoneVerificationScreen.dart';
import 'package:trabendo/views/Screens/Register_Screen.dart';
import 'package:trabendo/views/Screens/Splash_Screen.dart';

class RouteManager {
  static const String splashScreen = "/";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String onboardingScreen = "/onboarding";
  static const String phoneScreen = "/phone";
  static const String phoneVerification = "/phoneVerification";
  static const String homeScreen = "/home";
  static const String details = "/details";

  static Route<dynamic> routemanager(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteManager.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteManager.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RouteManager.registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case RouteManager.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case RouteManager.phoneScreen:
        return MaterialPageRoute(builder: (_) => PhoneNumberScreen());
      case RouteManager.phoneVerification:
        return MaterialPageRoute(
            builder: (_) => const PhoneVerificationScreen(
                  phoneNumber: '',
                ));
      case RouteManager.homeScreen:
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
      case RouteManager.details:
        return MaterialPageRoute(builder: (_) => DetailProductScreen());
      default:
    }
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
