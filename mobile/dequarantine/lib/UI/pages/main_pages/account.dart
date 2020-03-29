import 'package:dequarantine/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String username = "currentUser";

  Future<String> getUserDetails() async {
    String name = "";
    Future.delayed(Duration(seconds: 1), () {
      name = "Germain Leignel";
    });

    return name;
  }


  void _signOut() {
    currentUser.signOut();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false);
    });
  }

  TextStyle _numTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    Map userData = currentUser.get();
    return Container(
      child: FutureBuilder(
        future: getUserDetails(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://vignette.wikia.nocookie.net/gtawiki/images/7/70/CJ-GTASA.png/revision/latest/top-crop/width/360/height/360?cb=20190612091918"),
                child: Text("GL"),
                foregroundColor: Colors.transparent,
                minRadius: MediaQuery.of(context).size.width / 8,
                maxRadius: MediaQuery.of(context).size.width / 8,
              ),
              Text("Germain Leignel", style: Theme.of(context).textTheme.headline1,),
              Text(
                userData["email"],
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("6", style: _numTextStyle,),
                      Text("Past events", style: Theme.of(context).textTheme.bodyText2,),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("8", style: _numTextStyle,),
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
                child: Text("Sign out", style: TextStyle(color: Colors.white),),
                onPressed: () => _signOut(),
              )
            ],
          );
        },
      ),
    );
  }
}
