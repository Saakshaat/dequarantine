import 'package:flutter/material.dart';
import 'package:jazzed/backend/event/event.dart';
import 'package:jazzed/backend/event/event_provider.dart';
import 'package:jazzed/backend/navigation/navigation.dart';
import 'package:jazzed/frontend/app/my_events.dart';
import 'package:jazzed/frontend/app/create.dart';
import 'package:jazzed/frontend/app/widgets/appbar.dart';
import 'package:jazzed/frontend/app/widgets/events_card.dart';
import 'package:jazzed/frontend/app/widgets/navbar.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
        child: HomeUI()
      ),
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
      child: Center(
          child: Text("attempting: ${eventsProvider.attempting.toString()}")),
    );

    Widget widgetReturned = placeHolder;

    eventsProvider.success == true
        ? widgetReturned = HomeLoaded()
        : widgetReturned = placeHolder;

    return widgetReturned;
  }
}

class EventList extends StatelessWidget {
  final List<Event> events;
  EventList({this.events});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        return EventCard(event: events[index],);
      },
    );
  }
}

class HomeLoaded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventsProvider = Provider.of<EventProvider>(context);
    final navigationProvider = Provider.of<NavigationProvider>(context);

    final List<Widget> pages = [
      EventList(
        events: eventsProvider.events,
      ),
      MyEvents(),
      CreateEvent(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(500, 200),
        child: CustomAppBar(
          title: "Jazzed",
        ),
      ),
      body: pages.elementAt(navigationProvider.selectedPage),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
