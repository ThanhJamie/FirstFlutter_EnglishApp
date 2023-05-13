// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_function_literals_in_foreach_calls, dead_code

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_application_1/models/english_today.dart';
import 'package:flutter_application_1/packages/quote/qoute_model.dart';
import 'package:flutter_application_1/packages/quote/quote.dart';
import 'package:flutter_application_1/pages/all_words_page.dart';
import 'package:flutter_application_1/pages/control_page.dart';
import 'package:flutter_application_1/values/app_assets.dart';
import 'package:flutter_application_1/values/app_colors.dart';
import 'package:flutter_application_1/values/app_styles.dart';
import 'package:flutter_application_1/values/share_keys.dart';
import 'package:flutter_application_1/widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';

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

  getEnglishToday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.counter) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedListRamdom(len: len, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });
    setState(() {
      words = newList.map((e) => getQuote(e)).toList();
    });
  }

  EnglishToday getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(noun: noun, quote: quote?.content, id: quote?.id);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
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
            _scaffoldKey.currentState?.openDrawer();
          },
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
                quote,
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
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        color: AppColors.primaryColor,
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              words[index].isFavorite =
                                  !words[index].isFavorite;
                            });
                          },
                          splashColor: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            // margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(AppAssets.heart,
                                      color: words[index].isFavorite
                                          ? Colors.red
                                          : Colors.white),
                                ),
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
                                  child: AutoSizeText(
                                    '"$quote"',
                                    // overflow: TextOverflow.clip,
                                    maxFontSize: 26,
                                    style: AppStyles.h4.copyWith(
                                        fontSize: 28,
                                        letterSpacing: 1,
                                        color: AppColors.textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            _currentIndex >= 5
                ? buildShowMore()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      height: size.height * 1 / 11,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        alignment: Alignment.center,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return buildIndicator(
                                  index == _currentIndex, size);
                            }),
                      ),
                    ))
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
      drawer: Drawer(
        child: Container(
          color: AppColors.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Your mind",
                  style: AppStyles.h3.copyWith(color: AppColors.textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: AppButton(label: "Favorites", onTap: () {}),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: AppButton(
                    label: "Your Control",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ControlPage()));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
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

  Widget buildShowMore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Material(
        elevation: 4,
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(24)),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AllWordsPage(
                          words: this.words,
                        )));
          },
          borderRadius: BorderRadius.all(Radius.circular(24)),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                "Show more",
                style: AppStyles.h5.copyWith(color: AppColors.textColor),
              )),
        ),
      ),
    );
  }
}
