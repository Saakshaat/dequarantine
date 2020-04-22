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
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Jazzed",
                        style: theme.textTheme.appBarTitle.merge(TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (currentUser == null) {
                          Navigator.of(context).pushNamedAndRemoveUntil('/entry', (route) => false);
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: theme.colorTheme.electricBlue,
                        foregroundColor: Colors.black,
                        child: Text(currentUser == null ? "" : currentUser.credentials.userName[0]) 
                      ),
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
