import 'package:dequarantine/UI/widgets/logins/outline_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
          
class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    double paddingVertical = MediaQuery.of(context).size.height * 0.10;
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.15;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //TODO: wait for backend problems to be resolved
          // GoogleSignInButton(
          //   onPressed: () async {
          //     bool loggedIn = await login.googleLogin();
          //     if (loggedIn) {
          //       Navigator.pushReplacementNamed(
          //         context,
          //         "/home",
          //       );
          //     }
          //   },
          // ),

          Center(child: Text("Dequarantine", style: Theme.of(context).textTheme.headline1,)),

          Text("Find online events that rejuvenate you.", style: Theme.of(context).textTheme.bodyText1,),

          Text("Connect to your community and wellbeing during Quarantine.", style: Theme.of(context).textTheme.bodyText1,),

          OutlineButtonLandingPage(
            text: "Sign in with email",
            route: "/email",
            pop: true,
          ),

          OutlineButtonLandingPage(
            text: "Continue without signing in",
            route: "/home",
            pop: false
          ),
        ],
      ),
    );
  }
}