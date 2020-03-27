import 'package:flutter/material.dart';


class CategoryButton extends StatelessWidget {

  CategoryButton({
    @required this.icon,
    @required this.text,
    @required this.backgroundColor,
    @required this.foregroundColor,
  });

  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      onPressed: () => null,
      color: backgroundColor,
      child: Row(
        children: <Widget>[
          Icon(icon, color: foregroundColor),
          SizedBox(width: 10),
          Text(text, style: TextStyle(color: foregroundColor)),
        ],
      ),
    );
  }
}