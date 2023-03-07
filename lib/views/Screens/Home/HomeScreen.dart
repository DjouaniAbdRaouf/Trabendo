// ignore_for_file: prefer_const_constructors ,  prefer_const_literals_to_create_immutables, file_names, sort_child_properties_last, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trabendo/controllers/allProductControllers.dart';
import 'package:trabendo/models/CategorieModel.dart';
import 'package:trabendo/models/productModel.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/Screens/AccountInformation.dart';
import 'package:trabendo/views/Screens/Home/Favorite.dart';
import 'package:trabendo/views/Screens/Home/MyProducts.dart';

import 'package:trabendo/views/Screens/Settings.dart';
import 'package:trabendo/views/Screens/StoreByTypeScreen.dart';
import 'package:trabendo/views/Screens/filterScreen.dart';
import 'package:trabendo/views/widgets/ReusableComponents/CategorieItem.dart';
import 'package:trabendo/views/widgets/ReusableComponents/ItemCard.dart';
import 'package:trabendo/views/widgets/ReusableComponents/PopularItem.dart';
import 'package:trabendo/views/widgets/TextFormFieldGest.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> carousselImages = [
      "https://www.admin-info.dz/wp-content/uploads/2021/07/h900-pour-site.jpg",
      "https://www.2051.fr/wp-content/uploads/2021/07/1626090707_Meilleure-souris-de-jeu-sans-fil-en-2021.jpg"
    ];
    AllProductController allProductController = Get.put(AllProductController());
    return Scaffold(
      drawer: CurvedDrawer(
        color: Colors.white,
        labelColor: Colors.black54,
        width: 75.0,
        items: <DrawerItem>[
          DrawerItem(icon: Icon(Icons.home), label: "Home"),
          DrawerItem(icon: Icon(Icons.message), label: "Messages"),
          DrawerItem(icon: Icon(Icons.message), label: "Messages"),
          DrawerItem(icon: Icon(Icons.message), label: "Messages"),
        ],
        onTap: (index) {},
      ),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        foregroundColor: Colors.grey.shade900,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Get.to(() => AccountInformation()),
              child: Icon(
                Icons.manage_accounts,
                size: 35,
              ),
              // child: Container(
              //   padding: EdgeInsets.all(5),
              //   height: 90,
              //   width: 90,
              //   decoration: BoxDecoration(
              //       border: Border.all(width: 1, color: Colors.grey),
              //       shape: BoxShape.circle,
              //       color: Colors.transparent,
              //       image: DecorationImage(
              //           image: AssetImage(ImageManager.avatar),
              //           fit: BoxFit.contain,
              //           filterQuality: FilterQuality.high)),
              // ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choisir votre Produit Préféré",
                style: TextStyleMnager.getstyle(
                    fontWeight: FontWeight.bold,
                    fontsize: 30,
                    color: Colors.black),
                maxLines: 2,
              ),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              _searchAndFilter(),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              // CarouselSlider.builder(
              //   options: CarouselOptions(
              //     height: 150.0,
              //     autoPlay: true,
              //     viewportFraction: 1,
              //     enableInfiniteScroll: false,
              //     enlargeCenterPage: true,
              //     enlargeStrategy: CenterPageEnlargeStrategy.height,
              //     onPageChanged: (index, reason) {
              //       allProductController.changeIndex(index);
              //     },
              //   ),
              //   itemBuilder: (BuildContext context, int index, int realIndex) {
              //     return Container(
              //       margin: EdgeInsets.symmetric(horizontal: 15),
              //       decoration: BoxDecoration(
              //           color: Colors.transparent,
              //           borderRadius: BorderRadius.circular(25),
              //           image: DecorationImage(
              //               image: NetworkImage(carousselImages[index]),
              //               fit: BoxFit.cover,
              //               filterQuality: FilterQuality.high)),
              //     );
              //   },

              //   itemCount: carousselImages.length,

              // ),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              _buildIndocator()!,
              SizedBox(
                height: PaddingManager.kheight,
              ),
              Text(
                "Catégories",
                style: TextStyleMnager.petitTextGrey,
              ),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              _categories(),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recentes Publications",
                    style: TextStyleMnager.petitTextGrey,
                  ),
                ],
              ),
              SizedBox(
                height: PaddingManager.kheight / 2,
              ),
              Obx(() {
                // les produit ont publiés cette semaine ( a changé )
                // TODO make it dynamic
                return allProductController.allproductsUserList.isNotEmpty
                    ? _recentPublications(
                        list: allProductController.allproductsUserList
                            .where((product) =>
                                DateTime.now().day - product.date!.day <= 7)
                            .toList())
                    : Center(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child:
                              LottieBuilder.asset(ImageManager.loadingLottie),
                        ),
                      );
              }),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Produits CABA",
                    style: TextStyleMnager.petitTextGrey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => StoreByTypeScreen(typecat: "CABA"));
                    },
                    child: Text(
                      "voir tout",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: PaddingManager.kheight / 2,
              ),
              Obx(() {
                // les produit CABA
                return allProductController.allproductsUserList.isNotEmpty
                    ? _recentPublications(
                        list: allProductController.allproductsUserList
                            .where((product) => product.typeProduct == "CABA")
                            .toList())
                    : Center(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child:
                              LottieBuilder.asset(ImageManager.loadingLottie),
                        ),
                      );
              }),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Produits BLED",
                    style: TextStyleMnager.petitTextGrey,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => StoreByTypeScreen(typecat: "BLED"));
                    },
                    child: Text(
                      "voir tout",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: PaddingManager.kheight / 2,
              ),
              Obx(() {
                // les produit bled
                return allProductController.allproductsUserList.isNotEmpty
                    ? _recentPublications(
                        list: allProductController.allproductsUserList
                            .where((product) => product.typeProduct == "BLED")
                            .toList())
                    : Center(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child:
                              LottieBuilder.asset(ImageManager.loadingLottie),
                        ),
                      );
              }),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              Text(
                "Populaires",
                style: TextStyleMnager.petitTextGrey,
              ),
              SizedBox(
                height: PaddingManager.kheight / 2,
              ),
              _popularWidget(),
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
                          ProductsModel productsModel =
                              ProductsModel.fromJson(data);
                          return ItemCard(productsModel: productsModel);
                        },
                        itemCount: snapshot.data!.docs.length,
                      ),
                    );
                  }

                  return Container();
                },
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .limit(30)
                    .snapshots(),
              ),
              SizedBox(
                height: PaddingManager.kheight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popularWidget() {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          PopularItem(),
          PopularItem(),
          PopularItem(),
        ],
      ),
    );
  }

  Widget _recentPublications({required List<ProductsModel> list}) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 250,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemCard(productsModel: list[index]);
        },
      ),
    );
  }

  Widget _categories() {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: 120,
      color: Colors.white,
      child: ListView.builder(
        itemCount: CategorieModel.mesCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategorieItem(
              categorieModel: CategorieModel.mesCategories[index]);
        },
        shrinkWrap: true,
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

  Widget? _buildIndocator() {
    AllProductController allProductController = Get.put(AllProductController());

    return Center(
      child: Obx(() => AnimatedSmoothIndicator(
            activeIndex: allProductController.activeIndex.value,
            count: 4,
            curve: Curves.bounceInOut,
          )),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        FavoriteScreen(),
        MyProductScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: ColorManager.primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.favorite_border_rounded),
          title: ("Favorite"),
          activeColorPrimary: ColorManager.primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home_work,
            color: ColorManager.primaryColor,
          ),
          inactiveIcon: const Icon(
            Icons.home_work,
            color: Colors.grey,
          ),
          activeColorPrimary: ColorManager.primaryColor,
          inactiveColorPrimary: ColorManager.primaryWithOpacity75,
        ),
      ];
    }

    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      controller: controller,
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
