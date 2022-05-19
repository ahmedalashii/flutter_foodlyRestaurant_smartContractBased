// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import "../constants/colors.dart" as colors;

class PageViewIndicator extends StatelessWidget {
  final double marginEnd;
  final bool selected;

  PageViewIndicator({this.marginEnd = 0, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 5,
      margin: EdgeInsetsDirectional.only(end: marginEnd),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: (!selected) ? Colors.grey.shade300 : colors.pageViewIndicatorColor,
      ),
    );
  }
}
