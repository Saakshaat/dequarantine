import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {

  final String text;
  final void Function() onPress;

  CustomButton({
    @required this.text,
    @required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Theme.of(context).buttonColor,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPress,
    );
  }
}