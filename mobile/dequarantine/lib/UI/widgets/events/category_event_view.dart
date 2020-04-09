import 'package:flutter/material.dart';



class CategoryRowEvents extends StatefulWidget {
  final List events;
  final String title;
  final Color backgroundColor;

  CategoryRowEvents({
    @required this.events, 
    @required this.title,
    @required this.backgroundColor,
  });

  @override
  _CategoryRowEventsState createState() => _CategoryRowEventsState();
}

class _CategoryRowEventsState extends State<CategoryRowEvents> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(widget.title, style: Theme.of(context).textTheme.bodyText1,),
        ),
        Row(
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width * 0.80) - 8,
              height: (MediaQuery.of(context).size.width * 0.80 - 8) / 1.45,
              child: Card(
                color: widget.backgroundColor,
                child: Center(
                  child: Text("Event 1"),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: (MediaQuery.of(context).size.width * 0.20) -8 ,
                  height: (MediaQuery.of(context).size.width * 0.20) -8,
                  child: Card(
                    color: widget.backgroundColor,
                    child: Center(
                      child: Text("event 2"),
                    ),
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width * 0.20) -8 ,
                  height: (MediaQuery.of(context).size.width * 0.20) -8,
                  child: Card(
                    color: widget.backgroundColor,
                    child: Center(
                      child: Text("event 3"),
                    ),
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width * 0.20) -8 ,
                  height: (MediaQuery.of(context).size.width * 0.20) -8,
                  child: Card(
                    color: widget.backgroundColor,
                    child: Center(
                      child: Text("event 4"),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}