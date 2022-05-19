import "package:flutter/material.dart";
import "../../constants/colors.dart" as colors;
import '../../widgets/restaurants_widget.dart';

class FeaturedPartners extends StatefulWidget {
  const FeaturedPartners({Key? key}) : super(key: key);

  @override
  State<FeaturedPartners> createState() => _FeaturedPartnersState();
}

class _FeaturedPartnersState extends State<FeaturedPartners> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "/bottom_nav_screen"),
            icon: const Icon(Icons.arrow_back_ios, size: 18),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Featured Partners",
            style: TextStyle(
                color: colors.titleColor, fontFamily: "Raleway", fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: const SingleChildScrollView(
          child: Restaurants(reverse: true),
        ));
  }
}
