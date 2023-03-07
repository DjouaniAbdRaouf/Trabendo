// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/ReusableComponents/FavoriteItem.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: "Liste des favoris"),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // FavoriteItem(
                //   path:
                //       "https://cdn.futura-sciences.com/sources/images/qr/Celine/Ecran%20TV%20%20Andrey%20Popov%2C%20Adobe%20Stock.jpeg",
                // ),
                // FavoriteItem(
                //   path:
                //       "https://www.notebookcheck.biz/fileadmin/Notebooks/News/_nc3/Samsung_Galaxy_S_Series_Hands_On_29_von_3339.jpg",
                // ),
                // FavoriteItem(
                //   path:
                //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJPWuJO32Pae9ndkso0nAVImF0NeunGbG9sg&usqp=CAU",
                // ),
              ],
            )),
      ),
    );
  }
}
