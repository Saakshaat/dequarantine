import 'package:flutter/material.dart';
import 'package:jazzed/main.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  CustomAppBar({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      color: theme.colorTheme.blackCharcoal,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Go get Jazzed",
                    style: theme.textTheme.headline1.merge(TextStyle(color: Colors.white)),
                  ),
                  GestureDetector(
                    onTap: () => null,
                    child: CircleAvatar(
                      backgroundColor: theme.colorTheme.electricBlue,
                      foregroundColor: Colors.black,
                      child: Text("GL"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
