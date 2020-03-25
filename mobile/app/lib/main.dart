import 'package:app/data.dart';
import 'package:app/discover.dart';
import 'package:app/liked.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
// import 'package:simple_gesture_detector/simple_gesture_detector.dart';

Data data = Data();

void main() {
  runApp(MaterialApp(
    home: Material(child:MyApp()),
    theme: ThemeData(
      fontFamily: "segoeuil"
    ),
    // darkTheme: ThemeData(
    //   brightness: Brightness.dark,
    //   primaryColor: Colors.black,
    //   accentColor: Colors.blueGrey,
    // ),
  ));
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color backgroundSwipe = Colors.grey;

  int _selectedIndex = 1;

  List _pages = <Widget>[
    Liked(),
    Discover(),
    Container(child: Center(child: Text("Live updates"),))
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: IndexedStack(
      //   children: _pages,
      //   index: _selectedIndex,
      // ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: Duration(milliseconds: 100),
              tabBackgroundColor: Color.fromRGBO(0, 67, 164, 1),
              curve: Curves.linear,
              tabs: [
                GButton(
                  icon: LineIcons.heart,
                  text: "Upcoming",
                ),
                GButton(
                  icon: LineIcons.newspaper_o,
                  text: "Discover",
                ),
                GButton(
                  icon: LineIcons.check_square_o,
                  text: "Live Updates",
                )
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

