import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontFamily {
  TextStyle getPoppinsTextStyle(
      {required Color color,
      required double fontSize,
      required FontWeight fontWeight,
      required double letterSpacing,
      double? height}) {
    return GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height);
  }
}
