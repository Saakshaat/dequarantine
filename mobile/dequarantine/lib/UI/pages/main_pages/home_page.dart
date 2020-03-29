
import 'package:dequarantine/UI/pages/main_pages/account.dart';
import 'package:dequarantine/UI/pages/main_pages/create.dart';
import 'package:dequarantine/UI/pages/main_pages/discover.dart';
import 'package:dequarantine/UI/pages/main_pages/likes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 2;

  List<Widget> _pages = [
    Likes(),
    Create(),
    Discover(),
    Account()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
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
              icon: LineIcons.plus,
              text: 'Create',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Discover',
            ),
            GButton(
              icon: LineIcons.info_circle,
              text: 'Account',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }
        ),
      ),
    );
  }
}