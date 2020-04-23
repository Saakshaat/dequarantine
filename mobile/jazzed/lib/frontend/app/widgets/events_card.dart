import 'package:flutter/material.dart';
import 'package:jazzed/backend/event/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({@required this.event});

  String dateTimeDisplayed(DateTime eventStart) {
    String formatedDate = "";

    String hour = eventStart.hour.toString();
    String minute = eventStart.minute.toString();

    String day = eventStart.day.toString();
    String month = eventStart.month.toString();
    String year = eventStart.year.toString();

    formatedDate = "$day-$month-$year at $hour:$minute";

    return formatedDate;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print(event.link),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(event.imageUrl),
              Divider(indent: 5, endIndent: 5),
              Text(
                event.name,
                style: Theme.of(context).textTheme.headline2,
              ),
              Divider(indent: 5, endIndent: 5),
              Text(event.description),
              Text(dateTimeDisplayed(DateTime.parse(event.startTime).toLocal()))
            ],
          ),
        ),
      ),
    );
  }
}
