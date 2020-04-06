import 'package:dequarantine/UI/pages/home/category_pages/today.dart';
import 'package:dequarantine/UI/widgets/events/events_view.dart';
import 'package:dequarantine/main.dart';
import 'package:flutter/material.dart';

class LikesPage extends StatefulWidget {
  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  // List<Widget> _pages = [
  //   Today(),
  //   Upcoming(),
  // ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("My events"),
          bottom: PreferredSize(
            preferredSize: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.03,
            ),
            child: Container(
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Theme.of(context).buttonColor,
                labelStyle: Theme.of(context).textTheme.bodyText1,
                labelPadding: EdgeInsets.only(bottom: 5, top: 5),
                tabs: <Widget>[
                  Text("Today"),
                  Text("Upcoming")
                ],
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: currentUser.getAccountData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              DateTime today = DateTime.now();

              List eventsToday = [];
              List eventsUpcoming = [];

              snapshot.data["attending"].forEach((event) {
                DateTime time = DateTime.parse(event["time"]);
                if (time.compareTo(today) == 0) {
                  eventsToday.add(event);
                } else {
                  eventsUpcoming.add(event);
                }
              });
              return TabBarView(
                children: <Widget>[
                  Events(
                    events: eventsToday,
                    length: eventsToday.length,
                  ),
                  Events(
                    events: eventsUpcoming,
                    length: eventsUpcoming.length,
                  )
                ],
              );
            }
            return TabBarView(
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
