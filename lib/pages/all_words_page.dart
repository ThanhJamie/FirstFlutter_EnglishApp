import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_words/english_words.dart';
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
          padding: EdgeInsets.only(right: 12),
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
      body: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: words
            .map((e) => Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: AutoSizeText(
                    e.noun ?? '',
                    style: AppStyles.h3.copyWith(shadows: [
                      const BoxShadow(
                          color: Colors.black38,
                          offset: Offset(3, 6),
                          blurRadius: 6)
                    ]),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
