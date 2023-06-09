import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/english_today.dart';
import 'package:flutter_application_1/values/app_assets.dart';
import 'package:flutter_application_1/values/app_colors.dart';
import 'package:flutter_application_1/values/app_styles.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordsPage({Key? key, required this.words}) : super(key: key);

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
            "English Today",
            style:
                AppStyles.h3.copyWith(fontSize: 36, color: AppColors.textColor),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: (index % 2) == 0
                    ? AppColors.primaryColor
                    : AppColors.secondColor,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(words[index].noun!,
                  style: (index % 2) == 0
                      ? AppStyles.h4
                      : AppStyles.h4.copyWith(color: AppColors.textColor)),
              subtitle: Text(words[index].quote ??
                  "Think of all the beauty still left around you and be happy."),
              leading: Icon(Icons.favorite,
                  color: words[index].isFavorite ? Colors.red : Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
