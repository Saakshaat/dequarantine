import 'package:dequarantine/logic/functions/auth/shared_prefs.dart';
import 'package:dequarantine/logic/functions/auth/sign_in_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoginSplash extends StatefulWidget {
  LoginSplash({@required this.mode});

  final int mode;

  @override
  _LoginSplashState createState() => _LoginSplashState();
}

class _LoginSplashState extends State<LoginSplash> {

  @override
  Widget build(BuildContext context) {
    switch (widget.mode) {
      case 0:
        logInFromSavedEmail(context);
        break;
      case 1:
        
    }
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),  
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Dequarantine", style: Theme.of(context).textTheme.headline1,),
            SizedBox(height: 5,),
            Text("Signing you in"),
            SizedBox(height: 15,),
            SpinKitWave(color: Colors.black, size: 30,),
          ],
        )
      ),
    );
  }
}