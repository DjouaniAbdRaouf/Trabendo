// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/AccountInformation.dart';
import 'package:trabendo/views/widgets/TextFormFieldGest.dart';

class CategorieItemsScreen extends StatelessWidget {
  const CategorieItemsScreen({super.key});

  Widget _searchAndFilter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200)),
            child: TextFormGest(
                controller: TextEditingController(),
                errormessage: "",
                icon: Icons.abc,
                colorFill: Colors.grey.shade200,
                hinttext: "Cherchez votre Produit",
                colosuffixIcon: Colors.grey.shade400,
                suffixIcon: Icons.search),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.filter_list,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        foregroundColor: Colors.grey.shade900,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(
          Icons.menu,
          size: 28,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Get.to(() => AccountInformation()),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2TGo6LoQxlQJw7jiBHNiG6lKiAoz62TeCzQ&usqp=CAU"),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high)),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: PaddingManager.kheight / 2,
            ),
            _searchAndFilter(),
            SizedBox(
              height: PaddingManager.kheight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Categorie :",
                  style: TextStyleMnager.petitTextGrey,
                ),
                Text(
                  "Santé",
                  style: TextStyleMnager.petitTextPrimary,
                ),
                Spacer(),
                Text(
                  "Resultas : 89 produits",
                  style: TextStyleMnager.petitTextGrey,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
