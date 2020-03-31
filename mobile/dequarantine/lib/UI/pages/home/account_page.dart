import 'package:dequarantine/logic/functions/auth/sign_out_functions.dart';
import 'package:dequarantine/main.dart';
import 'package:flutter/material.dart';


class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isUserLoggedIn = false;


  TextStyle _numTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  Map userData = {};


  _buildUserData(data) {
    userData["email"] = data["credentials"]["email"];
    userData["userId"] = data["credentials"]["userId"];
    userData["userName"] = data["credentials"]["userName"];
    userData["imageUrl"] = data["credentials"]["imageUrl"];
    userData["attending"] = data["attending"].length;
  }

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      setState(() {
        isUserLoggedIn = true;
      });
    } else {
      setState(() {
        isUserLoggedIn = false;
      });
    }
  }


  


  @override
  Widget build(BuildContext context) {
    return isUserLoggedIn ? 
      FutureBuilder(
      future: currentUser.getAccountData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          _buildUserData(snapshot.data);

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.nicepng.com/png/detail/152-1529091_happy-smile-png-smiley-face-icon-png.png"),
                // child: Text("GL"),
                foregroundColor: Colors.transparent,
                minRadius: MediaQuery.of(context).size.width / 8,
                maxRadius: MediaQuery.of(context).size.width / 8,
              ),
              Text(
                userData["userName"],
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                userData["email"],
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Not done",
                        style: _numTextStyle,
                      ),
                      Text(
                        "Past events",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        userData["attending"].toString(),
                        style: _numTextStyle,
                      ),
                      Text("Upcoming events"),
                    ],
                  ),
                ],
              ),
              Text("Settings"),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Theme.of(context).buttonColor,
                child: Text(
                  "Sign out",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => signOut(context),
              ),
            ],
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    )
    :
    Container(
      child: Center(
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Theme.of(context).buttonColor,
          child: Text(
            "Sign in",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            "/login",
            (Route<dynamic> route) => false
          ),
        ),
      ),
    );
  }
}
