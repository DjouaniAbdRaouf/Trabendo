// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/DetailsProduct.dart';

class ItemCard extends StatelessWidget {
  ItemCard({super.key, this.path});

  String? path;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => const DetailProductScreen()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 180,
            width: 160,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(path ??
                              "https://photos6.spartoo.com/photos/229/22977049/22977049_350_B.jpg"),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover)),
                  height: 100,
                  width: 140,
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                Text(
                  "Survetement Sport",
                  style: TextStyleMnager.petitTextGreyBlack,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: PaddingManager.kheight / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "2200 D.A",
                      style: TextStyleMnager.petitTextPrimary,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
