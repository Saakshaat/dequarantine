import 'package:flutter/material.dart';

class CustomTheme {
  CustomTextTheme textTheme = CustomTextTheme();
  CustomCardTheme cardTheme = CustomCardTheme();
  CustomColorTheme colorTheme = CustomColorTheme();
}

class CustomTextTheme {
  TextStyle title = TextStyle(fontSize: 40, fontStyle: FontStyle.italic);

  TextStyle headline1 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
}

class CustomCardTheme {}

class CustomColorTheme {
  Color electricBlue = Color.fromRGBO(0, 232, 252, 1);
  Color yellowRed = Color.fromRGBO(246, 189, 87, 1);
  Color blackCharcoal = Color.fromRGBO(84, 88, 99, 1);

  Color blue = Color.fromRGBO(36, 123, 160, 1);
  Color blueGreen = Color.fromRGBO(112, 193, 179, 1);
  Color dark = Color.fromRGBO(36, 58, 63, 1);
  Color pale = Color.fromRGBO(243, 255, 189, 1);
  Color red = Color.fromRGBO(255, 22, 84, 1);
}
