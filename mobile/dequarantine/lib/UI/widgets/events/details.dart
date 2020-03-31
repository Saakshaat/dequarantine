import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';


class Details extends StatelessWidget {
  final title;
  final attendees;
  final totalAttendents;
  final description;
  final dateTime;

  Details({
    @required this.title,
    @required this.attendees,
    @required this.totalAttendents,
    @required this.description,
    @required this.dateTime
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.headline5,),
              Text("${attendees.toString()} / ${totalAttendents.toString()}", style: Theme.of(context).textTheme.bodyText2,)
            ],
          ),
          Text(description),
          Text(dateTime),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                color: Colors.redAccent,
                icon: Icon(LineIcons.sign_out),
                onPressed: () {
                  print("Dismissed");
                  Navigator.pop(context);  
                },
              ),
              IconButton(
                color: Colors.greenAccent,
                icon: Icon(LineIcons.check),
                onPressed: () {
                  print("Liked");
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}