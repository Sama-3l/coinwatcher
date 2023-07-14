import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({super.key, required this.theme, required this.font});
  FontFamily font;
  LightMode theme;
  List<String> list = <String>['Jan 2023', 'Feb 2023', 'Mar 2023', 'Apr 2023'];
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late String dropdownValue = widget.list.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: widget.font.getPoppinsTextStyle(
          color: widget.theme.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
