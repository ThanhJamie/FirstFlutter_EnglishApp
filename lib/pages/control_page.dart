// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/values/app_assets.dart';
import 'package:flutter_application_1/values/app_colors.dart';
import 'package:flutter_application_1/values/app_styles.dart';
import 'package:flutter_application_1/values/share_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    initDefaultValue();
    super.initState();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.counter) ?? 5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.secondColor,
        title: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 12),
          child: Text(
            "Your control",
            style:
                AppStyles.h3.copyWith(fontSize: 36, color: AppColors.textColor),
          ),
        ),
        leading: InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt(ShareKeys.counter, sliderValue.toInt());
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          const Spacer(),
          Text(
            "How much the number word at once",
            style:
                AppStyles.h4.copyWith(color: AppColors.lightGrey, fontSize: 18),
          ),
          const Spacer(),

          Text(
            "${sliderValue.toInt()}",
            style: AppStyles.h1.copyWith(
                color: AppColors.primaryColor,
                fontSize: 150,
                fontWeight: FontWeight.bold),
          ),
          Slider(
              value: sliderValue,
              min: 5,
              max: 100,
              divisions: 95,
              activeColor: AppColors.primaryColor,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              }),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            alignment: Alignment.centerLeft,
            child: Text(
              "slide to set",
              style: AppStyles.h5
                  .copyWith(color: AppColors.textColor, fontSize: 18),
            ),
          ),
          const Spacer(),
          const Spacer(),
        ]),
      ),
    );
  }
}
