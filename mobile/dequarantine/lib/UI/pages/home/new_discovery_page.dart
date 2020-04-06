import 'package:dequarantine/UI/pages/home/category_pages/category_page.dart';
import 'package:dequarantine/UI/widgets/events/category_button.dart';
import 'package:dequarantine/UI/widgets/events/category_event_view.dart';
import 'package:dequarantine/UI/widgets/events/events_view.dart';
import 'package:dequarantine/logic/functions/general/get_events_functions.dart';
import 'package:dequarantine/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  ScrollController _scrollController;

  @override
  void initState(){
    super.initState();
    _scrollController = ScrollController();
  }

  List<Widget> pages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Dequrantine"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () => print("Open account page"),
          )
        ],
      ),
      body: FutureBuilder(
        future: getEventsByCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data;

            List categories = [];

            data.forEach((key, value) {
              if (key != "code") {
                if (!categories.contains(key)) categories.add(key);

                pages.add(
                  CategoryPage(
                    title: key,
                    widgets: data[key],
                  )
                );
              }
            });




            return PageView(
              scrollDirection: Axis.vertical,
              pageSnapping: true,
              children: pages,
            );

            // return SingleChildScrollView(
            //   controller: _scrollController,
            //   child: Container(
            //     padding: EdgeInsets.all(8),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Text("Welcome, ${currentUser.getUserName()}", style: Theme.of(context).textTheme.headline2,),

            //         SizedBox(
            //           height: 10,
            //         ),

            //         Text(
            //           "Browse some events while you stay at home to better yourself or simply pass time"
            //         ),

            //         SizedBox(
            //           height: 10,
            //         ),

            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: <Widget>[
            //             CategoryButton(
            //               category: "Fitness",
            //               icon: Icons.directions_run,
            //               onTap: () => null,
            //               events: data["Fitness"]
            //             ),
            //             CategoryButton(
            //               category: "Education",
            //               icon: Icons.school,
            //               onTap: () => null,
            //               events: data["Educational"]
            //             ),
            //             CategoryButton(
            //               category: "Gaming",
            //               icon: Icons.games,
            //               onTap: () => null,
            //               events: data["Gaming"]
            //             ),
            //             CategoryButton(
            //               category: "Entertainment",
            //               icon: Icons.local_movies,
            //               onTap: () => null,
            //               events: data["Entertainment"]
            //             ),
            //           ],
            //         ),

            //         SizedBox(
            //           height: 20,
            //         ),

            //         CategoryRowEvents(
            //           title: "Happening in Fitness",
            //           events: [],
            //           backgroundColor: Colors.cyan
            //         ),

            //         SizedBox(
            //           height: 20,
            //         ),

            //         CategoryRowEvents(
            //           title: "Happening in Education",
            //           events: [],
            //           backgroundColor: Colors.purpleAccent
            //         ),

            //         SizedBox(
            //           height: 20,
            //         ),

            //         CategoryRowEvents(
            //           title: "Happening in Gaming",
            //           events: [],
            //           backgroundColor: Colors.greenAccent
            //         ),

            //         SizedBox(
            //           height: 20,
            //         ),

            //         CategoryRowEvents(
            //           title: "Happening in Entertainment",
            //           events: [],
            //           backgroundColor: Colors.amberAccent
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        }),
    );
  }
}