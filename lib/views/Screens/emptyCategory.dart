import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trabendo/themes.dart';

class EmptyCategory extends StatelessWidget {
  const EmptyCategory({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          LottieBuilder.asset(ImageManager.empty),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
                color: ColorManager.primaryColor,
                fontSize: 35,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
