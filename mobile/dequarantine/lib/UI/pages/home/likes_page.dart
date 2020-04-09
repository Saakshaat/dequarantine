import 'package:dequarantine/UI/pages/home/category_pages/today.dart';
import 'package:dequarantine/UI/widgets/events/events_view.dart';
import 'package:dequarantine/UI/widgets/events/my_events/my_events.dart';
import 'package:dequarantine/main.dart';
import 'package:flutter/material.dart';

class LikesPage extends StatefulWidget {
  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    if (currentUser != null) {
      setState(() {
        isUserLoggedIn = true;
      });
    } else {
      setState(() {
        isUserLoggedIn = false;
      });
    }
  }

  Widget loggedIn(){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
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
          future: currentUser.getAttendingEvents(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {

              List eventsToday = [];
              List eventsUpcoming = [];

              DateTime today = DateTime.now().toLocal();
              
              snapshot.data.forEach((event) {
                DateTime time = DateTime.parse(event["startTime"]).toLocal();

                int todayDay = today.day;

                int timeDay = time.day;

                if (todayDay == timeDay) {
                  eventsToday.add(event);
                } else {
                  eventsUpcoming.add(event);
                }
              });
              return TabBarView(
                children: <Widget>[
                  MyEvents(
                    events: eventsToday,
                    length: eventsToday.length,
                  ),
                  MyEvents(
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

  Widget loggedOut() {
    return Container(
      child: Center(
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Theme.of(context).buttonColor,
          child: Text(
            "Sign in",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            "/login",
            (Route<dynamic> route) => false
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isUserLoggedIn ? loggedIn() : loggedOut();
  }
}


