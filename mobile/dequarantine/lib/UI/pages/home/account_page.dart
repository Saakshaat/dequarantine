import 'package:dequarantine/UI/widgets/general/button.dart';
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
    userData["attending"] = data["credentials"]["attending"].length.toString();
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
      SafeArea(
        child: FutureBuilder(
        future: currentUser.getAccountData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            _buildUserData(snapshot.data);

            return Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            userData["userName"].toString(),
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            userData["email"],
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          CustomButton(
                            onPress: () => null,
                            text: "Edit account details",
                          )
                        ],
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage("https://interactive-examples.mdn.mozilla.net/media/examples/grapefruit-slice-332-332.jpg"),
                        radius: MediaQuery.of(context).size.width / 7,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Ready ?"),
                          Text("Attended")
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.white,
                        width: 3,
                        child: Text(""),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(userData["attending"], style: Theme.of(context).textTheme.bodyText2,),
                          Text("Upcoming")
                        ],
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  text: "My events",
                  onPress: () => null,
                ),
                CustomButton(
                  text: "Manage my event",
                  onPress: () => null,
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
      ),
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
