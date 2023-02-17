// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2TGo6LoQxlQJw7jiBHNiG6lKiAoz62TeCzQ&usqp=CAU"),
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high)),
                          ),
                          Positioned(
                            bottom: 3,
                            right: 3,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                Text(
                  "Djouani Abd Raouf",
                  style: TextStyleMnager.petitTextGreyBlack,
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                Text(
                  "rdjouani6@gmail.com",
                  style: TextStyleMnager.petitTextGrey,
                ),
                SizedBox(
                  height: PaddingManager.kheight2,
                ),
                _rowInformationButton(
                    iconData: Icons.card_giftcard, title: "Mes Produits"),
                _rowInformationButton(
                    iconData: Icons.account_balance, title: "Profile"),
                _rowInformationButton(
                    iconData: Icons.info, title: "Informations du Compte"),
                _rowInformationButton(
                    iconData: Icons.settings, title: "Paramètres"),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                _rowInformationButton(
                    iconData: Icons.logout, title: "Deconnecter"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _rowInformationButton(
      {required String title, required IconData iconData}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade200),
            height: 40,
            width: 40,
            child: Icon(iconData),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: TextStyleMnager.petitTextGrey,
          ),
          Spacer(),
          Icon(
            Icons.arrow_right,
            color: Colors.grey,
            size: 30,
          )
        ],
      ),
    );
  }
}
