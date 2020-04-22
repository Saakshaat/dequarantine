import 'package:flutter/material.dart';
import 'package:jazzed/backend/navigation/navigation.dart';

import 'package:jazzed/main.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class CustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<NavigationProvider>(context);
    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      color: theme.colorTheme.blackCharcoal,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: GNav(
          tabMargin: EdgeInsets.symmetric(horizontal: 8),
          gap: 8,
          activeColor: Colors.black,
          color: Colors.white,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: theme.colorTheme.electricBlue,
          selectedIndex: navigation.selectedPage,
          tabs: [
            GButton(
              icon: Icons.local_movies,
              text: "Events",
            ),
            GButton(
              icon: Icons.bookmark,
              text: "My events",
            ),
            GButton(
              icon: Icons.create,
              text: "Post",
            ),
          ],
          onTabChange: (int index) {
            navigation.changePage(index);
          },
        ),
      ),
    );
  }
}
