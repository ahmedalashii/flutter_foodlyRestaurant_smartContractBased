// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import "../../constants/colors.dart" as colors;

class AddingPhoneNumberScreen extends StatefulWidget {
  const AddingPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<AddingPhoneNumberScreen> createState() =>
      _AddingPhoneNumberScreenState();
}

class _AddingPhoneNumberScreenState extends State<AddingPhoneNumberScreen> {
  late TextEditingController _emailTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, "/register_screen"),
          icon: Icon(Icons.arrow_back_ios),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Log into Foodly",
          style: TextStyle(
              color: colors.titleColor, fontFamily: "Raleway", fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Get started with Foodly",
              style: TextStyle(
                color: colors.titleColor,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Enter your phone number to use foodly and enjoy your food :)",
              style: TextStyle(
                color: colors.subTitleColor,
                fontSize: 18,
                fontFamily: "Raleway",
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber? phoneNumber) {},
              textStyle: TextStyle(
                color: colors.subTitleColor,
                fontFamily: "Raleway",
              ),
              spaceBetweenSelectorAndTextField: 8,
              selectorTextStyle: TextStyle(
                color: colors.subTitleColor,
                fontFamily: "Raleway",
              ),
              inputDecoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: colors.buttonColorGreen),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, "/verify_phone_number_screen"),
              child: Text(
                "Next".toUpperCase(),
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: colors.buttonColorGreen,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
