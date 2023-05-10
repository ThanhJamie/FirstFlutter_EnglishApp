// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
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
  PageController _pageController = PageController();

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
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: size.height * 1 / 10,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: Text(
                "“It is amazing how complete is the delusion that beauty is goodness.”",
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
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(24))),
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
                                  text: "B",
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
                                      text: "eautiful",
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
                              "“Think of all the beauty still left around you and be happy.”",
                              style: AppStyles.h4
                                  .copyWith(fontSize: 28, letterSpacing: 1),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: size.height * 1 / 11,
              // margin: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
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
        onPressed: () {},
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
