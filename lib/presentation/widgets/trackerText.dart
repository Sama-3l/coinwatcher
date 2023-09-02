import 'package:coinwatcher/constants/font.dart';
import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';

class TrackerText extends StatefulWidget {
  TrackerText(
      {super.key,
      required this.amount,
      required this.isTotal,
      required this.theme,
      required this.font});

  bool isTotal;
  double amount;
  LightMode theme;
  FontFamily font;

  @override
  State<TrackerText> createState() => _TrackerTextState();
}

class _TrackerTextState extends State<TrackerText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isTotal ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 1, right: 5),
            child: Text(
              '\u20B9',
              style: widget.font.getPoppinsTextStyle(
                  color: widget.theme.textPrimary,
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.41),
            ),
          ),
          Text(
            widget.amount.toInt().toString(),
            style: widget.font.getPoppinsTextStyle(
                color: widget.theme.textPrimary,
                fontSize: 30,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.41),
          ),
        ]),
        Text(
          widget.isTotal ? 'Total Budget' : 'Spent so far',
          style: widget.font.getPoppinsTextStyle(
              color: widget.theme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.41),
        ),
      ],
    );
  }
}
