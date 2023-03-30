import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/models/user_model.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/filterScreen.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/ReusableComponents/ItemCard.dart';
import 'package:trabendo/views/widgets/TextFormFieldGest.dart';

class ProductForSpesificUserScreen extends StatefulWidget {
  const ProductForSpesificUserScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ProductForSpesificUserScreen> createState() =>
      _ProductForSpesificUserScreenState();
}

class _ProductForSpesificUserScreenState
    extends State<ProductForSpesificUserScreen> {
  String search = "";
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: "Produits d'un vendeur"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(PaddingManager.kheight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Nom du vendeur : ",
                    style: TextStyleMnager.petitTextGrey,
                  ),
                  Text(
                    '${widget.userModel.displayname}',
                    style: TextStyleMnager.petitTextPrimary,
                  ),
                  Spacer(),
                  // Text(
                  //   "Resultas : ${allProductController.allproductsUserList.where((p0) => p0.categorie == widget.categorie).length} produit(s)",
                  //   style: TextStyleMnager.petitTextGrey,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                ],
              ),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              Text(
                "Différents Produits",
                style: TextStyleMnager.petitTextGrey,
              ),
              SizedBox(
                height: PaddingManager.kheight / 2,
              ),
              StreamBuilder<QuerySnapshot>(
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: LottieBuilder.asset(
                          ImageManager.loadingLottie,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: LottieBuilder.asset(
                          ImageManager.loadingLottie,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 0.8),
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot data =
                              snapshot.data!.docs[index];
                          if (search == "") {
                            ProductsModel productsModel =
                                ProductsModel.fromJson(data);
                            return ItemCard(productsModel: productsModel);
                          }
                          if (data["title"].toString().startsWith(search)) {
                            ProductsModel productsModel =
                                ProductsModel.fromJson(data);
                            return ItemCard(productsModel: productsModel);
                          }
                          return Text("");
                        },
                        itemCount: snapshot.data!.docs.length,
                      ),
                    );
                  }

                  return Container();
                },
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .where("idUser", isEqualTo: widget.userModel.id)
                    .snapshots(),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  textEditingController.text.toLowerCase();
                  search = value.toLowerCase();
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
          flex: 3,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: InkWell(
            onTap: () {
              Get.to(() => FilterScreen());
            },
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
}
