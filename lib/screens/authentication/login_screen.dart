// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import "../../constants/colors.dart" as colors;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TapGestureRecognizer _tapGestureRecognizer;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = navigateToRegisterScreen;
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tapGestureRecognizer.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  void navigateToRegisterScreen() {
    Navigator.pushNamed(context, "/register_screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, "/out_boarding_screen"),
          icon: Icon(Icons.arrow_back_ios),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Sign in",
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
              "Welcome To",
              style: TextStyle(
                color: colors.titleColor,
                fontSize: 35,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Enter your Phone number or Email\naddress for sign in. Enjoy your food :)",
              style: TextStyle(
                  color: colors.subTitleColor,
                  fontSize: 18,
                  fontFamily: "Raleway"),
            ),

            // RichText(
            //   text: TextSpan(
            //     text: "Enter your Phone number or Email\nfor sign in, Or",
            //     style: TextStyle(
            //         color: colors.subTitleColor,
            //         fontSize: 16,
            //         fontFamily: "Raleway"),
            //     children: <InlineSpan>[
            //       TextSpan(text: "  "),
            //       TextSpan(
            //         recognizer: _tapGestureRecognizer,
            //         text: "Create new account.",
            //         style: TextStyle(
            //             color: colors.buttonColorGreen,
            //             fontWeight: FontWeight.w500),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 30),
            buildEmailTextField(
                controller: _emailTextController,
                labelText: "Email Address",
                iconData: Icons.check),
            SizedBox(height: 15),
            buildPasswordTextField(
              controller: _passwordTextController,
              labelText: "Password",
              iconData: Icons.visibility_off_rounded,
            ),
            SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/forget_password_screen"),
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/bottom_nav_screen"),
              child: Text(
                "Sign in".toUpperCase(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/register_screen"),
                  child: Text(
                    "Create new account.",
                    style: TextStyle(
                        color: colors.buttonColorGreen,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
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
                    Text("Sign in with facebook".toUpperCase(),
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
                    Text("Sign in with google".toUpperCase(),
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

  TextField buildEmailTextField(
      {required TextEditingController controller,
      required String labelText,
      required IconData iconData}) {
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
