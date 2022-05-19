// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "../../constants/colors.dart" as colors;

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
              Navigator.pushReplacementNamed(context, "/login_screen"),
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
              "Forgot Password",
              style: TextStyle(
                color: colors.titleColor,
                fontSize: 35,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Enter your email address and we will\nsend you a reset instructions.",
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
            ElevatedButton(
              onPressed: () => // FatArrow Function
                  Navigator.pushReplacementNamed(context, "/reset_password_screen"),
              child: Text(
                "Reset Password".toUpperCase(),
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
}
