// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/ReusableComponents/ItemCard.dart';
import 'package:trabendo/views/widgets/TextFormFieldGest.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});

  Widget _searchAndFilter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
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
          flex: 3,
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
      appBar: appbarWidget(text: "Mes Produits"),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _searchAndFilter(),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                Text(
                  "Totale des Annonces : 20",
                  style: TextStyleMnager.petitTextPrimary,
                ),
                Text(
                  "Produits Vendus : 20",
                  style: TextStyleMnager.petitTextPrimary,
                ),
                SizedBox(
                  height: PaddingManager.kheight,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 0.8),
                    children: [
                      ItemCard(
                        path:
                            "https://www.cnet.com/a/img/resize/b2ffcfd31dd630e249ee3b06b89124cd47ae67d4/hub/2019/08/20/db2c8f57-f31e-4995-99e3-50f2c7ce49e3/gaming-keyboards-200-01.jpg?auto=webp&fit=crop&height=675&width=1200",
                      ),
                      ItemCard(),
                      ItemCard(
                        path:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQ-o2gpzoaY1O2718GwnZovqg4LzarPfdpIQ&usqp=CAU",
                      ),
                      ItemCard(
                        path:
                            "https://www.sneakers-actus.fr/wp-content/uploads/2022/02/Nike-Air-Max-Dawn-Black-White-Noir-Blanc-Sommet.jpg",
                      ),
                      ItemCard(),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
