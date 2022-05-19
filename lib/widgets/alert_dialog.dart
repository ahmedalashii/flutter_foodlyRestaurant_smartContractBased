import 'package:flutter/material.dart';
import "../constants/colors.dart" as colors;
import "../constants/orders.dart" as orders;

class MyAlertDialog extends StatefulWidget {
  const MyAlertDialog(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.circleIcon = Icons.check,
      this.circleColor = colors.buttonColorGreen})
      : super(key: key);

  final String title, subTitle;
  final IconData circleIcon;
  final Color circleColor;

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          insetPadding: EdgeInsets.fromLTRB(
              40.0,
              (!widget.title.toLowerCase().contains("placed"))
                  ? MediaQuery.of(context).size.height * 0.13
                  : ((widget.title.toLowerCase().contains("to pay for")) ? MediaQuery.of(context).size.height * 0.10: MediaQuery.of(context).size.height * 0.18),
              40.0,
              40.0),
          titlePadding: EdgeInsets.fromLTRB(
              40.0, MediaQuery.of(context).size.height * 0.07, 40.0, 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(widget.title,
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Raleway",
                color: Colors.black87.withOpacity(0.8),
              ),
              textAlign: TextAlign.center),
          content: Text(
            widget.subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontFamily: "Raleway",
              color: Colors.black54,
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    orders.orderedFoodItems.clear();
                  });
                },
                child: const Text(
                  'KEEP BROWSING',
                  style: TextStyle(
                    color: colors.buttonColorGreen,
                    fontSize: 16,
                    fontFamily: "Raleway",
                  ),
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 3.4,
          right: MediaQuery.of(context).size.width * 0.001,
          left: MediaQuery.of(context).size.width * 0.001,
          child: Container(
            width: 70,
            height: 70,
            child: Icon(widget.circleIcon, size: 30, color: Colors.white),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.circleColor,
            ),
          ),
        ),
      ],
    );
  }
}
