import "package:flutter/material.dart";
import "../../constants/colors.dart" as colors;
import '../../widgets/code_text_field.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  const VerifyPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  @override
  void initState() {
    super.initState();
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pushReplacementNamed(
              context, "/adding_phone_number_screen"),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Log into Foodly",
          style: TextStyle(
              color: colors.titleColor, fontFamily: "Raleway", fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.035),
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text(
                "Verify phone number",
                style: TextStyle(
                  color: colors.titleColor,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Enter the 4-Digit code sent to you at +970592195200",
                style: TextStyle(
                  color: colors.subTitleColor,
                  fontSize: 18,
                  fontFamily: "Raleway",
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: CodeTextField(
                  codeTextController: _firstCodeTextController,
                  focusNode: _firstFocusNode,
                  onChanged: (String value) {
                    if (value.isNotEmpty) _secondFocusNode.requestFocus();
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CodeTextField(
                  codeTextController: _secondCodeTextController,
                  focusNode: _secondFocusNode,
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _thirdFocusNode.requestFocus();
                    } else {
                      _firstFocusNode.requestFocus();
                    }
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CodeTextField(
                  codeTextController: _thirdCodeTextController,
                  focusNode: _thirdFocusNode,
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _fourthFocusNode.requestFocus();
                    } else {
                      _secondFocusNode.requestFocus();
                    }
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CodeTextField(
                  codeTextController: _fourthCodeTextController,
                  focusNode: _fourthFocusNode,
                  onChanged: (String value) {
                    if (value.isEmpty) _thirdFocusNode.requestFocus();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "/find_restaurants_near_screen"),
            child: Text(
              "Continue".toUpperCase(),
              style: const TextStyle(
                fontFamily: "Raleway",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: colors.buttonColorGreen,
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Didn't receive code?",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 5),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/register_screen"),
                child: const Text(
                  "Resend Again.",
                  style: TextStyle(
                      color: colors.buttonColorGreen,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "By Signing up you agree to our Terms Conditions & Privacy Policy.",
              style: TextStyle(
                  color: colors.subTitleColor,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Raleway"),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
