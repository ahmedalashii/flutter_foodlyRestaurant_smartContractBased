// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "../constants/colors.dart" as colors;

class ChoicesList extends StatefulWidget {
  ChoicesList({
    Key? key,
    required this.list,
    required this.selectedGroupValue,
  }) : super(key: key);

  final List? list;
  int? selectedGroupValue;

  @override
  State<ChoicesList> createState() => _ChoicesListState();
}

class _ChoicesListState extends State<ChoicesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        bool isItTheLastItem = (index == widget.list!.length - 1);
        return Column(
          children: [
            InkWell(
              splashColor: colors.buttonColorGreen,
              onTap: () {
                setState(() {
                  widget.selectedGroupValue = index;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 15, bottom: 15, right: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      width: 35,
                      height: 35,
                      child: Container(
                        decoration: BoxDecoration(
                          color: (widget.selectedGroupValue == index)
                              ? colors.buttonColorGreen
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade300,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.list![index],
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Raleway",
                      color: Colors.black87.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 3,
            ),
            (isItTheLastItem) ? const SizedBox(height: 20) : const SizedBox(),
          ],
        );
      },
    );
  }
}