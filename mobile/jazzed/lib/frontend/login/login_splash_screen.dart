import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:jazzed/main.dart';

class LoginSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Dequarantine",
              style: theme.textTheme.headline1,
            ),
            SizedBox(
              height: 5,
            ),
            Text("Signing you in"),
            SizedBox(
              height: 15,
            ),
            SpinKitWave(
              color: Colors.black,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
