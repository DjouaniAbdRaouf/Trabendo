// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabendo/controllers/FilterListController.dart';
import 'package:trabendo/controllers/allProductControllers.dart';
import 'package:trabendo/themes.dart';
import 'package:trabendo/views/widgets/AppBarWidget.dart';
import 'package:trabendo/views/widgets/ReusableComponents/FavoriteItem.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterController filterController = Get.put(FilterController());
  AllProductController allProductController = Get.put(AllProductController());
  int tag = 0;
  List<String> options = [
    'Santé',
    'Technologies',
    'Sport',
    'Beauty',
  ];
  String cat = "Santé";
  double min = 0;
  double max = 10000000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(text: "Filtration"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(PaddingManager.kheight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: PaddingManager.kheight2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyleMnager.petitTextGreyBlack,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        tag = 0;
                        rangeValues = RangeValues(0.0, 10000000);
                        filterController.filtredList.clear();
                      });
                    },
                    child: Text(
                      "Reset All",
                      style: TextStyleMnager.petitTextPrimary,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: PaddingManager.kheight,
              ),
              ChipsChoice<int>.single(
                value: tag,
                onChanged: (val) {
                  setState(() {
                    tag = val;
                    cat = options[val];
                  });
                },
                choiceItems: C2Choice.listFrom<int, String>(
                  source: options,
                  value: (i, v) => i,
                  label: (i, v) {
                    return v;
                  },
                ),
                choiceStyle: C2ChipStyle(
                    backgroundColor: Colors.blueGrey,
                    checkmarkColor: Colors.blue),
                choiceCheckmark: true,
                wrapped: true,
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ExpansionTile(
                title: Text(
                  "Price Range",
                  style: TextStyleMnager.petitTextGreyBlack,
                ),
                initiallyExpanded: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${rangeValues.start.toStringAsFixed(1)} DZD"),
                      Text("${rangeValues.end.toStringAsFixed(1)} DZD"),
                    ],
                  ),
                  RangeSlider(
                    activeColor: Colors.blueGrey,
                    values: rangeValues,
                    onChanged: (value) {
                      setState(() {
                        max = value.end;
                        min = value.start;
                        rangeValues = value;
                      });
                    },
                    min: 0,
                    max: 10000000,
                  )
                ],
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: PaddingManager.kheight2,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(8),
                        backgroundColor: ColorManager.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      filterController.filtredList.clear();
                      filterController.getfiltreddata(
                          min: min, max: max, cat: cat);
                    },
                    icon: Icon(Icons.filter),
                    label: Text(
                      "Voir le Résultat",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: PaddingManager.kheight2,
              ),
              Obx(() => filterController.filtredList.isNotEmpty
                  ? SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Résultat de recherche :",
                                  style: TextStyleMnager.petitTextGrey),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  "${filterController.filtredList.length} Produit(s)",
                                  style: TextStyleMnager.petitTextPrimary),
                            ],
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return FavoriteItem(
                                  productsModel:
                                      filterController.filtredList[index]);
                            },
                            itemCount: filterController.filtredList.length,
                            shrinkWrap: true,
                          ),
                        ],
                      ),
                    )
                  : Container())
            ],
          ),
        ),
      ),
    );
  }

  RangeValues rangeValues = RangeValues(0.0, 10000000);
}
