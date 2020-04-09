import 'package:dequarantine/main.dart';
import 'package:flutter/material.dart';

class MyEventsDetails extends StatelessWidget {
  final title;
  final attendees;
  final totalAttendents;
  final description;
  final dateTime;
  final eventId;

  MyEventsDetails({
    @required this.title,
    @required this.attendees,
    @required this.totalAttendents,
    @required this.description,
    @required this.dateTime,
    @required this.eventId,
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
              Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                "${attendees.toString()} / ${totalAttendents.toString()}",
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),Divider(),
          Text(description),
          Divider(),
          Text("${dateTime.year.toString()} / ${dateTime.month.toString()} / ${dateTime.day.toString()} at ${dateTime.hour.toString()}:${dateTime.minute.toString()}"),
          Divider(),
          Center(
            child: InkWell(
              onTap: () {
                currentUser.markUnattending(eventId);
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // IconButton(
                    //   color: Colors.redAccent,
                    //   icon: Icon(LineIcons.sign_out),
                    //   onPressed: () {
                    //     print("Dismissed");
                    //     Navigator.pop(context);
                    //   },
                    // ),
                    Text(
                      "Remove from my event",
                      style: Theme.of(context).textTheme.bodyText1.merge(
                          TextStyle(
                              color: Theme.of(context)
                                  .sliderTheme
                                  .activeTrackColor)),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
