import 'package:flutter/material.dart';
import 'package:jazzed/backend/event/event.dart';
import 'package:jazzed/backend/event/event_provider.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: HomeUI()
    );
  }
}

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventsProvider = Provider.of<EventProvider>(context);

    if (!eventsProvider.success && !eventsProvider.attempting) {
      eventsProvider.getEvents();
    }

    Widget placeHolder = Container(
      child: Center(child: Text("attempting: ${eventsProvider.attempting.toString()}")),
    );

    Widget widgetReturned = placeHolder;

    eventsProvider.success == true ? widgetReturned = EventList(
      events: eventsProvider.events,
    ) : widgetReturned = placeHolder;

    return widgetReturned;
  }
}

class EventList extends StatelessWidget {

  final List<Event> events;
  EventList({this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(events[index].name),
        );
      },
    );
  }
}
