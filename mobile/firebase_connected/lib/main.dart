import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


final firestoreDB = Firestore.instance;

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      // theme: ThemeData(
      //   fontFamily: "segoeuil"
      // ),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List tags = [
    "frontend",
    "backend",
    "git",
    "social",
  ];

  Color category(int index) {
    Color background;
    switch (index) {
      case 1:
        background = Colors.yellow[400];
        break;
      case 2:
        background = Colors.green[400];
        break;
      case 3:
        background = Colors.red[400];
        break;
      case 0:
        background = Colors.blue[400];
        break;
    }

    return background;
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Dequarantined Events", style: TextStyle(fontSize: 30),),
        ),
        body: StreamBuilder(
          stream: firestoreDB.collection("events").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error.toString()}"),);
            switch (snapshot.connectionState){
              case ConnectionState.waiting: return Center(child: Text("Loading..."),);
              case ConnectionState.done: return Center(child: Text("Done: ${snapshot.data.toString()}"),);
              default:
                return ListView(
                  // padding: EdgeInsets.symmetric(horizontal: 5, vertical: ),
                  children: snapshot.data.documents
                    .map<Widget>((DocumentSnapshot doc) {
                      print(tags.indexOf(doc["tags"][0]));
                      return Container(
                        margin:  EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(),
                          // color: category(tags.indexOf(doc["tags"][0])),
                        ),
                        child: ListTile(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              String imageUrl = "https://source.unsplash.com/500x300/?";
                              doc["tags"].forEach((tag) => imageUrl += "${tag.toString()},");
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(doc["title"], style: Theme.of(context).textTheme.headline5,),
                                    Text("Description: ${doc["description"]}", style: Theme.of(context).textTheme.bodyText2),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(imageUrl)
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: category(tags.indexOf(doc["tags"][0])),
                            ),
                            width: 20,
                          ),
                          title: Text(doc["title"]),
                          subtitle: new Text(doc['tags'].toString()),
                        ),
                      );
                    }).toList(),
                );
            }
          }
        ),
      )
    );
  }
}