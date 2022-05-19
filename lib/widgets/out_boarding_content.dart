// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "../constants/colors.dart" as colors;

class OutBoardingContent extends StatelessWidget {
  final String title, subTitle, imagePath;

  const OutBoardingContent(
      {required this.imagePath, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Image.asset(imagePath),
        // ClipOval(
        //   child: Image.asset(
        //     imagePath,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.045,
        ),
        Text(
          title,
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 35,
            color: colors.titleColor,
            // fontFamily: ,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Raleway",
              color: colors.subTitleColor,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
