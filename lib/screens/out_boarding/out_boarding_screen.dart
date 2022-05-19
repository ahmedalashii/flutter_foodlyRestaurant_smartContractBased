// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import 'package:foodly/widgets/page_view_indicator.dart';
import "../../constants/colors.dart" as colors;
import '../../widgets/out_boarding_content.dart';

class OutBoardingScreen extends StatefulWidget {
  const OutBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OutBoardingScreen> createState() => _OutBoardingScreenState();
}

class _OutBoardingScreenState extends State<OutBoardingScreen> {
  int _currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // Called when this object is removed from the tree permanently.
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal, // by default horizontal.
              controller: _pageController,
              onPageChanged: (int value) {
                // when page is changed the value will be changed and we want to take advantage of this value to change the indicator's color below.
                setState(() {
                  _currentPageIndex = value;
                });
              },
              children: <Widget>[
                OutBoardingContent(
                    imagePath: "assets/images/out-boarding-screen1.png",
                    title: "All your favorites",
                    subTitle:
                        "Order from the best local restaurants with easy, on-demand delivery."),
                OutBoardingContent(
                    imagePath: "assets/images/out-boarding-screen2.png",
                    title: "Free delivery offers",
                    subTitle:
                        "Free delivery for new customers via Apple Pay and others payment methods."),
                OutBoardingContent(
                    imagePath: "assets/images/out-boarding-screen3.png",
                    title: "Choose your food",
                    subTitle:
                        "Easily find your type of food craving and you’ll get delivery in wide range."),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1, top: MediaQuery.of(context).size.height*0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PageViewIndicator(
                    marginEnd: 10, selected: _currentPageIndex == 0),
                PageViewIndicator(
                    marginEnd: 10, selected: _currentPageIndex == 1),
                PageViewIndicator(selected: _currentPageIndex == 2),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(
                bottom: 75, start: 20, end: 20),
            child: ElevatedButton(
              onPressed: () => // FatArrow Function
                  Navigator.pushNamed(context, "/login_screen"),
              child: Text(
                "Get Started".toUpperCase(),
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: colors.buttonColorGreen,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
