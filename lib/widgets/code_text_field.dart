import "package:flutter/material.dart";
import "../../constants/colors.dart" as colors;

class CodeTextField extends StatelessWidget {

  final TextEditingController codeTextController;
  final FocusNode focusNode;
  final void Function(String value) onChanged;

  const CodeTextField({
    Key? key,
    required this.codeTextController,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: colors.buttonColorGreen,
      controller: codeTextController,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      maxLength: 1,
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.shade500,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.shade500,
          ),
        ),
      ),
      style: const TextStyle(color: Colors.black87, fontFamily: "Raleway"),
    );
  }
}
