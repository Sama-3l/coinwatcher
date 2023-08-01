//textcontroller & list

import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {
  register({super.key});
  late LightMode theme;
  late FontFamily font;

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          width: 0.78 * width,
          height: 0.06 * height,
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              hintText: 'Enter a search term',
            ),
          ),
        ),
      ]),
    );
  }
}
