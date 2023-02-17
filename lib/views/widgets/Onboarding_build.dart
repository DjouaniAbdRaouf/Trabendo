// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingBuild extends StatelessWidget {
  const OnboardingBuild(
      {super.key,
      required this.color,
      required this.path,
      required this.title,
      required this.subtitle});

  final Color color;
  final String path, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        color: color,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                path,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 33,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
