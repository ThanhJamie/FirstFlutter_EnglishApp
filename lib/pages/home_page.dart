// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_function_literals_in_foreach_calls

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_application_1/models/english_today.dart';
import 'package:flutter_application_1/packages/quote/qoute_model.dart';
import 'package:flutter_application_1/packages/quote/quote.dart';
import 'package:flutter_application_1/values/app_assets.dart';
import 'package:flutter_application_1/values/app_colors.dart';
import 'package:flutter_application_1/values/app_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishToday> words = [];

  String quote = Quotes().getRandom().content!;

  List<int> fixedListRamdom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() {
    List<String> newList = [];
    List<int> rans = fixedListRamdom(len: 5, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });

    words = newList.map((e) => getQuote(e)).toList();
  }

  EnglishToday getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(noun: noun, quote: quote?.content, id: quote?.id);
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.92);
    getEnglishToday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          onTap: () {},
          child: Image.asset(AppAssets.menu),
        ),
      ),
      body: Container(
        width: double.infinity,
        // margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: size.height * 1 / 10,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: Text(
                "$quote",
                style: AppStyles.h5.copyWith(
                  color: AppColors.textColor,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              // color: Colors.red,
              height: size.height * 2 / 3,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    String firstLetter =
                        words[index].noun != null ? words[index].noun![0] : "";
                    firstLetter = firstLetter.substring(0, 1);
                    String leftLetter =
                        words[index].noun != null ? words[index].noun! : '';
                    leftLetter = leftLetter.substring(1, leftLetter.length);
                    String quoteDefault =
                        "Think of all the beauty still left around you and be happy.";
                    String quote = words[index].quote != null
                        ? words[index].quote!
                        : quoteDefault;

                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        // margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(3, 6),
                                  blurRadius: 6)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.topRight,
                                child: Image.asset(AppAssets.heart)),
                            RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: firstLetter,
                                    style: TextStyle(
                                        fontFamily: FontFamily.sen,
                                        fontSize: 96,
                                        fontWeight: FontWeight.bold,
                                        shadows: const [
                                          BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(3, 6),
                                              blurRadius: 6)
                                        ]),
                                    children: [
                                      TextSpan(
                                        text: leftLetter,
                                        style: TextStyle(
                                            fontFamily: FontFamily.sen,
                                            fontSize: 64,
                                            fontWeight: FontWeight.bold,
                                            shadows: const [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(3, 6),
                                                  blurRadius: 6)
                                            ]),
                                      )
                                    ])),
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: Text(
                                '"$quote"',
                                style: AppStyles.h4.copyWith(
                                    fontSize: 28,
                                    letterSpacing: 1,
                                    color: AppColors.textColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: size.height * 1 / 11,
              // margin: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: ((context, index) {
                      return buildIndicator(index == _currentIndex, size);
                    })),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      height: 12,
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: isActive ? size.width * 1 / 4 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lightBlue : AppColors.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }
}
