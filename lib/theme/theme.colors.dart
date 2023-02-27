import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
    fontFamily: 'Cairo',
    primaryColor: ThemeColors.primaryColor,
    appBarTheme: AppBarTheme(color: ThemeColors.primaryColor));

class ThemeColors {
  static Color primaryColor = Colors.blue;
  static Color primaryBgColor = const Color.fromARGB(255, 242, 236, 242);
  static Color lightPrimaryColor = const Color.fromARGB(255, 248, 206, 255);
  static Color greyColor2 = const Color(0xFFE8E8E8);
  // static Color secundaryColor = const Color(0xff5B6589);
  // static Color backgroundColor = const Color(0xffF5F5F5);
}
