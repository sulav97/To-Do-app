import 'package:flutter/material.dart';

Color primary = const Color(0xFFFAFAFA);

class style {
  static Color primaryColor = primary;
  static Color yellow = const Color(0xFFFFAD47);
  static Color green = const Color(0xFF064F60);
  static Color lightgreen = Color.fromARGB(255, 25, 100, 117);
  static Color bgColor = const Color(0xFFeeedf2);
  static Color darkGray = const Color.fromARGB(255, 46, 46, 46);

  static TextStyle textStyleBlack =
      TextStyle(fontSize: 26, color: darkGray, fontWeight: FontWeight.w500);
  static TextStyle textStyle =
      TextStyle(fontSize: 26, color: green, fontWeight: FontWeight.w500);
  static TextStyle textStyleWhite =
      TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.w500);
  static TextStyle textStyleyellow =
      TextStyle(fontSize: 26, color: yellow, fontWeight: FontWeight.w500);
  static TextStyle headLine2 = const TextStyle(
      fontSize: 21, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle headLine3 = TextStyle(
      fontSize: 17, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
  static TextStyle headLinelightgreen =
      TextStyle(fontSize: 17, color: lightgreen, fontWeight: FontWeight.w500);
  static TextStyle headLinelgray =
      TextStyle(fontSize: 17, color: darkGray, fontWeight: FontWeight.w500);
}
