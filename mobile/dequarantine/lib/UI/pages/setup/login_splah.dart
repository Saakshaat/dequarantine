import 'package:dequarantine/logic/functions/auth/shared_prefs.dart';
import 'package:dequarantine/logic/functions/auth/sign_in_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoginSplash extends StatefulWidget {
  @override
  _LoginSplashState createState() => _LoginSplashState();
}

class _LoginSplashState extends State<LoginSplash> {
  //LOGIN HERE
  void logIn() async {
    String email = await readFromShared("email");
    String password = await readFromShared("password");

    var funcResponse = await signInWithEmail(email, password);

    Map<String, dynamic> resp = Map.from(funcResponse);

    bool code = resp["code"];
    if (code) {
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    logIn();
  }


  @override
  Widget build(BuildContext context) {
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