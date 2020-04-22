import 'package:flutter/material.dart';

class CustomTheme {
  CustomTextTheme textTheme = CustomTextTheme();
  CustomCardTheme cardTheme = CustomCardTheme();
  CustomColorTheme colorTheme = CustomColorTheme();
}

class CustomTextTheme {
  TextStyle title = TextStyle(
    fontSize: 40,
    fontStyle: FontStyle.italic
  );

  TextStyle headline1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500
  );
}

class CustomCardTheme {

}

class CustomColorTheme {
  Color electricBlue = Color.fromRGBO(0, 232, 252, 1);
  Color yellowRed = Color.fromRGBO(246, 189, 87, 1);
  Color blackCharcoal = Color.fromRGBO(84, 88, 99, 1);
}