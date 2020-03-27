import 'package:DribbleUI/discover.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    Color active = Colors.white;
    Color rest = Theme.of(context).primaryColor;
    return Scaffold(
      body: Discover(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GNav(
          gap: 8,
          activeColor: Colors.white,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          duration: Duration(milliseconds: 300),
          tabBackgroundColor: Theme.of(context).primaryColor,
          tabs: [
            GButton(
              iconActiveColor: active,
              iconColor: rest,
              icon: LineIcons.heart_o,
              text: 'My Events',
            ),
            GButton(
              iconActiveColor: active,
              iconColor: rest,
              icon: LineIcons.search,
              text: 'Discover',
            ),
            GButton(
              iconActiveColor: active,
              iconColor: rest,
              icon: LineIcons.th_list,
              text: 'Live',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
      ),
    );
  }
}