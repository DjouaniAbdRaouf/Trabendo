// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trabendo/services/routes.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/Onboarding_build.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var controller = PageController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: ""),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  controller.jumpToPage(2);
                },
                child: Text(
                  "Ignorer",
                  style: TextStyleMnager.petitTextPrimary,
                )),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(spacing: 16),
              ),
            ),
            islast
                ? TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RouteManager.homeScreen);
                    },
                    child: Text(
                      "Commencer",
                      style: TextStyleMnager.petitTextPrimary,
                    ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryColor),
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastOutSlowIn);
                    },
                    child: Text(
                      "Suivant",
                      style: TextStyleMnager.petitTextWithe,
                    )),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 60.0),
        child: PageView(
          onPageChanged: (value) {
            setState(() {
              islast = value == 2;
            });
          },
          controller: controller,
          children: [
            OnboardingBuild(
                color: Colors.white,
                path: ImageManager.quiSommeNous,
                title: "Qui Somme-Nous ?",
                subtitle:
                    "Trabendo est une plateforme qui mette en relationles personnes désirieux d'acheter ou vendre des produit caba vers Lbled ou des article traditionelles pour les diasporas a l'étranger"),
            OnboardingBuild(
                color: Colors.white,
                path: ImageManager.client,
                title: "Êtes-vous un Client ?",
                subtitle:
                    "Vous pouvez decouvrer toutes les article CABA dans n'importe quel pays dans le Monde, utilise Trabendo"),
            OnboardingBuild(
                color: Colors.white,
                path: ImageManager.vendors,
                title: "Êtes-vous un Vendeur ?",
                subtitle:
                    "vous etes un immigré , vous voulez de transporter quelques produits CABA vers l'algerie et vous voulez de les vendre rapidement , publier votre produit dans notre plateforme Trabendo"),
          ],
        ),
      ),
    );
  }
}
