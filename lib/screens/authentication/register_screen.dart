// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import "../../constants/colors.dart" as colors;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TapGestureRecognizer _tapGestureRecognizer;
  late TextEditingController _fullNameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = navigateToLoginScreen;
    _fullNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tapGestureRecognizer.dispose();
    _fullNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  void navigateToLoginScreen() {
    Navigator.pushNamed(context, "/login_screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, "/login_screen"),
          icon: Icon(Icons.arrow_back_ios),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Sign up",
          style: TextStyle(
              color: colors.titleColor, fontFamily: "Raleway", fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Create Account",
              style: TextStyle(
                color: colors.titleColor,
                fontSize: 35,
              ),
            ),
            SizedBox(height: 10),
            // Text(
            //   "Enter your Name, Email and Password\nfor sign up.",
            //   style: TextStyle(
            //       color: colors.subTitleColor,
            //       fontSize: 18,
            //       fontFamily: "Raleway"),
            // ),

            RichText(
              text: TextSpan(
                text: "Enter your Name, Email and Password\nfor sign up.",
                style: TextStyle(
                    color: colors.subTitleColor,
                    fontSize: 16,
                    fontFamily: "Raleway"),
                children: <InlineSpan>[
                  TextSpan(text: "   "),
                  TextSpan(
                    recognizer: _tapGestureRecognizer,
                    text: "Already have account?",
                    style: TextStyle(
                        color: colors.buttonColorGreen,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            buildFullNameTextField(
                controller: _fullNameTextController, labelText: "Full Name"),
            SizedBox(height: 15),
            buildEmailTextField(
                controller: _emailTextController, labelText: "Email Address"),
            SizedBox(height: 15),
            buildPasswordTextField(
              controller: _passwordTextController,
              labelText: "Password",
              iconData: Icons.visibility_off_rounded,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context,"/adding_phone_number_screen"),
              child: Text(
                "Sign up".toUpperCase(),
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
            SizedBox(height: 20),
            Center(
              child: Text(
                "By signing up you agree to our Terms\nConditions & Privacy Policy",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Raleway",
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "or".toUpperCase(),
                style: TextStyle(
                    fontSize: 20, fontFamily: "Raleway", color: Colors.black54),
              ),
            ),
            SizedBox(height: 30),
            // First way to do a button:
            // ElevatedButton.icon(
            //   icon: Icon(Icons.facebook),
            //   onPressed: () {},
            //   label: Text(
            //     "Connect with facebook".toUpperCase(),
            //     style: TextStyle(
            //       fontFamily: "Raleway",
            //       fontSize: 16,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     primary: colors.facebookColor,
            //     minimumSize: Size(double.infinity, 50),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            // ),
            // Second way to do a button:
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colors.facebookColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset("assets/images/facebook-btn.png"),
                    ),
                    // Image.asset("assets/images/facebook-btn.png",
                    //     width: 40, height: 50),
                    // Icon(Icons.facebook, color: Colors.white, size: 25),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    Text("Sign up with facebook".toUpperCase(),
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colors.googleColor,
                ),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/google-btn.png",
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    Text("Sign up with google".toUpperCase(),
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField buildFullNameTextField(
      {required TextEditingController controller, required String labelText}) {
    return TextField(
      onChanged: (String value) {
        setState(() {});
      },
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: 1,
      maxLength: 50,
      cursorColor: colors.buttonColorGreen,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(25),
        counterText: "",
        labelText: labelText,
        labelStyle: TextStyle(
            color: colors.subTitleColor.withOpacity(0.8),
            fontWeight: FontWeight.normal,
            fontSize: 18),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey.withOpacity(0.05),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
              width: 1, color: Colors.grey.shade300, style: BorderStyle.solid),
        ),
        focusColor: colors.buttonColorGreen,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
              width: 1, color: Colors.grey.shade300, style: BorderStyle.solid),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 1, color: Colors.red.shade300, style: BorderStyle.solid),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 1, color: Colors.red.shade900, style: BorderStyle.solid),
        ),
      ),
      cursorWidth: 1.5,
      cursorHeight: 20,
      // style of the text (the content) to be written :
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontFamily: "Raleway",
      ),
    );
  }

  TextField buildEmailTextField(
      {required TextEditingController controller, required String labelText}) {
    return TextField(
      onChanged: (String value) {
        setState(() {});
      },
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      maxLines: 1,
      maxLength: 50,
      cursorColor: colors.buttonColorGreen,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(25),
        counterText: "",
        labelText: labelText,
        labelStyle: TextStyle(
            color: colors.subTitleColor.withOpacity(0.8),
            fontWeight: FontWeight.normal,
            fontSize: 18),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey.withOpacity(0.05),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
              width: 1, color: Colors.grey.shade300, style: BorderStyle.solid),
        ),
        focusColor: colors.buttonColorGreen,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
              width: 1, color: Colors.grey.shade300, style: BorderStyle.solid),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 1, color: Colors.red.shade300, style: BorderStyle.solid),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 1, color: Colors.red.shade900, style: BorderStyle.solid),
        ),
      ),
      cursorWidth: 1.5,
      cursorHeight: 20,
      // style of the text (the content) to be written :
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontFamily: "Raleway",
      ),
    );
  }

  TextField buildPasswordTextField(
      {required TextEditingController controller,
      required String labelText,
      required IconData iconData}) {
    return TextField(
      onChanged: (String value) {
        setState(() {});
      },
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: 1,
      obscureText: true,
      obscuringCharacter: "*",
      cursorColor: colors.buttonColorGreen,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(25),
        labelText: labelText,
        labelStyle: TextStyle(
            color: colors.subTitleColor.withOpacity(0.8),
            fontWeight: FontWeight.normal,
            fontSize: 18),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.grey.withOpacity(0.05),
        filled: true,
        suffixIcon: Icon(iconData, color: colors.buttonColorGreen),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
              width: 1, color: Colors.grey.shade300, style: BorderStyle.solid),
        ),
        focusColor: colors.buttonColorGreen,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
              width: 1, color: Colors.grey.shade300, style: BorderStyle.solid),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 1, color: Colors.red.shade300, style: BorderStyle.solid),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 1, color: Colors.red.shade900, style: BorderStyle.solid),
        ),
      ),
      cursorWidth: 1.5,
      cursorHeight: 20,
      // style of the text (the content) to be written :
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontFamily: "Raleway",
      ),
    );
  }
}
