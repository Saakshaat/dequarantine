
import 'package:dequarantine/pages/discover.dart';
import 'package:dequarantine/pages/likes.dart';
import 'package:dequarantine/pages/live.dart';
import 'package:dequarantine/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [
    Likes(),
    Discover(),
    Live(),
    Settings(),
  ];

  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          IndexedStack(
            index: _selectedIndex,
            children: pages,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.3))
                ],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    duration: Duration(milliseconds: 300),
                    tabBackgroundColor: Theme.of(context).buttonColor,
                    tabs: [
                      GButton(
                        icon: LineIcons.heart_o,
                        text: 'My Events',
                      ),
                      GButton(
                        icon: LineIcons.search,
                        text: 'Discover',
                      ),
                      GButton(
                        icon: LineIcons.outdent,
                        text: 'Live',
                      ),
                      GButton(
                        icon: LineIcons.ils,
                        text: 'Settings',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


