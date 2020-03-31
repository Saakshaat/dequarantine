import 'package:flutter/material.dart';


class OutlineButtonLandingPage extends StatelessWidget {
  final String route;
  final String text;
  final bool pop;

  OutlineButtonLandingPage({
    @required this.route,
    @required this.text,
    @required this.pop
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton (
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(text),
      onPressed: () {
        pop ? 
          Navigator.pushNamed(
            context,
            route
          ) : 
          Navigator.pushReplacementNamed(
            context,
            route
          );
        },
    );
  }
}