// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/controllers/allProductControllers.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/AccountInformation.dart';
import 'package:trabendo/views/widgets/ReusableComponents/FavoriteItem.dart';

class CategorieItemsScreen extends StatefulWidget {
  const CategorieItemsScreen({super.key, required this.categorie});

  final String categorie;

  @override
  State<CategorieItemsScreen> createState() => _CategorieItemsScreenState();
}

class _CategorieItemsScreenState extends State<CategorieItemsScreen> {
  final AllProductController allProductController = Get.find();

  final TextEditingController textEditingController = TextEditingController();

  String search = "";

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
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              controller: textEditingController,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 26,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: ColorManager.primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Cherchez par Nom du Produit"),
            ),
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
                        image: AssetImage(ImageManager.avatar),
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    widget.categorie,
                    style: TextStyleMnager.petitTextPrimary,
                  ),
                  Spacer(),
                  Text(
                    "Resultas : ${allProductController.allproductsUserList.where((p0) => p0.categorie == widget.categorie).length} produit(s)",
                    style: TextStyleMnager.petitTextGrey,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              Obx(() => allProductController.allproductsUserList.isNotEmpty
                  ? _catgorieFilterList(
                      filterCategorieList: allProductController
                          .allproductsUserList
                          .where((p0) => p0.categorie == widget.categorie)
                          .toList())
                  : Center(
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: LottieBuilder.asset(ImageManager.loadingLottie),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _catgorieFilterList(
      {required List<ProductsModel> filterCategorieList}) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: filterCategorieList.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 5,
        //     crossAxisSpacing: 5,
        //     childAspectRatio: 0.8),
        itemBuilder: (BuildContext context, int index) {
          if (search == "") {
            return FavoriteItem(productsModel: filterCategorieList[index]);
          }
          if (filterCategorieList[index].name.startsWith(search)) {
            return FavoriteItem(productsModel: filterCategorieList[index]);
          }
          return Text("");
        },
      ),
    );
  }
}
