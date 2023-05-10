// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/values/app_assets.dart';
import 'package:flutter_application_1/values/app_colors.dart';
import 'package:flutter_application_1/values/app_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome to",
                  style: AppStyles.h3,
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("English",
                      style: AppStyles.h2.copyWith(
                          color: AppColors.blackGrey,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text("Qoutes\"",
                        textAlign: TextAlign.right,
                        style: AppStyles.h4.copyWith(
                            color: Colors.white, height: 0.8, fontSize: 32)),
                  ),
                ],
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 120),
              child: RawMaterialButton(
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(),
                      ),
                      (route) => false);
                },
                fillColor: AppColors.lightBlue, 
                child: Image.asset(AppAssets.rightArrow),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
