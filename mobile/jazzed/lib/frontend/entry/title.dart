import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:jazzed/main.dart';

class TitleAndDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Jazzed", style: Theme.of(context).textTheme.headline1),
            SizedBox(height: 20),
            Text(
              "Stay motivated without leaving home",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 20),
            Text(
              "You are not alone during",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              "#socialdistancing",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
