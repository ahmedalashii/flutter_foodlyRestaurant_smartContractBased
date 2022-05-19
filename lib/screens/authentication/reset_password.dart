// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import "../../constants/colors.dart" as colors;

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = navigateToHavingProblem;
  }

  @override
  void dispose() {
    super.dispose();
    _tapGestureRecognizer.dispose();
  }

  void navigateToHavingProblem() {
    Navigator.pushNamed(context, "/register_screen"); // instead of register_screen >> having_problems
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, "/forget_password_screen"),
          icon: Icon(Icons.arrow_back_ios),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Forgot Password",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Reset email sent",
              style: TextStyle(
                color: colors.titleColor,
                fontSize: 35,
              ),
            ),
            SizedBox(height: 10),
            // Text(
            //   "We have sent an instructions email to\n someEmail@gmail.com. ",
            //   style: TextStyle(
            //       color: colors.subTitleColor,
            //       fontSize: 18,
            //       fontFamily: "Raleway"),
            // ),

            RichText(
              text: TextSpan(
                text: "We have sent an instructions email to\n someEmail@gmail.com.",
                style: TextStyle(
                    color: colors.subTitleColor,
                    fontSize: 16,
                    fontFamily: "Raleway"),
                children: <InlineSpan>[
                  TextSpan(text: "  "),
                  TextSpan(
                    recognizer: _tapGestureRecognizer,
                    text: "Having Problem?",
                    style: TextStyle(
                        color: colors.buttonColorGreen,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => // FatArrow Function
              Navigator.pushReplacementNamed(context, "/reset_password_screen"),
              child: Text(
                "Send again".toUpperCase(),
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
